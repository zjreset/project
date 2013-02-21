//
//  AssetsProp.h
//  project
//
//  Created by runes on 13-2-6.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssetsProp : NSObject

@property (nonatomic) NSInteger propId;
@property (nonatomic, retain) NSString *assetsTypeCode;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *type;
@property (nonatomic) NSInteger innerOder;
@property (nonatomic) NSInteger isShow;
@property (nonatomic) NSInteger isSearch;
@property (nonatomic, retain) NSString *searchMethod;
@property (nonatomic) NSInteger sortNumb;;
@property (nonatomic, retain) NSString *showStyle;
@property (nonatomic) NSInteger isValueDic;
@property (nonatomic, retain) NSString *showName;
@property (nonatomic) NSInteger accessLimit;
@property (nonatomic, retain) NSString *valueTypeDicCode;
@property (nonatomic, retain) NSString *valueTypeDicName;;
@property (nonatomic, retain) NSString *value;

-(NSMutableArray*) initAssetsPropWithJsonStr:(NSString *)jsonStr;
-(NSMutableArray*) initAssetsPropWithJsonDict:(NSDictionary *)jsonDic;

@end
