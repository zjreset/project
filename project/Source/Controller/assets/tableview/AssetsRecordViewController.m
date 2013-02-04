//
//  AssetsRecordViewController.m
//  project
//
//  Created by runes on 13-1-23.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "AssetsRecordViewController.h"
#import "AutoAdaptedView.h"

@interface AssetsRecordViewController ()

@end
static int INPUTHEIGHT = 30;
static int _X = 10;
static int _P = 10;
@implementation AssetsRecordViewController

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query
{
    self = [super init];
    if (self) {
        _assetsRecord = [query objectForKey:@"assetsRecord"];
    }
    return self;
}

- (id)initWithPageTag:(PageTag)pageTag
{
    self = [super init];
    if (self) {
        _pageTag = pageTag;
    }
    return self;
}

- (void)viewDidLoad
{
    switch (_pageTag) {
        case 1:
            NSLog(@"search");
            break;
        case 2:
            NSLog(@"store");
            break;
        case 3:
            NSLog(@"site");
            break;
        case 4:
            NSLog(@"room");
            break;
        case 5:
            NSLog(@"drop");
            break;
        default:
            NSLog(@"edit");
            break;
    }
    if (!_assetsRecord) {
        _assetsRecord = [[AssetsRecord alloc] init];
    }
    
    self.navigationItem.leftBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(dismiss)] autorelease];
    
    self.navigationItem.rightBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered
                                     target:@"tt://"
                                     action:@selector(saveToURL:forSaveOperation:completionHandler:)] autorelease];
    
    [super viewDidLoad];
    UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:self.view.frame] autorelease];
    [scrollView setScrollEnabled:YES];
    scrollView.showsVerticalScrollIndicator = TRUE;
    int y = 0;
    
    self.title = @"资产详细信息";
	AutoAdaptedView *zichanName = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, _P, self.view.frame.size.width, INPUTHEIGHT) title:@"资产名称:" inputType:1 inputValue:_assetsRecord.name];
    [scrollView addSubview:zichanName];
    y = y + zichanName.frame.size.height + 2*_P;
    TT_RELEASE_SAFELY(zichanName);
    
	AutoAdaptedView *zichanFactory = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"厂家:" inputType:1 inputValue:_assetsRecord.factory];
    [scrollView addSubview:zichanFactory];
    y = y + zichanFactory.frame.size.height + 2*_P;
    TT_RELEASE_SAFELY(zichanFactory);
    
	AutoAdaptedView *typeName = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"型号:" inputType:1 inputValue:_assetsRecord.typeName];
    [scrollView addSubview:typeName];
    y = y + typeName.frame.size.height + 2*_P;
    TT_RELEASE_SAFELY(typeName);
    
	AutoAdaptedView *assetsCode = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"资产编码:" inputType:1 inputValue:_assetsRecord.assetsCode];
    [scrollView addSubview:assetsCode];
    y = y + assetsCode.frame.size.height + 2*_P;
    TT_RELEASE_SAFELY(assetsCode);
    
	AutoAdaptedView *barcode = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"资产条码:" inputType:1 inputValue:_assetsRecord.barcode];
    [scrollView addSubview:barcode];
    y = y + barcode.frame.size.height + 2*_P;
    TT_RELEASE_SAFELY(barcode);
    
	AutoAdaptedView *assetsOwners = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"资产所有权:" inputType:1 inputValue:_assetsRecord.assetsOwners];
    [scrollView addSubview:assetsOwners];
    y = y + assetsOwners.frame.size.height + 2*_P;
    TT_RELEASE_SAFELY(assetsOwners);
    
	AutoAdaptedView *startTimeStr = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"使用时间:" inputType:1 inputValue:_assetsRecord.startTimeStr];
    [scrollView addSubview:startTimeStr];
    y = y + startTimeStr.frame.size.height + 2*_P;
    TT_RELEASE_SAFELY(startTimeStr);
    
	AutoAdaptedView *valid = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"报废年限:" inputType:1 inputValue:[NSString stringWithFormat:@"%f",_assetsRecord.valid]];
    [scrollView addSubview:valid];
    y = y + valid.frame.size.height + 2*_P;
    TT_RELEASE_SAFELY(valid);
    
	AutoAdaptedView *status = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"性能状态:" inputType:1 inputValue:_assetsRecord.status];
    [scrollView addSubview:status];
    y = y + status.frame.size.height + 2*_P;
    TT_RELEASE_SAFELY(status);
    
	AutoAdaptedView *useStatus = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"使用状态:" inputType:1 inputValue:[NSString stringWithFormat:@"%i",_assetsRecord.useStatus]];
    [scrollView addSubview:useStatus];
    y = y + useStatus.frame.size.height + 2*_P;
    TT_RELEASE_SAFELY(useStatus);
    
	AutoAdaptedView *zichanLng = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"经度:" inputType:1 inputValue:[NSString stringWithFormat:@"%f",_assetsRecord.lng]];
    [scrollView addSubview:zichanLng];
    y = y + zichanLng.frame.size.height + 2*_P;
    TT_RELEASE_SAFELY(zichanLng);
    
	AutoAdaptedView *zichanLat = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"纬度:" inputType:1 inputValue:[NSString stringWithFormat:@"%f",_assetsRecord.lat]];
    [scrollView addSubview:zichanLat];
    y = y + zichanLat.frame.size.height + 2*_P;
    TT_RELEASE_SAFELY(zichanLat);
    
	AutoAdaptedView *resp = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"责任人:" inputType:1 inputValue:_assetsRecord.resp];
    [scrollView addSubview:resp];
    y = y + resp.frame.size.height + 2*_P;
    TT_RELEASE_SAFELY(resp);
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, y);
    self.view = scrollView;
    
    _rukuButton = [TTButton buttonWithStyle:UIControlStateNormal title:@"资产入库"];
    _rukuButton.frame = CGRectMake(20, self.view.frame.size.height - 260, 100, 35);
    _rukuButton.backgroundColor = [UIColor grayColor];
    _rukuButton.alpha = 0.8;
    [self.view addSubview:_rukuButton];
}

- (void)dismiss
{
    //关闭窗口，包括关闭动画
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)dealloc
{
    [super dealloc];
    //TT_RELEASE_SAFELY(_assetsRecord);
    //TT_RELEASE_SAFELY(_rukuButton);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
