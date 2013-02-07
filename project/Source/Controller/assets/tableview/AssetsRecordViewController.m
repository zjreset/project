//
//  AssetsRecordViewController.m
//  project
//
//  Created by runes on 13-1-23.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "AssetsRecordViewController.h"
#import "AutoAdaptedView.h"
#import "AssetsProp.h"
#import "AppDelegate.h"
#import "SBJson.h"

@interface AssetsRecordViewController ()

@end
static int LOGINTAG = -1;       //需要退回到登陆状态的TAG标志
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
    if (_assetsRecord.useStatus != 0) {
        //开启下方工具栏
        [self.navigationController setToolbarHidden:NO];
        NSMutableArray *toolbarArray = [[[NSMutableArray alloc] init] autorelease];
        if (!_assetsRecord) {
            _assetsRecord = [[AssetsRecord alloc] init];
        }
        else {
            NSString *outTitle = @"出库";
            UIBarButtonItem *changeButton;
            int position = 0;
            if (![_assetsRecord.position isEqual:[NSNull null]]) {
                position = _assetsRecord.position.intValue;
            }
            switch (position) {
                case 4:
                    NSLog(@"search");
                    outTitle = @"出库";
                    break;
                default:
                    NSLog(@"edit");
                    outTitle = @"拆除";
                    changeButton = [[[UIBarButtonItem alloc] initWithTitle:@"替换" style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(changeStore)] autorelease];
                    [toolbarArray addObject:changeButton];
                    break;
            }
            UIBarButtonItem *outButton = [[[UIBarButtonItem alloc] initWithTitle:outTitle style:UIBarButtonItemStyleBordered
                                                                          target:self
                                                                          action:@selector(outStore)] autorelease];
            [toolbarArray addObject:outButton];
            UIBarButtonItem *deleteButton = [[[UIBarButtonItem alloc] initWithTitle:@"报废" style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(dropStore)] autorelease];
            [toolbarArray addObject:deleteButton];
        }
        self.toolbarItems = toolbarArray;
    }
    
    self.navigationItem.leftBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(dismiss)] autorelease];
    
    self.navigationItem.rightBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(saveAssetsRecord)] autorelease];
    
    [super viewDidLoad];
    UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:self.view.frame] autorelease];
    [scrollView setScrollEnabled:YES];
    scrollView.showsVerticalScrollIndicator = TRUE;
    int y = 0;
    
    self.title = @"资产详细信息";
	_zichanName = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, _P, self.view.frame.size.width, INPUTHEIGHT) title:@"资产名称:" inputType:1 inputValue:_assetsRecord.name];
    [scrollView addSubview:_zichanName];
    y = y + _zichanName.frame.size.height + 2*_P;
    
	_zichanFactory = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"厂家:" inputType:1 inputValue:_assetsRecord.factory];
    [scrollView addSubview:_zichanFactory];
    y = y + _zichanFactory.frame.size.height + 2*_P;
    
	_typeName = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"型号:" inputType:1 inputValue:_assetsRecord.typeName];
    [scrollView addSubview:_typeName];
    y = y + _typeName.frame.size.height + 2*_P;
    
	_assetsCode = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"资产编码:" inputType:1 inputValue:_assetsRecord.assetsCode];
    [scrollView addSubview:_assetsCode];
    y = y + _assetsCode.frame.size.height + 2*_P;
    
	_barcode = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"资产条码:" inputType:1 inputValue:_assetsRecord.barcode];
    [scrollView addSubview:_barcode];
    y = y + _barcode.frame.size.height + 2*_P;
    
	_assetsOwners = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"资产所有权:" inputType:1 inputValue:_assetsRecord.assetsOwners];
    [scrollView addSubview:_assetsOwners];
    y = y + _assetsOwners.frame.size.height + 2*_P;
    
	_startTimeStr = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"使用时间:" inputType:1 inputValue:_assetsRecord.startTimeStr];
    [scrollView addSubview:_startTimeStr];
    y = y + _startTimeStr.frame.size.height + 2*_P;
    
	_valid = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"报废年限:" inputType:1 inputValue:[NSString stringWithFormat:@"%f",_assetsRecord.valid]];
    [scrollView addSubview:_valid];
    y = y + _valid.frame.size.height + 2*_P;
    
	_status = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"性能状态:" inputType:1 inputValue:_assetsRecord.status];
    [scrollView addSubview:_status];
    y = y + _status.frame.size.height + 2*_P;
    
	_zichanLng = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"经度:" inputType:1 inputValue:[NSString stringWithFormat:@"%f",_assetsRecord.lng]];
    [scrollView addSubview:_zichanLng];
    y = y + _zichanLng.frame.size.height + 2*_P;
    
	_zichanLat = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"纬度:" inputType:1 inputValue:[NSString stringWithFormat:@"%f",_assetsRecord.lat]];
    [scrollView addSubview:_zichanLat];
    y = y + _zichanLat.frame.size.height + 2*_P;
    
	_resp = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"责任人:" inputType:1 inputValue:_assetsRecord.resp];
    [scrollView addSubview:_resp];
    y = y + _resp.frame.size.height + 2*_P;
    
    //开始附加字段的拼接
    int i = 100;
    for (AssetsProp *assetsProp in _assetsRecord.assetsPropList){
        i++;
        _fujia = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:[NSString stringWithFormat:@"%@:",assetsProp.showName] inputType:1 inputValue:assetsProp.value];
        _fujia.tag = i;
        [scrollView addSubview:_fujia];
        y = y + _fujia.frame.size.height + 2*_P;
    }
    
	_remark = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"备注:" inputType:1 inputValue:[NSString stringWithFormat:@"%@",_assetsRecord.remark]];
    [scrollView addSubview:_remark];
    y = y + _remark.frame.size.height + 2*_P;
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, y);
    self.view = scrollView;
}

//保存资产编辑信息
- (void)saveAssetsRecord
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *server_base = [NSString stringWithFormat:@"%@/assets/assetsrecord!saveOrUpdateAssetsRecord.action", delegate.SERVER_HOST];
    TTURLRequest* request = [TTURLRequest requestWithURL: server_base delegate: self];
    [request setHttpMethod:@"POST"];
    NSString *assetsRecordStr = [[NSString alloc] initWithString:@"assetsRecordUpdate:1"];
    if (![_zichanName.textField.text isEqual:[NSNull null]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",name:'%@'",_zichanName.textField.text];
    }
    if (![_assetsCode.textField.text isEqual:[NSNull null]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",assetsCode:'%@'",_assetsCode.textField.text];
    }
    if (![_barcode.textField.text isEqual:[NSNull null]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",barcode:'%@'",_barcode.textField.text];
    }
    if (![_assetsOwners.textField.text isEqual:[NSNull null]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",assetsOwners:'%@'",_assetsOwners.textField.text];
    }
    if (![_startTimeStr.textField.text isEqual:[NSNull null]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",startTimeStr:'%@'",_startTimeStr.textField.text];
    }
    if (![_valid.textField.text isEqual:[NSNull null]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",valid:'%@'",_valid.textField.text];
    }
    if (![_status.textField.text isEqual:[NSNull null]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",status:'%@'",_status.textField.text];
    }
    if (![_zichanLng.textField.text isEqual:[NSNull null]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",lng:'%@'",_zichanLng.textField.text];
    }
    if (![_zichanLat.textField.text isEqual:[NSNull null]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",lat:'%@'",_zichanLat.textField.text];
    }
    if (![_remark.textField.text isEqual:[NSNull null]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",remark:'%@'",_remark.textField.text];
    }
    if (_assetsRecord.assetsId) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",assetsId:%i",_assetsRecord.assetsId];
    }
    NSString *propStr = [[NSString alloc] init];
    int i = 100;
    for (AssetsProp *assetsProp in _assetsRecord.assetsPropList){
        i++;
        AutoAdaptedView *aav = (AutoAdaptedView*)[self.view viewWithTag:i];
        if (![aav.textField.text isEqual:[NSNull null]]) {
            propStr = [propStr stringByAppendingFormat:@",%@:'%@'",[assetsProp.name stringByReplacingOccurrencesOfString:@"a_f" withString:@"AF"],aav.textField.text];
        }
    }
    assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",assetsRecordProp:{assetsId:%i%@}",_assetsRecord.assetsId,propStr];
    
    NSLog(@"提交的数据---%@",assetsRecordStr);
    request.contentType=@"application/x-www-form-urlencoded";
    NSString* postBodyString = [NSString stringWithFormat:@"isMobile=true&assertRecordJson={%@}",assetsRecordStr];
    //postBodyString = [postBodyString stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    postBodyString = [postBodyString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    request.cachePolicy = TTURLRequestCachePolicyNoCache;
    NSData* postData = [NSData dataWithBytes:[postBodyString UTF8String] length:[postBodyString length]];
    
    [request setHttpBody:postData];
    
    [request send];
    
    request.response = [[[TTURLDataResponse alloc] init] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
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
        UIAlertView * alert= [[UIAlertView alloc] initWithTitle:@"保存成功!" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
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

- (void)dismiss
{
    //关闭窗口，包括关闭动画
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//报废资产
- (void)dropStore
{
    UIAlertView * alert= [[UIAlertView alloc] initWithTitle:@"资产报废!" message:@"\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
    [alert show];
    //释放
    [alert release];
}

//资产替换
- (void)changeStore
{
    UIAlertView * alert= [[UIAlertView alloc] initWithTitle:@"资产报废!" message:@"\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
    [alert show];
    //释放
    [alert release];
}

//出库,拆除资产
- (void)outStore
{
    UIAlertView * alert= [[UIAlertView alloc] initWithTitle:@"资产报废!" message:@"\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
    [alert show];
    //释放
    [alert release];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
        NSLog(@"cancel%i", buttonIndex);
    }
    else {
        NSLog(@"---%i", buttonIndex);
    }
}

- (void)dealloc
{
    [super dealloc];
    //TT_RELEASE_SAFELY(_assetsRecord);
    //TT_RELEASE_SAFELY(_rukuButton);
//    TT_RELEASE_SAFELY(_zichanName);
//    TT_RELEASE_SAFELY(_zichanFactory);
//    TT_RELEASE_SAFELY(_typeName);
//    TT_RELEASE_SAFELY(_assetsCode);
//    TT_RELEASE_SAFELY(_barcode);
//    TT_RELEASE_SAFELY(_assetsOwners);
//    TT_RELEASE_SAFELY(_startTimeStr);
//    TT_RELEASE_SAFELY(_valid);
//    TT_RELEASE_SAFELY(_status);
//    TT_RELEASE_SAFELY(_useStatus);
//    TT_RELEASE_SAFELY(_zichanLng);
//    TT_RELEASE_SAFELY(_zichanLat);
//    TT_RELEASE_SAFELY(_resp);
//    TT_RELEASE_SAFELY(_fujia);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
