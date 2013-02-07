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

@interface AssetsRecordViewController : TTViewController<UIAlertViewDelegate>
{
    AssetsRecord *_assetsRecord;
    NSInteger _pageTag;
    TTButton *_rukuButton;
    AutoAdaptedView *_zichanName;
    AutoAdaptedView *_zichanFactory;
    AutoAdaptedView *_typeName;
    AutoAdaptedView *_assetsCode;
    AutoAdaptedView *_barcode;
    AutoAdaptedView *_assetsOwners;
    AutoAdaptedView *_startTimeStr;
    AutoAdaptedView *_valid;
    AutoAdaptedView *_status;
    AutoAdaptedView *_remark;
    AutoAdaptedView *_zichanLng;
    AutoAdaptedView *_zichanLat;
    AutoAdaptedView *_resp;
    AutoAdaptedView *_fujia;
}
@end
