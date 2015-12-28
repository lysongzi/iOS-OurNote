//
//  YSGuidePageViewController.m
//  UnNote
//
//  Created by lysongzi on 15/12/23.
//  Copyright © 2015年 lysongzi. All rights reserved.
//

#import "YSGuidePageViewController.h"
#import "YSSignInViewController.h"
#import "YSRegisterViewController.h"

#define PAGE_NUMBER 5
#define UISCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define UISCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface YSGuidePageViewController ()<UIPageViewControllerDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *pageGuiderScrollView;
@property (strong ,nonatomic) UIPageControl *pageControl;

@property (strong ,nonatomic) UIView * pageOne;
@property (strong ,nonatomic) UIView * pageTwo;
@property (strong ,nonatomic) UIView * pageThree;
@property (strong ,nonatomic) UIView * pageFour;
@property (strong ,nonatomic) UIView * pageFive;

@end

@implementation YSGuidePageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initGuidePage];
}

- (void)initGuidePage
{
    //初始化pageControl组件及其位置
    CGRect pageControlFrame = CGRectMake(UISCREEN_WIDTH / 2 - 50, UISCREEN_HEIGHT - 50, 100, 20);
    self.pageControl = [[UIPageControl alloc] initWithFrame:pageControlFrame];
    self.pageControl.numberOfPages = PAGE_NUMBER;
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:self.pageControl];
    
    //设置scrollView属性
    self.pageGuiderScrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width * PAGE_NUMBER, [[UIScreen mainScreen] bounds].size.height);
    [self.pageGuiderScrollView setUserInteractionEnabled:YES];
    [self.pageGuiderScrollView setScrollEnabled:YES];
    [self.pageGuiderScrollView setPagingEnabled:YES];
    self.pageGuiderScrollView.showsHorizontalScrollIndicator = NO;
    self.pageGuiderScrollView.showsVerticalScrollIndicator = NO;
    self.pageGuiderScrollView.bounces = NO;
    self.pageGuiderScrollView.delegate = self;
    
    //初始化各个界面
    
    UIView *page;
    NSArray *pageArray = @[@"YSGuidePageOne",  @"YSGuidePageTwo", @"YSGuidePageThree", @"YSGuidePageFour", @"YSGuidePageFive"];
    for (int i = 0; i < pageArray.count; i++) {
        page = [[[NSBundle mainBundle] loadNibNamed:pageArray[i]
                                              owner:self options:nil] lastObject];
        page.frame = CGRectMake(UISCREEN_WIDTH * i, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT);
        [self.pageGuiderScrollView addSubview:page];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//跳转到登录界面
- (IBAction)jumpToSignIn:(id)sender
{
    [self presentViewController:[[YSSignInViewController alloc] init] animated:YES completion:nil];
}

//跳转到注册界面
- (IBAction)jumpToRegister:(id)sender
{
    [self presentViewController:[[YSRegisterViewController alloc] init] animated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int pageNum = self.pageGuiderScrollView.contentOffset.x / UISCREEN_WIDTH;
    self.pageControl.currentPage = pageNum;
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
