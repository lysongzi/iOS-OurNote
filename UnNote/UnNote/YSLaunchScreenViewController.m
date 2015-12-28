//
//  YSLaunchScreenViewController.m
//  UnNote
//
//  Created by lysongzi on 15/12/23.
//  Copyright © 2015年 lysongzi. All rights reserved.
//

#import "YSLaunchScreenViewController.h"
#import "YSSignInViewController.h"
#import "YSRegisterViewController.h"
#import "YSGuidePageViewController.h"
#import "YSMainViewController.h"
#import "Constant.h"

@interface YSLaunchScreenViewController ()

@end

@implementation YSLaunchScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //如果不是第一次启动应用
    if ([userDefaults valueForKey:KEY_FIRTS_TIME] != nil)
    {
        //用户未登录
        if ([[userDefaults valueForKey:KEY_SIGN_STATE] isEqualToString:SIGN_STATE_OFF])
        {
            //跳转到登录页面
            [self presentViewController:[[YSSignInViewController alloc] init] animated:YES completion:nil];
        }
        //已经登录，则进入主界面
        else if ([[userDefaults valueForKey:KEY_SIGN_STATE] isEqualToString:SIGN_STATE_ON])
        {
            YSMainViewController *mvc = [[YSMainViewController alloc] init];
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:mvc];
            nc.navigationBarHidden = YES;
            [self presentViewController:nc animated:YES completion:nil];
        }
        else
        {
            NSLog(@"出错了！");
        }
    }
    else
    {
        //第一次启动应用，设置用户为未登录状态
        [userDefaults setValue:SIGN_STATE_OFF forKey:KEY_SIGN_STATE];
        //设置已经不是第一次启动了
        [userDefaults setValue:@"NO" forKey:KEY_FIRTS_TIME];
        //跳转到启动页面
        [self presentViewController:[[YSGuidePageViewController alloc] init] animated:YES completion:nil];
    }

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
