//
//  MainViewController.m
//  project
//
//  Created by runes on 13-1-22.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "MainViewController.h"
#import "SubMainView.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:self.view.frame] autorelease];
    [scrollView setScrollEnabled:YES];
    scrollView.showsVerticalScrollIndicator = TRUE;
    int x = 20,y = 100,w = 80,h = 105;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 60)];
    titleLabel.text = @"融维网络维护项目管理系统";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:24];
    [scrollView addSubview:titleLabel];
	//资产管理
    SubMainView *zichanView = [[SubMainView alloc] initWith:@"资产管理" imageURL:@"bundle://desktop-assetsRecord.png" toURL:@"tt://tabBar" frame:CGRectMake(x, y, w, h)];
    [scrollView addSubview:zichanView];
    TT_RELEASE_SAFELY(zichanView);
	//位置管理
    SubMainView *baseSiteView = [[SubMainView alloc] initWith:@"位置管理" imageURL:@"bundle://desktop-baseSite.png" toURL:@"tt://entityTabBar" frame:CGRectMake(x+w+20, y, w, h)];
    [scrollView addSubview:baseSiteView];
    TT_RELEASE_SAFELY(baseSiteView);
	//变更管理
    SubMainView *assetsRecordChange = [[SubMainView alloc] initWith:@"资产变更" imageURL:@"bundle://desktop-changeAssetsRecord.png" toURL:@"tt://tabBar" frame:CGRectMake(x+w*2+20*2, y, w, h)];
    [scrollView addSubview:assetsRecordChange];
    TT_RELEASE_SAFELY(assetsRecordChange);
    y = y + 105 + 20;
	//工单管理
    SubMainView *taskView = [[SubMainView alloc] initWith:@"工单管理" imageURL:@"bundle://desktop-task.png" toURL:@"tt://tabBar" frame:CGRectMake(x, y, w, h)];
    [scrollView addSubview:taskView];
    TT_RELEASE_SAFELY(taskView);
	//基站巡检管理
    SubMainView *analyView = [[SubMainView alloc] initWith:@"基站巡检" imageURL:@"bundle://desktop-assetsRecordAnaly.png" toURL:@"tt://tabBar" frame:CGRectMake(x+w+20, y, w, h)];
    [scrollView addSubview:analyView];
    TT_RELEASE_SAFELY(analyView);
	//更多管理
    SubMainView *moreView = [[SubMainView alloc] initWith:@"更多.." imageURL:@"bundle://desktop-more1.png" toURL:@"tt://tabBar" frame:CGRectMake(x+w*2+20*2, y, w, h)];
    [scrollView addSubview:moreView];
    TT_RELEASE_SAFELY(moreView);
    y = y + 105 + 20;
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, y)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [imageView setImage:[UIImage imageNamed:@"Default.png"]];
    imageView.alpha = 0.1;
    [self.view addSubview:imageView];
    TT_RELEASE_SAFELY(imageView);
    [self.view addSubview:scrollView];
    TT_RELEASE_SAFELY(scrollView);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
