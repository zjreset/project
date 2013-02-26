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
#import "SysTypeValue.h"
#import "TUser.h"
#import "AssetsTypeTop.h"
#import "AssetsType.h"

@interface AssetsRecordViewController ()

@end
static int LOGINTAG = -1;       //需要退回到登陆状态的TAG标志
static int INPUTHEIGHT = 30;
static int _X = 10;
static int _P = 10;
@implementation AssetsRecordViewController
@synthesize alertTableView,dataAlertView,alertListContent,alertScrollView;

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query
{
    self = [super init];
    if (self) {
        _assetsRecord = [query objectForKey:@"assetsRecord"];
        _editTag = 1;
    }
    return self;
}

- (id)initWithPageTag:(PageTag)pageTag query:(NSDictionary*)query
{
    self = [super init];
    if (self) {
        _editTag = 0;
        _pageTag = pageTag;
        _baseId  = [[query objectForKey:@"baseId"] integerValue];
        _baseType  = [query objectForKey:@"baseType"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    alertTableView = [[UITableView alloc] initWithFrame: CGRectMake(15, 50, 255, 225)];
    alertTableView.delegate = self;
    alertTableView.dataSource = self;
    
    //开启下方工具栏
    [self.navigationController setToolbarHidden:NO];
    NSMutableArray *toolbarArray = [[[NSMutableArray alloc] init] autorelease];
    
    if (_assetsRecord.useStatus) {      //主要区分已经废弃的资产
        NSString *outTitle = @"出库";
        UIBarButtonItem *changeButton;
        int position = 0;
        if (![_assetsRecord.position isKindOfClass:[NSNull class]]) {
            position = _assetsRecord.position.intValue;
        }
        switch (position) {     //区分仓库与其他驻地资产
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
    
    self.navigationItem.leftBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(dismiss)] autorelease];
    
    self.navigationItem.rightBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(saveAssetsRecord)] autorelease];
    
    UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:self.view.frame] autorelease];
    [scrollView setScrollEnabled:YES];
    scrollView.showsVerticalScrollIndicator = TRUE;
    int y = 0;
    
    self.title = @"资产详细信息";
	_zichanName = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, _P, self.view.frame.size.width, INPUTHEIGHT) title:@"资产名称:" inputType:@"input" inputText:_assetsRecord.name inputValue:_assetsRecord.name valueTypeDicCode:nil];
    _zichanName.textField.delegate = self;
    [scrollView addSubview:_zichanName];
    y = y + _zichanName.frame.size.height + 2*_P;
    
	_zichanTypeCode = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"资产类型:" inputType:@"select" inputText:_assetsRecord.typeName inputValue:_assetsRecord.typeCode valueTypeDicCode:nil];
    _zichanTypeCode.textField.delegate = self;
    if (_editTag) {
        _zichanTypeCode.textField.enabled = false;
    }
    else{
        _zichanTypeCode.textField.enabled = true;
    }
    _zichanTypeCode.textField.tag = TypeCodeFieldTag;
    [scrollView addSubview:_zichanTypeCode];
    y = y + _zichanTypeCode.frame.size.height + 2*_P;
    
	_zichanFactory = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"厂家:" inputType:@"select" inputText:_assetsRecord.factory inputValue:_assetsRecord.factory valueTypeDicCode:nil];
    _zichanFactory.textField.delegate = self;
    if (_editTag) {
        _zichanFactory.textField.enabled = false;
    }
    else{
        _zichanFactory.textField.enabled = true;
    }
    _zichanFactory.textField.tag = FactoryFieldTag;
    [scrollView addSubview:_zichanFactory];
    y = y + _zichanFactory.frame.size.height + 2*_P;
    
	_zichanModel = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"型号:" inputType:@"select" inputText:_assetsRecord.model inputValue:_assetsRecord.model valueTypeDicCode:nil];
    _zichanModel.textField.delegate = self;
    if (_editTag) {
        _zichanModel.textField.enabled = false;
    }
    else{
        _zichanModel.textField.enabled = true;
    }
    _zichanModel.textField.tag = ModelFieldTag;
    [scrollView addSubview:_zichanModel];
    y = y + _zichanModel.frame.size.height + 2*_P;
    
	_assetsCode = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"资产编码:" inputType:@"input" inputText:_assetsRecord.assetsCode inputValue:_assetsRecord.assetsCode valueTypeDicCode:nil];
    _assetsCode.textField.delegate = self;
    [scrollView addSubview:_assetsCode];
    y = y + _assetsCode.frame.size.height + 2*_P;
    
	_barcode = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"资产条码:" inputType:@"input" inputText:_assetsRecord.barcode inputValue:_assetsRecord.barcode valueTypeDicCode:nil];
    _barcode.textField.delegate = self;
    [scrollView addSubview:_barcode];
    y = y + _barcode.frame.size.height + 2*_P;
    
	_assetsOwners = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"资产所有权:" inputType:@"select" inputText:[self getTypeValueNameById:_assetsRecord.assetsOwners] inputValue:_assetsRecord.assetsOwners valueTypeDicCode:@"2"];
    _assetsOwners.textField.delegate = self;
    [scrollView addSubview:_assetsOwners];
    y = y + _assetsOwners.frame.size.height + 2*_P;
    
	_startTimeStr = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"使用时间:" inputType:@"date" inputText:_assetsRecord.startTimeStr inputValue:_assetsRecord.startTimeStr valueTypeDicCode:nil];
    _startTimeStr.textField.delegate = self;
    [scrollView addSubview:_startTimeStr];
    y = y + _startTimeStr.frame.size.height + 2*_P;
    
	_valid = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"报废年限(年):" inputType:@"input" inputText:_assetsRecord.valid inputValue:_assetsRecord.valid valueTypeDicCode:nil];
    _valid.textField.delegate = self;
    [scrollView addSubview:_valid];
    y = y + _valid.frame.size.height + 2*_P;
    
	_status = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"性能状态:" inputType:@"select" inputText:[self getTypeValueNameById:_assetsRecord.status] inputValue:_assetsRecord.status valueTypeDicCode:@"3"];
    _status.textField.delegate = self;
    [scrollView addSubview:_status];
    y = y + _status.frame.size.height + 2*_P;
    
	_zichanLng = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"经度:" inputType:@"input" inputText:_assetsRecord.lng inputValue:_assetsRecord.lng valueTypeDicCode:nil];
    _zichanLng.textField.delegate = self;
    [scrollView addSubview:_zichanLng];
    y = y + _zichanLng.frame.size.height + 2*_P;
    
	_zichanLat = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"纬度:" inputType:@"input" inputText:_assetsRecord.lat inputValue:_assetsRecord.lat valueTypeDicCode:nil];
    _zichanLat.textField.delegate = self;
    [scrollView addSubview:_zichanLat];
    y = y + _zichanLat.frame.size.height + 2*_P;
    
	_resp = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"责任人:" inputType:@"select" inputText:[self getUserNameById:_assetsRecord.resp] inputValue:_assetsRecord.resp valueTypeDicCode:nil];
    _resp.textField.delegate = self;
    _resp.textField.tag = UserFieldTag;
    [scrollView addSubview:_resp];
    y = y + _resp.frame.size.height + 2*_P;
    
    //开始附加字段的拼接
    _fujiaIndex = 100;
    for (AssetsProp *assetsProp in _assetsRecord.assetsPropList){
        _fujiaIndex++;
        if (![assetsProp.showStyle isEqual:[NSNull null]] && [assetsProp.showStyle compare:@"textarea"] == NSOrderedSame) {
            _fujia = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:[NSString stringWithFormat:@"%@:",assetsProp.showName] inputType:assetsProp.showStyle inputText:assetsProp.value inputValue:assetsProp.value valueTypeDicCode:assetsProp.valueTypeDicCode];
        }
        else if (![assetsProp.showStyle isEqual:[NSNull null]] && [assetsProp.showStyle compare:@"select"] == NSOrderedSame) {
            _fujia = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:[NSString stringWithFormat:@"%@:",assetsProp.showName] inputType:assetsProp.showStyle inputText:[self getTypeValueNameById:assetsProp.value] inputValue:assetsProp.value valueTypeDicCode:assetsProp.valueTypeDicCode];
            _fujia.textValue = assetsProp.value;
        }
        else if (![assetsProp.showStyle isEqual:[NSNull null]] && [assetsProp.showStyle compare:@"radio"] == NSOrderedSame) {
            _fujia = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:[NSString stringWithFormat:@"%@:",assetsProp.showName] inputType:assetsProp.showStyle inputText:[self getTypeValueNameById:assetsProp.value] inputValue:assetsProp.value valueTypeDicCode:assetsProp.valueTypeDicCode];
            _fujia.textValue = assetsProp.value;
        }
        else{
            _fujia = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:[NSString stringWithFormat:@"%@:",assetsProp.showName] inputType:assetsProp.showStyle inputText:assetsProp.value inputValue:assetsProp.value valueTypeDicCode:assetsProp.valueTypeDicCode];
        }
        _fujia.frame = CGRectMake(_X, y, self.view.frame.size.width, _fujia.viewHeight);
        _fujia.tag = _fujiaIndex;
        _fujia.textField.delegate = self;
        [scrollView addSubview:_fujia];
        y = y + _fujia.frame.size.height + 2*_P;
    }
    
    _remark = [[AutoAdaptedView alloc] initWithFrame:CGRectMake(_X, y, self.view.frame.size.width, INPUTHEIGHT) title:@"备注:" inputType:@"input" inputText:_assetsRecord.remark inputValue:_assetsRecord.remark valueTypeDicCode:nil];
    _remark.textField.delegate = self;
    [scrollView addSubview:_remark];
    y = y + _remark.frame.size.height + 2*_P;
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, y);
    
    UIControl *_back = [[UIControl alloc] initWithFrame:self.view.frame];
    [(UIControl *)_back addTarget:self action:@selector(backgroundTap:) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:_back];
    _back.frame = CGRectMake(0, 0, self.view.frame.size.width, y);
    [_back release];
    [scrollView sendSubviewToBack:_back];
    
//    [scrollView bringSubviewToFront:_zichanName];
//    [scrollView bringSubviewToFront:_zichanTypeCode];
//    [scrollView bringSubviewToFront:_zichanFactory];
//    [scrollView bringSubviewToFront:_zichanModel];
//    [scrollView bringSubviewToFront:_assetsCode];
//    [scrollView bringSubviewToFront:_barcode];
//    [scrollView bringSubviewToFront:_assetsOwners];
//    [scrollView bringSubviewToFront:_startTimeStr];
//    [scrollView bringSubviewToFront:_valid];
//    [scrollView bringSubviewToFront:_status];
//    [scrollView bringSubviewToFront:_zichanLng];
//    [scrollView bringSubviewToFront:_zichanLat];
//    //[scrollView bringSubviewToFront:_fujia];
//    [scrollView bringSubviewToFront:_resp];
//    [scrollView bringSubviewToFront:_remark];
//    
//    for (int j=i; j>100; j--) {
//        NSLog(@"ddd:%i",j);
//        AutoAdaptedView *aav = (AutoAdaptedView*)[self.view viewWithTag:j];
//        [scrollView bringSubviewToFront:aav];
//    }
    
    self.view = scrollView;
    
    dataAlertView = [[UIAlertView alloc] initWithTitle: @"请选择"
                                               message: @"\n\n\n\n\n\n\n\n\n\n\n"
                                              delegate: nil
                                     cancelButtonTitle: @"取消"
                                     otherButtonTitles: nil];
}

//保存资产编辑信息
- (void)saveAssetsRecord
{
    if (!_zichanName.textField.text || [_zichanName.textField.text isKindOfClass:[NSNull class]] || _zichanName.textField.text.length == 0) {
        UIAlertView * alert= [[UIAlertView alloc] initWithTitle:@"资产名称不能为空!" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    else if (!_zichanTypeCode.textField.text || [_zichanTypeCode.textField.text isKindOfClass:[NSNull class]] || _zichanTypeCode.textField.text.length == 0) {
        UIAlertView * alert= [[UIAlertView alloc] initWithTitle:@"资产类型不能为空!" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    else if ((!_assetsCode.textField.text || [_assetsCode.textField.text isKindOfClass:[NSNull class]] || _assetsCode.textField.text.length == 0) && ((_barcode.textField.text || [_barcode.textField.text isKindOfClass:[NSNull class]] || _barcode.textField.text.length == 0))) {
        UIAlertView * alert= [[UIAlertView alloc] initWithTitle:@"资产编码和资产条码不能同时为空!" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *server_base;
    NSString *assetsRecordStr;
    //修改
    if (_editTag) {
        server_base = [NSString stringWithFormat:@"%@/assets/assetsrecord!assetsEdit.action", delegate.SERVER_HOST];
        assetsRecordStr = [[NSString alloc] initWithString:@"assetsRecordUpdate:1"];
    }
    else{//新增
        server_base = [NSString stringWithFormat:@"%@/assets/assetsrecord!assetsInsert.action", delegate.SERVER_HOST];
        assetsRecordStr = [[NSString alloc] initWithString:@"assetsRecordUpdate:0"];
    }
    TTURLRequest* request = [TTURLRequest requestWithURL: server_base delegate: self];
    [request setHttpMethod:@"POST"];
    if (![_zichanName.textField.text isKindOfClass:[NSNull class]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",name:'%@'",_zichanName.textField.text];
    }
    if (!_editTag) {
        if (![_zichanTypeCode.textField.text isKindOfClass:[NSNull class]]) {
            assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",assetsTypeCode:'%@'",_zichanTypeCode.textValue];
        }
        if (![_zichanFactory.textValue isKindOfClass:[NSNull class]]) {
            assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",factory:'%@'",_zichanFactory.textValue];
        }
        if (![_zichanModel.textValue isKindOfClass:[NSNull class]]) {
            assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",model:'%@'",_zichanModel.textValue];
        }
    }
    if (_zichanTypeCode.textValue != nil && ![_zichanTypeCode.textValue isKindOfClass:[NSNull class]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",typeCode:'%@'",_zichanTypeCode.textValue];
    }
    if (_assetsCode.textField.text != nil && ![_assetsCode.textField.text isKindOfClass:[NSNull class]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",assetsCode:'%@'",_assetsCode.textField.text];
    }
    if (_barcode.textField.text != nil && ![_barcode.textField.text isKindOfClass:[NSNull class]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",barcode:'%@'",_barcode.textField.text];
    }
    if (_assetsOwners.textValue != nil &&![_assetsOwners.textField.text isKindOfClass:[NSNull class]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",assetsOwners:'%@'",_assetsOwners.textValue];
    }
    if (_startTimeStr.textField.text != nil && ![_startTimeStr.textField.text isKindOfClass:[NSNull class]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",startTimeStr:'%@'",_startTimeStr.textField.text];
    }
    if (_valid.textField.text != nil && ![_valid.textField.text isKindOfClass:[NSNull class]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",valid:'%@'",_valid.textField.text];
    }
    if (_status.textValue != nil && ![_status.textField.text isKindOfClass:[NSNull class]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",status:'%@'",_status.textValue];
    }
    if (_zichanLng.textField.text != nil && ![_zichanLng.textField.text isKindOfClass:[NSNull class]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",lng:'%@'",_zichanLng.textField.text];
    }
    if (_zichanLat.textField.text != nil && ![_zichanLat.textField.text isKindOfClass:[NSNull class]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",lat:'%@'",_zichanLat.textField.text];
    }
    if (_remark.textField.text != nil && ![_remark.textField.text isKindOfClass:[NSNull class]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",remark:'%@'",_remark.textField.text];
    }
    if (_resp.textField.text != nil && ![_resp.textField.text isKindOfClass:[NSNull class]]) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",resp:'%@'",_resp.textValue];
    }
    if (_assetsRecord.assetsId) {
        assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",assetsId:%i",_assetsRecord.assetsId];
    }
    NSString *propStr = [[NSString alloc] init];
    _fujiaIndex = 100;
    for (AssetsProp *assetsProp in _assetsRecord.assetsPropList){
        _fujiaIndex++;
        AutoAdaptedView *aav = (AutoAdaptedView*)[self.view viewWithTag:_fujiaIndex];
        if (aav.inputType != nil && ![aav.inputType isEqual:[NSNull null]] && ([aav.inputType compare:@"select"] == NSOrderedSame || [aav.inputType compare:@"radio"] == NSOrderedSame)) {
            if (aav.textValue != nil && ![aav.textValue isKindOfClass:[NSNull class]]) {
                propStr = [propStr stringByAppendingFormat:@",%@:'%@'",[assetsProp.name stringByReplacingOccurrencesOfString:@"a_f" withString:@"AF"],aav.textValue];
            }
            else{
                propStr = [propStr stringByAppendingFormat:@",%@:''",[assetsProp.name stringByReplacingOccurrencesOfString:@"a_f" withString:@"AF"]];
            }
        }
        else{
            if (aav.textField.text != nil && ![aav.textField.text isKindOfClass:[NSNull class]]) {
                propStr = [propStr stringByAppendingFormat:@",%@:'%@'",[assetsProp.name stringByReplacingOccurrencesOfString:@"a_f" withString:@"AF"],aav.textField.text];
            }
            else{
                propStr = [propStr stringByAppendingFormat:@",%@:''",[assetsProp.name stringByReplacingOccurrencesOfString:@"a_f" withString:@"AF"]];
            }
        }
    }
    assetsRecordStr = [assetsRecordStr stringByAppendingFormat:@",assetsRecordProp:{assetsId:%i%@}",_assetsRecord.assetsId,propStr];
    
    NSLog(@"提交的数据---%@",assetsRecordStr);
    request.contentType=@"application/x-www-form-urlencoded";
    NSString* postBodyString = [NSString stringWithFormat:@"isMobile=true&baseId=%i&baseType=%@&assertRecordJson={%@}",_baseId,_baseType,assetsRecordStr];
    //postBodyString = [postBodyString stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    postBodyString = [postBodyString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    request.cachePolicy = TTURLRequestCachePolicyNoCache;
    NSData* postData = [NSData dataWithBytes:[postBodyString UTF8String] length:[postBodyString length]];
    
    [request setHttpBody:postData];
    request.userInfo = @"saveInfo";
    
    [request send];
    
    request.response = [[[TTURLDataResponse alloc] init] autorelease];
}

- (NSString*)getTypeValueNameById:(NSString*)sId
{
    if (![sId isKindOfClass:[NSNull class]]) {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        for(SysTypeValue *sysTypeValue in delegate.sysTypeValueList){
            if (sysTypeValue != nil && [sysTypeValue.sId compare: sId] == NSOrderedSame) {
                return sysTypeValue.name;
            }
        }
    }
    return nil;
}

- (NSString*)getUserNameById:(NSString*)userId
{
    if (![userId isKindOfClass:[NSNull class]]) {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        for(TUser *tUser in delegate.userList){
            if (tUser != nil && tUser.userId == userId.intValue) {
                return tUser.realName;
            }
        }
    }
    return nil;
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
        static NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch | NSNumericSearch | NSWidthInsensitiveSearch | NSForcedOrderingSearch;
        if (request.userInfo != nil && [request.userInfo compare:@"AssetsProp" options:comparisonOptions] == NSOrderedSame) {
            AssetsProp *assetsProp = [[AssetsProp alloc] init];
            _assetsRecord.assetsPropList = [assetsProp initAssetsPropWithJsonDict:[jsonDic objectForKey:@"assetsPropList"]];
            TT_RELEASE_SAFELY(assetsProp);
            [self viewDidLoad];
        }
        else if (request.userInfo != nil && [request.userInfo compare:@"saveInfo" options:comparisonOptions] == NSOrderedSame) {
            UIAlertView * alert= [[UIAlertView alloc] initWithTitle:@"保存成功!" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
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
    alert.tag = AlertViewTagDrop;
    
    [alert show];
    //释放
    [alert release];
}

//资产替换
- (void)changeStore
{
    UIAlertView * alert= [[UIAlertView alloc] initWithTitle:@"资产替换!" message:@"\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
    alert.tag = AlertViewTagChange;
    
    [alert addSubview: alertScrollView];
    [alert show];
    //释放
    [alert release];
}

//出库,拆除资产
- (void)outStore
{
    CAlertView * alert;
    int position;
    if (![_assetsRecord.position isKindOfClass:[NSNull class]]) {
        position = _assetsRecord.position.intValue;
    }
    UIScrollView* view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor grayColor]];
    [button setFrame:CGRectMake(0, 0, 80, 20)];
    [button setTitle:@"消失" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(alertDismiss) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UILabel *label;
    UITextField *outType;
    label = [[UILabel alloc] initWithFrame:CGRectMake(5, 55, 45, 30)];
    label.text = @"出库类型:";
    [view addSubview:label];
    TT_RELEASE_SAFELY(label);
    outType = [[UITextField alloc] initWithFrame:CGRectMake(55, 5, 160, 30)];
    [view addSubview:outType];
    TT_RELEASE_SAFELY(outType);
    switch (position) {
        case 4:
//            alert = [[CAlertView alloc] initWithTitle:@"资产出库" message:@"\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
//            alert.tag = AlertViewTagOut;
//            label = [[UILabel alloc] initWithFrame:CGRectMake(alert.frame.origin.x + 5, alert.frame.origin.y + 55, 45, 30)];
//            label.text = @"出库类型:";
//            [alert addSubview:label];
//            TT_RELEASE_SAFELY(label);
//            outType = [[UITextField alloc] initWithFrame:CGRectMake(alert.frame.origin.x + 55, alert.frame.origin.y + 5, alert.frame.size.width-60, 30)];
//            [alert addSubview:outType];
//            TT_RELEASE_SAFELY(outType);
//            [alert show];
            break;
        default:
//            alert = [[UIAlertView alloc] initWithTitle:@"资产拆除" message:@"拆除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
//            alert.tag = AlertViewTagOut;
//            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//            UITextField *textField = [alert textFieldAtIndex:0];
//            textField.size = CGSizeMake(20, 30);
//            textField.keyboardType = UIKeyboardTypeDefault;
//            [alert addSubview:textField];
//            [alert show];
            
            
            break;
    }
    alert = [[CAlertView alloc] initWithView:view];
    alert.delegate = self;
    [view release];
    view = nil;
    [alert show];
    //释放
    [alert release];
}

//-(void)alertDismiss{
//    [alert dismissAlertViewWithAnimated:YES];
//    [alert release];
//    alert  = nil;
//}

-(void)didRotationToInterfaceOrientation:(BOOL)Landscape view:(UIView*)view alertView:(CAlertView*)aletView{
    if (Landscape) {
        [view setFrame:CGRectMake(0, 0, 300, 200)];
        [aletView.backGroundView setBackgroundColor:[UIColor whiteColor]];
    }else{
        [view setFrame:CGRectMake(0, 0, 200, 200)];
        [aletView.backGroundView setBackgroundColor:[UIColor greenColor]];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
        NSLog(@"cancel%i", buttonIndex);
    }
    else {
        NSLog(@"---%i", alertView.tag);
        for (UIView *view in [alertView subviews])                 {
            if ([view isKindOfClass:[UITextField class]]){
                UITextField *textName = (UITextField *)view;
                NSLog(@"%@",textName.text);
            }
        }
    }
}

- (void)dealloc
{
    [super dealloc];
    TT_RELEASE_SAFELY(dataAlertView);
    TT_RELEASE_SAFELY(alertTableView);
    TT_RELEASE_SAFELY(alertListContent);
    //TT_RELEASE_SAFELY(_assetsRecord);
    //TT_RELEASE_SAFELY(_rukuButton);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 解决虚拟键盘挡住UITextField的方法
- (void)keyboardWillShow:(NSNotification *)noti
{
    //键盘输入的界面调整
    //键盘的高度
    float height = 216.0;
    CGRect frame = self.view.frame;
    frame.size = CGSizeMake(frame.size.width, frame.size.height - height);
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.view setFrame:frame];
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _autoAdaptedView = (AutoAdaptedView*)textField.superview;
    if (![_autoAdaptedView.inputType isEqual:[NSNull null]] && [_autoAdaptedView.inputType compare:@"select"] == NSOrderedSame) {
        [self dropdown:textField];
        [textField resignFirstResponder];
    }
    else if (![_autoAdaptedView.inputType isEqual:[NSNull null]] && [_autoAdaptedView.inputType compare:@"date"] == NSOrderedSame) {
        CGRect frame = textField.superview.frame;
        int offset = frame.origin.y- (textField.superview.superview.frame.size.height - 216.0)+30-textField.superview.superview.bounds.origin.y;//键盘高度216+header30-滚动偏移
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width = self.view.frame.size.width;
        float height = self.view.frame.size.height;
        if(offset > 0)
        {
            CGRect rect = CGRectMake(0.0f, -offset,width,height);
            self.view.frame = rect;
        }
        [UIView commitAnimations];
    }
    else if (![_autoAdaptedView.inputType isEqual:[NSNull null]] && [_autoAdaptedView.inputType compare:@"radio"] == NSOrderedSame) {
        [textField resignFirstResponder];
    }
    else{
        CGRect frame = textField.superview.frame;
        int offset = frame.origin.y- (textField.superview.superview.frame.size.height - 216.0)+30-textField.superview.superview.bounds.origin.y;//键盘高度216+header30-滚动偏移
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width = self.view.frame.size.width;
        float height = self.view.frame.size.height;
        if(offset > 0)
        {
            CGRect rect = CGRectMake(0.0f, -offset,width,height);
            self.view.frame = rect;
        }
        [UIView commitAnimations];
    }
}

//下拉列表
- (void)dropdown:(id)sender
{
    UITextField *textField = (UITextField*)sender;
    if (textField.tag == UserFieldTag) {
        alertListContent = [self getSelectUserList];
    }
    else if(textField.tag == TypeCodeFieldTag){
        alertListContent = [self getSelectAssetsTypeTopList];
    }
    else if (textField.tag == FactoryFieldTag){
        alertListContent = [self getSelectFactoryList];
    }
    else if (textField.tag == ModelFieldTag){
        alertListContent = [self getSelectModelList];
    }
    else{
        alertListContent = [self getSelectList:_autoAdaptedView.valueTypeDicCode];
    }
    [alertTableView reloadData];
    [dataAlertView addSubview: alertTableView];
    [dataAlertView show];
}

- (NSMutableArray*)getSelectFactoryList
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray* resultList = [[NSMutableArray alloc] init];
//    NSMutableArray* tempList = [[NSMutableArray alloc] init];
//    if (_zichanModel.textField.text != nil && ![_zichanModel.textField.text isEqual:[NSNull null]] && [[_zichanModel.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]>0) {
//        for (AssetsType *assetsType in delegate.assetsTypeList) {
//            if ([_zichanModel.textField.text compare:assetsType.model] == NSOrderedSame) {
//                [tempList addObject:assetsType];
//            }
//        }
//    }
//    else {
//        tempList = [[NSMutableArray alloc] initWithArray:delegate.assetsTypeList];
//    }
    NSMutableArray* tempList = [[NSMutableArray alloc] initWithArray:delegate.assetsTypeList];
    bool present = false;
    for (AssetsType *assetsType1 in tempList) {
        if (assetsType1.factory && ![assetsType1.factory isEqual:[NSNull null]] && [[assetsType1.factory stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]>0) {
            present = false;
            for (AssetsType *assetsType2 in resultList) {
                if ([assetsType1.factory compare:assetsType2.factory] == NSOrderedSame && assetsType1.typeId != assetsType2.typeId) {
                    present = true;
                }
            }
            if (!present) {
                [resultList addObject:assetsType1];
            }
        }
    }
    TT_RELEASE_SAFELY(tempList);
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"factory" ascending:YES];//其中，price为数组中的对象的属性，这个针对数组中存放对象比较更简洁方便
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    [resultList sortUsingDescriptors:sortDescriptors];
    [sortDescriptor release];
    [sortDescriptors release];
    return resultList;
}

- (NSMutableArray*)getSelectModelList
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray* tempList = [[NSMutableArray alloc] init];
    NSMutableArray* resultList = [[NSMutableArray alloc] init];
    if (_zichanFactory.textField.text != nil && ![_zichanFactory.textField.text isEqual:[NSNull null]] && [[_zichanFactory.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]>0) {
        for (AssetsType *assetsType in delegate.assetsTypeList) {
            if ([_zichanFactory.textField.text compare:assetsType.factory] == NSOrderedSame) {
                [tempList addObject:assetsType];
            }
        }
    }
    else {
        tempList = [[NSMutableArray alloc] initWithArray:delegate.assetsTypeList];
    }
    bool present = false;
    for (AssetsType *assetsType1 in tempList) {
        if (assetsType1.model != nil && ![assetsType1.model isEqual:[NSNull null]]) {
            present = false;
            for (AssetsType *assetsType2 in resultList) {
                if ([assetsType1.model compare:assetsType2.model] == NSOrderedSame && assetsType1.typeId != assetsType2.typeId) {
                    present = true;
                }
            }
            if (!present) {
                [resultList addObject:assetsType1];
            }
        }
    }
    TT_RELEASE_SAFELY(tempList);
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"model" ascending:YES];//其中，price为数组中的对象的属性，这个针对数组中存放对象比较更简洁方便
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    [resultList sortUsingDescriptors:sortDescriptors];
    [sortDescriptor release];
    [sortDescriptors release];
    return resultList;
}

- (NSMutableArray*)getSelectUserList
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray* resultList = [[NSMutableArray alloc] initWithArray:delegate.userList];
    return resultList;
}

- (NSMutableArray*)getSelectAssetsTypeTopList
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray* resultList = [[NSMutableArray alloc] initWithArray:delegate.assetsTypeTopList];
    return resultList;
}

- (NSMutableArray*)getSelectList:(NSString*)typeId
{
    NSInteger tid = 0;
    if (![typeId isKindOfClass:[NSNull class]]) {
        tid = typeId.intValue;
    }
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray* resultList = [[NSMutableArray alloc] init];
    for(SysTypeValue *sysTypeValue in delegate.sysTypeValueList){
        if (sysTypeValue != nil && sysTypeValue.typeId == tid) {
            [resultList addObject:sysTypeValue];
        }
    }
    return resultList;
}

#pragma mark -

#pragma mark -
#pragma mark 触摸背景来关闭虚拟键盘
-(IBAction)backgroundTap:(id)sender
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    
    [_zichanName.textField resignFirstResponder];
    //[_zichanTypeCode.textField resignFirstResponder];
    [_zichanFactory.textField resignFirstResponder];
    [_zichanModel.textField resignFirstResponder];
    [_assetsCode.textField resignFirstResponder];
    [_barcode.textField resignFirstResponder];
    //[_assetsOwners.textField resignFirstResponder];
    [_startTimeStr.textField resignFirstResponder];
    [_valid.textField resignFirstResponder];
    [_status.textField resignFirstResponder];
    [_zichanLng.textField resignFirstResponder];
    [_zichanLat.textField resignFirstResponder];
    [_fujia.textField resignFirstResponder];
    [_resp.textField resignFirstResponder];
    [_remark.textField resignFirstResponder];
    for (int j=_fujiaIndex; j>100; j--) {
        AutoAdaptedView *aav = (AutoAdaptedView*)[self.view viewWithTag:j];
        [aav.textField resignFirstResponder];
    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [alertListContent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (_autoAdaptedView.textField.tag == UserFieldTag) {
        TUser *tuser;
        tuser = [alertListContent objectAtIndex:indexPath.row];
        cell.textLabel.text = tuser.realName;
    }
    else if(_autoAdaptedView.textField.tag == TypeCodeFieldTag){
        AssetsTypeTop *att;
        att = [alertListContent objectAtIndex:indexPath.row];
        cell.textLabel.text = att.assetsTypeName;
    }
    else if(_autoAdaptedView.textField.tag == FactoryFieldTag){
        AssetsType *att;
        att = [alertListContent objectAtIndex:indexPath.row];
        cell.textLabel.text = att.factory;
    }
    else if(_autoAdaptedView.textField.tag == ModelFieldTag){
        AssetsType *att;
        att = [alertListContent objectAtIndex:indexPath.row];
        cell.textLabel.text = att.model;
    }
    else{
        SysTypeValue *stv;
        stv = [alertListContent objectAtIndex:indexPath.row];
        cell.textLabel.text = stv.name;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //给下拉框赋值
    if (_autoAdaptedView.textField.tag == UserFieldTag) {
        TUser *tuser;
        tuser = [alertListContent objectAtIndex:indexPath.row];
        _autoAdaptedView.textValue = [NSString stringWithFormat:@"%i",tuser.userId];
        _autoAdaptedView.textField.text = tuser.realName;
    }
    else if (_autoAdaptedView.textField.tag == TypeCodeFieldTag) {
        AssetsTypeTop *att;
        att = [alertListContent objectAtIndex:indexPath.row];
        _autoAdaptedView.textValue = att.assetsTypeCode;
        _autoAdaptedView.textField.text = att.assetsTypeName;
        [self setNewAssetsRecordProp:att.assetsTypeCode];
        _assetsRecord = [[AssetsRecord alloc] init];
        _assetsRecord.typeCode = att.assetsTypeCode;
        _assetsRecord.typeName = att.assetsTypeName;
        _assetsRecord.name = _zichanName.textField.text;
    }
    else if (_autoAdaptedView.textField.tag == FactoryFieldTag){
        AssetsType *at;
        at = [alertListContent objectAtIndex:indexPath.row];
        _autoAdaptedView.textField.text = at.factory;
        _autoAdaptedView.textValue = at.factory;
    }
    else if (_autoAdaptedView.textField.tag == ModelFieldTag){
        AssetsType *at;
        at = [alertListContent objectAtIndex:indexPath.row];
        _autoAdaptedView.textField.text = at.model;
        _autoAdaptedView.textValue = at.model;
    }
    else{
        SysTypeValue *stv;
        stv = [alertListContent objectAtIndex:indexPath.row];
        _autoAdaptedView.textValue = stv.sId;
        _autoAdaptedView.textField.text = stv.name;
    }
    NSUInteger cancelButtonIndex = dataAlertView.cancelButtonIndex;
    [dataAlertView dismissWithClickedButtonIndex: cancelButtonIndex animated: YES];
}

//设置新资产的类型字段
- (void)setNewAssetsRecordProp:(NSString*)assetsTypeCode
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *server_base = [NSString stringWithFormat:@"%@/assets/assetsrecord!getAssetsPropHtml.action", delegate.SERVER_HOST];
    TTURLRequest* request = [TTURLRequest requestWithURL: server_base delegate: self];
    [request setHttpMethod:@"POST"];
    
    request.contentType=@"application/x-www-form-urlencoded";
    NSString* postBodyString = [NSString stringWithFormat:@"isMobile=true&assetsTypeCode=%@",assetsTypeCode];
    postBodyString = [postBodyString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    request.cachePolicy = TTURLRequestCachePolicyNoCache;
    NSData* postData = [NSData dataWithBytes:[postBodyString UTF8String] length:[postBodyString length]];
    
    [request setHttpBody:postData];
    request.userInfo = @"AssetsProp";
    [request send];
    
    request.response = [[[TTURLDataResponse alloc] init] autorelease];
}


@end
