//
//  EntityBase.h
//  project
//
//  Created by runes on 13-1-31.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntityBase : NSObject<TTModel>

@property (nonatomic) NSInteger baseId;
@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSString *baseName;
@property (nonatomic, retain) NSString *baseType;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *statusName;

-(NSMutableArray*) initEntityBase:(NSDictionary *)jsonDic;
@end
