//
//  AssetsRecordViewController.h
//  project
//
//  Created by runes on 13-1-23.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Three20UI/Three20UI.h>
#import "AssetsRecord.h"

typedef enum {
    PageNone,
    PageAssetsSearch,
    PageAssetsStore,
    PageAssetsSite,
    PageAssetsRoom,
    PageAssetsDrop,
} PageTag;

@interface AssetsRecordViewController : TTViewController
{
    AssetsRecord *_assetsRecord;
    NSInteger _pageTag;
    TTButton *_rukuButton;
}
@end
