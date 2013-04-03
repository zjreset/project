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
    self.view.backgroundColor=[UIColor colorWithPatternImage:TTIMAGE(@"bundle://main-back.jpg")];
    
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToURL:)];
    singleTapGestureRecognizer.numberOfTouchesRequired = 1;    //触摸点个数
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    
    
    UIImageView *navigate_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(230, 135, 48, 62)];
    [navigate_imageView setImage:TTIMAGE(@"bundle://main-navigate.png")];
    [navigate_imageView setUserInteractionEnabled:true];
    navigate_imageView.tag = 10;
    [navigate_imageView addGestureRecognizer:singleTapGestureRecognizer];
    [self.view addSubview:navigate_imageView];
    TT_RELEASE_SAFELY(navigate_imageView);
    
    
    singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToURL:)];
    singleTapGestureRecognizer.numberOfTouchesRequired = 1;    //触摸点个数
    singleTapGestureRecognizer.numberOfTapsRequired = 1;

    
    UIImageView *asssets_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 255, 78, 96)];
    [asssets_imageView setImage:TTIMAGE(@"bundle://main-assets.png")];
    [asssets_imageView setUserInteractionEnabled:true];
    asssets_imageView.tag = 1;
    [asssets_imageView addGestureRecognizer:singleTapGestureRecognizer];
    [self.view addSubview:asssets_imageView];
    TT_RELEASE_SAFELY(asssets_imageView);
    
    singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToURL:)];
    singleTapGestureRecognizer.numberOfTouchesRequired = 1;    //触摸点个数
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    
    UIImageView *problem_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 255, 78, 96)];
    [problem_imageView setImage:TTIMAGE(@"bundle://main-problem.png")];
    [problem_imageView setUserInteractionEnabled:true];
    problem_imageView.tag = 2;
    [problem_imageView addGestureRecognizer:singleTapGestureRecognizer];
    [self.view addSubview:problem_imageView];
    TT_RELEASE_SAFELY(problem_imageView);
    
    singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToURL:)];
    singleTapGestureRecognizer.numberOfTouchesRequired = 1;    //触摸点个数
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    
    UIImageView *task_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(230, 255, 78, 96)];
    [task_imageView setImage:TTIMAGE(@"bundle://main-task.png")];
    [task_imageView setUserInteractionEnabled:true];
    task_imageView.tag = 3;
    [task_imageView addGestureRecognizer:singleTapGestureRecognizer];
    [self.view addSubview:task_imageView];
    TT_RELEASE_SAFELY(task_imageView);
    
    singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToURL:)];
    singleTapGestureRecognizer.numberOfTouchesRequired = 1;    //触摸点个数
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    
    UIImageView *car_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 355, 78, 96)];
    [car_imageView setImage:TTIMAGE(@"bundle://main-car.png")];
    [car_imageView setUserInteractionEnabled:true];
    car_imageView.tag = 4;
    [car_imageView addGestureRecognizer:singleTapGestureRecognizer];
    [self.view addSubview:car_imageView];
    TT_RELEASE_SAFELY(car_imageView);
    
    singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToURL:)];
    singleTapGestureRecognizer.numberOfTouchesRequired = 1;    //触摸点个数
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    
    UIImageView *site_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 355, 78, 96)];
    [site_imageView setImage:TTIMAGE(@"bundle://main-site.png")];
    [site_imageView setUserInteractionEnabled:true];
    site_imageView.tag = 5;
    [site_imageView addGestureRecognizer:singleTapGestureRecognizer];
    [self.view addSubview:site_imageView];
    TT_RELEASE_SAFELY(site_imageView);
    
    singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToURL:)];
    singleTapGestureRecognizer.numberOfTouchesRequired = 1;    //触摸点个数
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    
    UIImageView *other_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(230, 355, 78, 96)];
    [other_imageView setImage:TTIMAGE(@"bundle://main-other.png")];
    [other_imageView setUserInteractionEnabled:true];
    other_imageView.tag = 6;
    [other_imageView addGestureRecognizer:singleTapGestureRecognizer];
    [self.view addSubview:other_imageView];
    TT_RELEASE_SAFELY(other_imageView);
    
    
    NSLog(@"高度:%f",self.view.frame.size.height);
//    int x = 20,y = 150,w = 80,h = 105;
	//资产管理
    //SubMainView *zichanView = [[SubMainView alloc] initWith:@"资产管理" imageURL:@"bundle://main-assets.png" toURL:@"tt://tabBar" frame:CGRectMake(x, y, w, h)];
    //[self.view addSubview:zichanView];
    //TT_RELEASE_SAFELY(zichanView);
	//位置管理
    //SubMainView *baseSiteView = [[SubMainView alloc] initWith:@"位置管理" imageURL:@"bundle://desktop-baseSite.png" toURL:@"tt://entityTabBar" frame:CGRectMake(x+w+20, y, w, h)];
    //[self.view addSubview:baseSiteView];
    //TT_RELEASE_SAFELY(baseSiteView);
	//变更管理
//    SubMainView *assetsRecordChange = [[SubMainView alloc] initWith:@"资产变更" imageURL:@"bundle://desktop-changeAssetsRecord.png" toURL:@"tt://tabBar" frame:CGRectMake(x+w*2+20*2, y, w, h)];
//    [self.view addSubview:assetsRecordChange];
//    TT_RELEASE_SAFELY(assetsRecordChange);
//    y = y + 105 + 20;
	//工单管理
//    SubMainView *taskView = [[SubMainView alloc] initWith:@"工单管理" imageURL:@"bundle://desktop-task.png" toURL:@"tt://tabBar" frame:CGRectMake(x, y, w, h)];
//    //[self.view addSubview:taskView];
//    TT_RELEASE_SAFELY(taskView);
//	//基站巡检管理
//    SubMainView *analyView = [[SubMainView alloc] initWith:@"基站巡检" imageURL:@"bundle://desktop-assetsRecordAnaly.png" toURL:@"tt://tabBar" frame:CGRectMake(x+w+20, y, w, h)];
//    [self.view addSubview:analyView];
//    TT_RELEASE_SAFELY(analyView);
	//更多管理
//    SubMainView *moreView = [[SubMainView alloc] initWith:@"更多.." imageURL:@"bundle://desktop-more1.png" toURL:@"tt://tabBar" frame:CGRectMake(x+w*2+20*2, y, w, h)];
//    [self.view addSubview:moreView];
//    TT_RELEASE_SAFELY(moreView);
//    y = y + 105 + 20;
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    [imageView setImage:[UIImage imageNamed:@"Default.png"]];
//    imageView.alpha = 0.1;
//    [self.view addSubview:imageView];
//    TT_RELEASE_SAFELY(imageView);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) goToURL:tgrId
{
    UIImageView *imageView = (UIImageView*)((UITapGestureRecognizer*)tgrId).view;
    //清除点击前的状态
    for (UIImageView* iview in self.view.subviews) {
        if (iview.tag == -1) {
            [iview removeFromSuperview];
        }
        if (iview.tag == -2) {
            [iview removeFromSuperview];
        }
    }
    //给点击的图标加上点击状态
    UIImageView *back_imageView;
    if (imageView.tag == 10) {
        back_imageView = [[UIImageView alloc] initWithFrame:imageView.frame];
        back_imageView.tag = -2;
        [back_imageView setImage:TTIMAGE(@"bundle://main-navigate-checked.png")];
        [self.view addSubview:back_imageView];
        [self.view bringSubviewToFront:imageView];
    }
    else {
        back_imageView = [[UIImageView alloc] initWithFrame:imageView.frame];
        back_imageView.tag = -1;
        [back_imageView setImage:TTIMAGE(@"bundle://main-checked.png")];
        [self.view addSubview:back_imageView];
        [self.view bringSubviewToFront:imageView];
    }
    NSString *url = nil;
    switch (imageView.tag) {
        case 1:
            url = @"tt://tabBar";
            break;
        case 2:
            url = @"tt://entityTabBar";
            break;
        case 3:
            url = @"tt://tabBar";
            break;
        case 4:
            url = @"tt://tabBar";
            break;
        case 5:
            url = @"tt://tabBar";
            break;
        case 6:
            url = @"tt://tabBar";
            break;
        case 10:
            url = @"tt://tabBar";
            break;
        default:
            url = @"tt://tabBar";
            break;
    }
    TTNavigator* navigator = [TTNavigator navigator];
    //切换至登录成功页面
    [navigator openURLAction:[[TTURLAction actionWithURLPath:url] applyAnimated:YES]];
}

@end
