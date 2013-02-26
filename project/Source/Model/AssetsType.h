//
//  AssetsType.h
//  project
//
//  Created by runes on 13-2-22.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssetsType : NSObject
@property (nonatomic, retain) NSString *typeCode;
@property (nonatomic, retain) NSString *assetsTypeDicCode;
@property (nonatomic, assign) NSInteger typeId;
@property (nonatomic, retain) NSString *typeName;
@property (nonatomic, retain) NSString *factory;
@property (nonatomic, retain) NSString *model;
@property (nonatomic, retain) NSString *remark;
@property (nonatomic, retain) NSString *assetsTypeCode;
@property (nonatomic, assign) NSInteger assetsId;
@property (nonatomic, retain) NSString *iconCls;
-(NSMutableArray*) initAssetsType:(NSDictionary *)jsonDic;

@end
