//
//  SysTypeValue.h
//  project
//
//  Created by runes on 13-2-17.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SysTypeValue : NSObject

@property (nonatomic, retain) NSString *sId;
@property (nonatomic) NSInteger typeId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *nameNls;
@property (nonatomic, retain) NSString *nameEn;
@property (nonatomic, retain) NSString *parentId;
@property (nonatomic) NSInteger sortNum;
@property (nonatomic) NSInteger isUsed;

-(NSMutableArray*) initSysTypeValue:(NSDictionary *)jsonDic;

@end
