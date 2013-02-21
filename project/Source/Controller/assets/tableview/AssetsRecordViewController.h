//
//  AssetsRecordViewController.h
//  project
//
//  Created by runes on 13-1-23.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Three20UI/Three20UI.h>
#import "AssetsRecord.h"
#import "AutoAdaptedView.h"

typedef enum {
    PageNone,
    PageAssetsSearch,
    PageAssetsStore,
    PageAssetsSite,
    PageAssetsRoom,
    PageAssetsDrop,
} PageTag;

typedef enum {
    FieldTagNone,
    TypeCodeFieldTag,
    UserFieldTag,
    TypeValueFieldTag
}FieldTag;

@interface AssetsRecordViewController : TTViewController<UIAlertViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    AssetsRecord *_assetsRecord;
    NSInteger _pageTag;
    NSInteger _editTag;
    TTButton *_rukuButton;
    AutoAdaptedView *_zichanName;           //资产名称
    AutoAdaptedView *_zichanTypeCode;       //资产类型
    AutoAdaptedView *_zichanFactory;        //厂家
    AutoAdaptedView *_zichanModel;          //型号
    AutoAdaptedView *_assetsCode;           //资产编号
    AutoAdaptedView *_barcode;              //资产条码
    AutoAdaptedView *_assetsOwners;         //资产所有者
    AutoAdaptedView *_startTimeStr;         //使用时间
    AutoAdaptedView *_valid;                //报废年限
    AutoAdaptedView *_status;               //性能状态
    AutoAdaptedView *_remark;               //备注
    AutoAdaptedView *_zichanLng;            //经度
    AutoAdaptedView *_zichanLat;            //纬度
    AutoAdaptedView *_resp;                 //责任人
    AutoAdaptedView *_fujia;                //附加字段,根据资产类型生成不同字段
    AutoAdaptedView *_autoAdaptedView;      //临时中间字段,作为区分操作字段
    NSInteger       _fujiaIndex;            //附加字段的tag值
}
@property (nonatomic,retain) UITableView *alertTableView;
@property (nonatomic,retain) UIAlertView *dataAlertView;
@property (nonatomic,retain) NSMutableArray *alertListContent;
@end
