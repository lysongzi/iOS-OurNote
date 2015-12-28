//
//  YSSettingsViewController.m
//  UnNote
//
//  Created by lysongzi on 15/12/24.
//  Copyright © 2015年 lysongzi. All rights reserved.
//

#import "YSSettingsViewController.h"
#import "YSSignInViewController.h"
#import "Constant.h"

@interface YSSettingsViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *settings;
}

@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation YSSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (!settings)
    {
        settings = @[@"自定义界面", @"通用设置", @"个人资料", @"帮助"];
    }
    
    self.settingsTableView.bounces = NO;
    self.settingsTableView.showsVerticalScrollIndicator = NO;
    self.settingsTableView.dataSource = self;
    self.settingsTableView.delegate = self;
    
    [self initUserInfo];
}

- (IBAction)cancle:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)signOut:(id)sender
{
    //设置为未登录状态
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:SIGN_STATE_OFF forKey:KEY_SIGN_STATE];
    
    [userDefaults setValue:@"" forKey:USER_INFO_NAME];
    [userDefaults setValue:@"" forKey:USER_INFO_ID];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"退出登录"
                                                                             message:@"确定退出？"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action)
    {
        //点击确定按钮,退出登录
        [self presentViewController:[[YSSignInViewController alloc] init] animated:YES completion:nil];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action){}]];
    //弹出选项框
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)initUserInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.userNameLabel.text = [userDefaults valueForKey:USER_INFO_NAME];
}

#pragma mark -m UITableViewDataSource，UITableViewDelegate 协议的实现

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return settings.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.settingsTableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = settings[indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
