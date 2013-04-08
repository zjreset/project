//
//  AssetsTypeTop.h
//  project
//
//  Created by runes on 13-2-1.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssetsTypeTop : NSObject<TTModel>

@property (nonatomic) NSInteger assetsTypeTopId;
@property (nonatomic, retain) NSString *assetsTypeCode;
@property (nonatomic, retain) NSString *assetsTypeName;
@property (nonatomic, retain) NSString *remark;
@property (nonatomic, retain) NSString *icon;
@property (nonatomic, retain) NSString *icon95;
@property (nonatomic, retain) NSString *icon170;
@property (nonatomic, retain) NSString *count;
@property (nonatomic, retain) NSString *URL;
-(NSMutableArray*) initAssetsTypeTop:(NSDictionary *)jsonDic;
@end
