//
//  CommonEnum.h
//  project
//
//  Created by runes on 13-3-2.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    MenuPageNone,
    MenuPageAssetsSearch,
    MenuPageAssetsStore,
    MenuPageAssetsSite,
    MenuPageAssetsRoom,
    MenuPageAssetsCar,
    MenuPageAssetsDrop
} MenuPage;

typedef enum {
    FieldTagNone,
    TypeCodeFieldTag,
    UserFieldTag,
    TypeValueFieldTag,
    FactoryFieldTag,
    ModelFieldTag,
    outStoreFieldTag
}FieldTag;

typedef enum {
    AlertViewTagNone,
    AlertViewTagIn,
    AlertViewTagReturnHouse,
    AlertViewTagChange,
    AlertViewTagOut,
    AlertViewTagOutHouse,
    AlertViewTagDrop
}AlertViewTag;


@interface CommonEnum : NSObject

@end
