//
//  RegisterViewController.m
//  UnNote
//
//  Created by lysongzi on 15/12/22.
//  Copyright © 2015年 lysongzi. All rights reserved.
//

#import "YSRegisterViewController.h"
#import "YSSignInViewController.h"
#import "MBProgressHUD+MJ.h"
#import "YSUser.h"
#import "Utils.h"

#import <BmobSDK/Bmob.h>

@interface YSRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *identifiyingCode;


@end

@implementation YSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 按钮响应操作

- (IBAction)getIdentifiyingCode:(id)sender
{
    
}

//注册事件
- (IBAction)registerNewUser:(id)sender
{
    NSString *phoneNumber = [self.phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (phoneNumber.length == 0)
    {
        NSLog(@"手机号为空");
        [MBProgressHUD showError:@"手机号不能为空!"];
        return;
    }
    
    if (password.length == 0)
    {
        NSLog(@"密码为空");
        [MBProgressHUD showError:@"密码不能为空!"];
        return;
    }
    
    //判断该手机号是否已经注册过账号
    BmobQuery *query = [BmobQuery queryWithClassName:NSStringFromClass([YSUser class])];
    [query whereKey:@"phoneNumber" equalTo:phoneNumber];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error)
    {
        if (error)
        {
            NSLog(@"error is:%@",error);
            [MBProgressHUD showError:@"网络故障!"];
        }
        else
        {
            NSLog(@"%lu",(unsigned long)array.count);
            if (array && array.count == 0)
            {
                //将账号进行注册
                BmobObject *object = [BmobObject objectWithClassName:NSStringFromClass([YSUser class])];
                [object setObject:phoneNumber forKey:@"phoneNumber"];
                
                //md5加密密码
                NSString *pwdMd5 = [Utils md5:password];
                [object setObject:pwdMd5 forKey:@"password"];
                
                //注册账户到服务器
                [object saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    //成功
                    if (isSuccessful)
                    {
                        //NSLog(@"%@", [object valueForKey:@"objectId"]);
                        [MBProgressHUD showMessage:@"注册成功！"];
                        //延时跳转到登陆界面
                        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(jumpToSignIn) userInfo:nil repeats:NO];
                    }
                    else if (error)
                    {
                        NSLog(@"error %@", error);
                    }
                }];
            }
            else
            {
                [MBProgressHUD showError:@"该手机号已注册!"];
            }
        }
        
    }];
}

//跳转到登录
- (IBAction)signIn:(id)sender
{
    [self jumpToSignIn];
}

- (void)jumpToSignIn
{
    [MBProgressHUD hideHUD];
    [self presentViewController:[[YSSignInViewController alloc] init] animated:YES completion:nil];
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
