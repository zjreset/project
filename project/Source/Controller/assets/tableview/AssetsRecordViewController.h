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
#import "CAlertView.h"
#import "TitleValueLabelView.h"
#import "CommonEnum.h"

@interface AssetsRecordViewController : TTViewController<UIAlertViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,CAlertViewDelegate>
{
    AssetsRecord *_assetsRecord;
    MenuPage _pageTag;
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
    NSInteger       _baseId;                //新增资产时的关联物理点编号
    NSString        *_baseType;             //新增资产时的类型
    
    NSInteger       _assetsIdNew;           //需要替换的资产ID
    
    AutoAdaptedView *_outStoreType;         //出库类型
    AutoAdaptedView *_outStoreCode;         //项目编号
    AutoAdaptedView *_storePerson;          //出库领用人,归还人
    AutoAdaptedView *_storeMemo;            //出库备注,拆除备注,报废备注
    AutoAdaptedView *_assetsCodeNew;        //替换的资产编号
    AutoAdaptedView *_barcodeNew;           //替换的资产条码
    
    TitleValueLabelView *_zichanNameLabel;           //资产名称
    TitleValueLabelView *_zichanTypeCodeLabel;       //资产类型
    TitleValueLabelView *_zichanFactoryLabel;        //厂家
    TitleValueLabelView *_zichanModelLabel;          //型号
    TitleValueLabelView *_assetsOwnersLabel;         //资产所有者
    TitleValueLabelView *_startTimeStrLabel;         //使用时间
    TitleValueLabelView *_validLabel;                //报废年限
    TitleValueLabelView *_statusLabel;               //性能状态
    TitleValueLabelView *_remarkLabel;               //备注
    TitleValueLabelView *_zichanLngLabel;            //经度
    TitleValueLabelView *_zichanLatLabel;            //纬度
    TitleValueLabelView *_respLabel;                 //责任人
}
@property (nonatomic,retain) UITableView *alertTableView;
@property (nonatomic,retain) UIScrollView *alertScrollView;
@property (nonatomic,retain) UIAlertView *dataAlertView;
@property (nonatomic,retain) CAlertView *updateAlertView;
@property (nonatomic,retain) NSMutableArray *alertListContent;
@end
