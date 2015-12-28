//
//  SignInViewController.m
//  UnNote
//
//  Created by lysongzi on 15/12/22.
//  Copyright © 2015年 lysongzi. All rights reserved.
//

#import "YSSignInViewController.h"
#import "YSRegisterViewController.h"
#import "YSMainViewController.h"
#import "MBProgressHUD+MJ.h"
#import "Utils.h"
#import "YSUser.h"
#import "Constant.h"

#import <BmobSDK/Bmob.h>


@interface YSSignInViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation YSSignInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - 按钮响应事件

- (IBAction)signIn:(id)sender
{
    //登录操作
    NSString *phoneNumber = [self.phoneTextFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (!phoneNumber)
    {
        [MBProgressHUD showError:@"手机号不能为空!"];
        return;
    }
    
    if (!password)
    {
        [MBProgressHUD showError:@"密码不能为空!"];
        return;
    }
    
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
             //该用户存在
             if (array && array.count == 1)
             {
                 //md5加密密码
                 NSString *pwdMd5 = [Utils md5:password];
                 BmobObject *user = array[0];
                 
                 if ([pwdMd5 isEqualToString:[user objectForKey:@"password"]])
                 {
                     //设置为已登录状态，以及保存用户相关信息
                     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                     [userDefaults setValue:SIGN_STATE_ON forKey:KEY_SIGN_STATE];
                     [userDefaults setObject:[user objectId] forKey:USER_INFO_ID];
                     [userDefaults setObject:[user objectForKey:@"phoneNumber"] forKey:USER_INFO_NAME];
                     
                     [MBProgressHUD showMessage:@"正在登录..."];
                     //延时跳转到登陆界面
                     [NSTimer scheduledTimerWithTimeInterval:2.0f
                                                      target:self
                                                    selector:@selector(jumpToMain)
                                                    userInfo:nil
                                                     repeats:NO];
                 }
                 
             }
             else
             {
                 [MBProgressHUD showError:@"该用户不存在!"];
             }
         }
         
     }];

}

- (IBAction)forgetPassword:(id)sender
{
    //[self presentViewController:[[YSRegisterViewController alloc] init] animated:YES completion:nil];
}

- (IBAction)register:(id)sender
{
    [self presentViewController:[[YSRegisterViewController alloc] init] animated:YES completion:nil];
}

- (void)jumpToMain
{
    [MBProgressHUD hideHUD];
    YSMainViewController *mvc = [[YSMainViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:mvc];
    nc.navigationBarHidden = YES;
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
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
