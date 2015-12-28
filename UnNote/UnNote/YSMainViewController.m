//
//  MainViewController.m
//  UnNote
//
//  Created by lysongzi on 15/12/22.
//  Copyright © 2015年 lysongzi. All rights reserved.
//

#import "YSMainViewController.h"
#import "YSSettingsViewController.h"
#import "YSEditNoteViewController.h"
#import "YSNoteTableViewCell.h"
#import "MBProgressHUD+MJ.h"
#import "YSNote.h"
#import "Constant.h"

#import <BmobSDK/Bmob.h>

@interface YSMainViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *settingsButton;
@property (weak, nonatomic) IBOutlet UIImageView *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *addNote;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *note;
@property (weak, nonatomic) IBOutlet UIImageView *voice;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UIImageView *clock;

@property (strong, nonatomic) NSMutableArray *notes;
@property (copy, nonatomic) NSString *uid;

@end

@implementation YSMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.notes) {
        self.notes = [NSMutableArray array];
        self.uid = [[NSUserDefaults standardUserDefaults] valueForKey:USER_INFO_ID];
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    UINib *nib = [UINib nibWithNibName:@"YSNoteTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"YSNoteTableViewCell"];
    
    [self registerGestureEvent];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getNoteFromBmob];
}

- (void)getNoteFromBmob
{
    BmobQuery *query = [BmobQuery queryWithClassName:@"YSNote"];
    [query whereKey:@"uid" equalTo:self.uid];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error)
        {
            NSLog(@"error is %@", error);
        }
        
        if (array)
        {
            [self.notes removeAllObjects];
            for (BmobObject *object in array)
            {
                YSNote *note = [[YSNote alloc] initWithTitle:[object objectForKey:@"title"]
                                                     Content:[object objectForKey:@"content"]];
                note.uid = [object objectForKey:@"uid"];
                note.oid = [object objectId];
                [self.notes addObject:note];
            }
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - 各种点击事件处理

- (void)registerGestureEvent
{
    UITapGestureRecognizer *tapNoteRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(tapNote:)];
    [self.note addGestureRecognizer:tapNoteRecognizer];
    [self.note setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tapVoiceRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(tapVoice:)];
    [self.voice addGestureRecognizer:tapVoiceRecognizer];
    [self.voice setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tapPhotoRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(tapPhoto:)];
    [self.photo addGestureRecognizer:tapPhotoRecognizer];
    [self.photo setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tapClockRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(tapClock:)];
    [self.clock addGestureRecognizer:tapClockRecognizer];
    [self.clock setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tapSettingsButtonRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(tapSettings:)];
    [self.settingsButton addGestureRecognizer:tapSettingsButtonRecognizer];
    [self.settingsButton setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tapSearchButtonRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(tapSearch:)];
    [self.searchButton addGestureRecognizer:tapSearchButtonRecognizer];
    [self.searchButton setUserInteractionEnabled:YES];
}

- (void)tapNote:(UIGestureRecognizer *)gr
{
    YSEditNoteViewController *evc = [[YSEditNoteViewController alloc] init];
    evc.isAdd = true;
    [self.navigationController pushViewController:evc animated:YES];
}

- (void)tapVoice:(UIGestureRecognizer *)gr
{
    [MBProgressHUD showError:@"该功能未开通!"];
}

- (void)tapPhoto:(UIGestureRecognizer *)gr
{
    [MBProgressHUD showError:@"该功能未开通!"];
}

- (void)tapClock:(UIGestureRecognizer *)gr
{
    [MBProgressHUD showError:@"该功能未开通!"];
}

- (IBAction)addNote:(id)sender
{
    [MBProgressHUD showError:@"该功能未开通!"];
}

- (void)tapSettings:(UIGestureRecognizer *)gr
{
    YSSettingsViewController *svc = [[YSSettingsViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}

- (void)tapSearch:(UIGestureRecognizer *)gr
{
    NSLog(@"这里是搜索按钮.");
    [MBProgressHUD showError:@"该功能未开通!"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -m UITableViewDataSource和UITableViewDataDelegate 协议的实现

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSNoteTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"YSNoteTableViewCell"];
    
    if(!cell)
    {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"YSNoteTableViewCell"];
    }
    
    YSNote *note = self.notes[indexPath.row];
    cell.title.text = note.title;
    cell.content.text = note.content;
    //NSLog(@"%@ %@", note.title, note.content);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //如果是删除
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        YSNote *note = self.notes[indexPath.row];
        //删除服务器上的数据
        BmobObject *object = [BmobObject objectWithoutDatatWithClassName:@"YSNote"  objectId:note.oid];
        [object deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error)
        {
            if (isSuccessful)
            {
                //删除成功后的动作
                //NSLog(@"successful");
                [MBProgressHUD showSuccess:@"删除成功!"];
                //删除模型中的数据
                [self.notes removeObject:note];
                //从TableView中删除
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            else if (error)
            {
                NSLog(@"%@",error);
                [MBProgressHUD showError:@"删除失败!"];
            }
            else
            {
                NSLog(@"UnKnow error");
            }
        }];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSNote *note = self.notes[indexPath.row];
    YSEditNoteViewController *evc = [[YSEditNoteViewController alloc] init];
    evc.isAdd = false;
    evc.note = note;
    [self.navigationController pushViewController:evc animated:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"笔记";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.notes.count;
}

@end
