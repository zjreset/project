//
//  AssetsRecord.h
//  project
//
//  Created by runes on 13-1-21.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssetsRecord : NSObject<TTModel>

@property (nonatomic) NSInteger assetsId;
@property (nonatomic) NSInteger baseId;
@property (nonatomic, retain) NSString *baseCode;
@property (nonatomic, retain) NSString *typeCode;
@property (nonatomic, retain) NSString *barcode;
@property (nonatomic, retain) NSString *assetsCode;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *pinyin;
@property (nonatomic, retain) NSString *position;
@property (nonatomic, retain) NSString *assetsOwners;
@property (nonatomic, retain) NSString *status;
@property (nonatomic) NSInteger useStatus;
@property (nonatomic, retain) NSString *startTimeStr;
@property (nonatomic, retain) NSString * valid;
@property (nonatomic) NSInteger isChange;
@property (nonatomic, retain) NSString *changeType;
@property (nonatomic, retain) NSString *lng;
@property (nonatomic, retain) NSString *lat;
@property (nonatomic, retain) NSString *resp;
@property (nonatomic, retain) NSString *remark;
@property (nonatomic, retain) NSString *typeName;
@property (nonatomic, retain) NSString *factory;
@property (nonatomic, retain) NSString *model;
@property (nonatomic, retain) NSString *assetsTypeCode;
@property (nonatomic, retain) NSString *noteTimeStr;
@property (nonatomic, retain) NSString *noteUser;
@property (nonatomic, retain) NSString *positionName;
@property (nonatomic, retain) NSString *photoPath;
@property (nonatomic, retain) NSMutableArray *assetsPropList;

-(NSMutableArray*) initAssetsRecord:(NSDictionary *)jsonDic;
@end
