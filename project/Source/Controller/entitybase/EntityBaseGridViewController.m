//
//  EntityBaseGridViewController.m
//  project
//
//  Created by runes on 13-2-1.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "EntityBaseGridViewController.h"
#import "AppDelegate.h"
#import "SBJson.h"
#import "AssetsTypeTop.h"

@implementation EntityBaseGridViewController
@synthesize assetsTypeTopList;
static int LOGINTAG = -1;       //需要退回到登陆状态的TAG标志
- (id)initWithURL:(EntityBaseGridMenuPage)page query:(NSDictionary *)query
{
    self = [super init];
    if (self) {
        _entityBase = [query objectForKey:@"entityBase"];
        _page = page;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self setRightBarButtonItem];
    
    //self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"返回主页面" style:UIBarButtonItemStyleBordered target:@"tt://main" action:@selector(openURLFromButton:)] autorelease];
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *server_base = [NSString stringWithFormat:@"%@/assets/assetstypetop!getAssetsTypeTopListByBaseId.action", delegate.SERVER_HOST];
    TTURLRequest* request = [TTURLRequest requestWithURL: server_base delegate: self];
    [request setHttpMethod:@"POST"];
    
    request.contentType=@"application/x-www-form-urlencoded";
    NSString* postBodyString = [NSString stringWithFormat:@"isMobile=true&baseId=%i",_entityBase.baseId];
    //postBodyString = [postBodyString stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    postBodyString = [postBodyString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    request.cachePolicy = TTURLRequestCachePolicyNoCache;
    NSData* postData = [NSData dataWithBytes:[postBodyString UTF8String] length:[postBodyString length]];
    
    [request setHttpBody:postData];
    
    [request send];
    
    request.response = [[[TTURLDataResponse alloc] init] autorelease];
}///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidStartLoad:(TTURLRequest*)request {
    //加入请求开始的一些进度条
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
    TTURLDataResponse* dataResponse = (TTURLDataResponse*)request.response;
    NSString *json = [[NSString alloc] initWithData:dataResponse.data encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",json);
    SBJsonParser * jsonParser = [[SBJsonParser alloc] init];
    NSDictionary *jsonDic = [jsonParser objectWithString:json];
    [jsonParser release];
	[json release];
	request.response = nil;
    bool loginfailure = [[jsonDic objectForKey:@"loginfailure"] boolValue];
    if (loginfailure) {
        //创建对话框 提示用户重新输入
        UIAlertView * alert= [[UIAlertView alloc] initWithTitle:[jsonDic objectForKey:@"msg"] message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        alert.tag = LOGINTAG;   //通过该标志让用户返回登陆界面
        [alert show];
        [alert release];
        return;
    }
    bool success = [[jsonDic objectForKey:@"success"] boolValue];
    if (!success) {
        //创建对话框 提示用户获取请求数据失败
        UIAlertView * alert= [[UIAlertView alloc] initWithTitle:[jsonDic objectForKey:@"msg"] message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else{
        AssetsTypeTop *assetsTypeTop = [[AssetsTypeTop alloc] init];
        assetsTypeTopList = [assetsTypeTop initAssetsTypeTop:[jsonDic objectForKey:@"assetsTypeTopList"]];
        TT_RELEASE_SAFELY(assetsTypeTop);
    }
    [self setLauncherItem];
}

-(void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(theAlert.tag == LOGINTAG){
        TTNavigator* navigator = [TTNavigator navigator];
        //切换至登录成功页面
        [navigator openURLAction:[[TTURLAction actionWithURLPath:@"tt://login"] applyAnimated:YES]];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
    //[loginButton setTitle:@"Failed to load, try again." forState:UIControlStateNormal];
    UIAlertView * alert= [[UIAlertView alloc] initWithTitle:@"获取http请求失败!" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //将这个UIAlerView 显示出来
    [alert show];
    //释放
    [alert release];
}

- (void)setRightBarButtonItem
{
    NSString *title = @"新增资产";
    switch (_page) {
        case EntityBaseGridMenuPageAssetsSearch:
            
            break;
        case EntityBaseGridMenuPageAssetsStore:
            title = @"资产入库";
            break;
        case EntityBaseGridMenuPageAssetsSite:
            
            break;
        case EntityBaseGridMenuPageAssetsRoom:
            
            break;
        case EntityBaseGridMenuPageAssetsCar:
            
            break;
        default:
            break;
    }
    self.navigationItem.rightBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(selectButtonItem)] autorelease];
}

- (void) selectButtonItem
{
    TTURLAction *action =  [[TTURLAction actionWithURLPath:[NSString stringWithFormat:@"tt://assetsRecordPage?page=%i&baseId=%i&bastType=%@",_page,_entityBase.baseId,_entityBase.baseType]] applyAnimated:YES];
    [[TTNavigator navigator] openURLAction:action];
}

- (void) setLauncherItem
{
    _launcherView = [[TTLauncherView alloc] initWithFrame:self.view.bounds];
    _launcherView.backgroundColor = [UIColor whiteColor];
    _launcherView.delegate = self;
    _launcherView.columnCount = 4;
    _launcherView.height = self.view.height;
    _launcherView.persistenceMode = TTLauncherPersistenceModeAll;
    TTLauncherItem* item;
    for (AssetsTypeTop *assetsTypeTop in assetsTypeTopList) {
        item = [[[TTLauncherItem alloc] initWithTitle:assetsTypeTop.assetsTypeName image:assetsTypeTop.icon URL:assetsTypeTop.URL canDelete:YES] autorelease];
        item.badgeNumber = assetsTypeTop.count.intValue;
        item.userInfo = assetsTypeTop;
        [_launcherView endEditing];
        [_launcherView addItem:item animated:YES];
    }
    [self.view addSubview:_launcherView];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTLauncherViewDelegate

- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
    TTURLAction *action =  [[TTURLAction actionWithURLPath:@"tt://assetsRecordTableViewQuery/1"]
                            applyAnimated:YES];
    [[TTNavigator navigator] openURLAction:action];
}

@end
