//
//  EditNoteViewController.m
//  UnNote
//
//  Created by lysongzi on 15/12/22.
//  Copyright © 2015年 lysongzi. All rights reserved.
//

#import "YSEditNoteViewController.h"
#import "YSMainViewController.h"
#import "MBProgressHUD+MJ.h"
#import "YSNote.h"
#import "Constant.h"

#import <BmobSDK/Bmob.h>

@interface YSEditNoteViewController ()

@property (weak, nonatomic) IBOutlet UIButton *cancle;
@property (weak, nonatomic) IBOutlet UIImageView *finish;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextField;

//@property (weak, nonatomic)

@end

@implementation YSEditNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initFinishGesture];
    
    if (!self.isAdd)
    {
        self.titleTextField.text = self.note.title;
        self.contentTextField.text = self.note.content;
    }
}

- (void)initFinishGesture
{
    UITapGestureRecognizer *finishTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFinish:)];
    [self.finish addGestureRecognizer:finishTapGesture];
    [self.finish setUserInteractionEnabled:YES];
}

- (void)tapFinish:(UIGestureRecognizer *)gr
{
    //新建笔记
    if (self.isAdd)
    {
        NSString *title = self.titleTextField.text;
        NSString *content = self.contentTextField.text;
        
        if (!title) {
            [MBProgressHUD showError:@"标题不能为空"];
        }
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [userDefaults valueForKey:USER_INFO_ID];
        
        BmobObject *object = [BmobObject objectWithClassName:@"YSNote"];
        [object setObject:title forKey:@"title"];
        [object setObject:content forKey:@"content"];
        [object setObject:uid forKey:@"uid"];
        
        //异步存储到服务器
        [object saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                //创建成功后会返回objectId，updatedAt，createdAt等信息
                //创建对象成功，打印对象值
                NSLog(@"%@",object);
                [self.navigationController popViewControllerAnimated:YES];
            } else if (error){
                //发生错误后的动作
                NSLog(@"%@",error);
                [MBProgressHUD showError:@"网络故障"];
            } else {
                NSLog(@"Unknow error");
            }
        }];
    }
    //修改
    else
    {
        NSString *title = self.titleTextField.text;
        NSString *content = self.contentTextField.text;
        
        if (!title) {
            [MBProgressHUD showError:@"标题不能为空"];
        }
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [userDefaults valueForKey:USER_INFO_ID];
        
        BmobObject *object = [BmobObject objectWithClassName:@"YSNote"];
        [object setObject:title forKey:@"title"];
        [object setObject:content forKey:@"content"];
        [object setObject:uid forKey:@"uid"];
        [object setObjectId:self.note.oid];
        
        //异步保存到服务器
        [object updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful)
            {
                NSLog(@"更新成功，以下为对象值，可以看到score值已经改变");
                NSLog(@"%@",object);
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                NSLog(@"%@",error);
            }
        }];
    }
}


- (IBAction)cancle:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
