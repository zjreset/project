//
//  TUser.h
//  project
//
//  Created by runes on 13-2-19.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TUser : NSObject

@property (nonatomic) NSInteger userId;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic) NSInteger departmentId;
@property (nonatomic, retain) NSString *departmentName;
@property (nonatomic) NSInteger LogonTimes;
@property (nonatomic, retain) NSString *lastAccessIp;
@property (nonatomic, retain) NSString *lastAccessTimeStr;
@property (nonatomic, retain) NSString *realName;
@property (nonatomic, retain) NSString *gendar;
@property (nonatomic) NSInteger enable;
@property (nonatomic, retain) NSString *city;
-(NSMutableArray*) initTUser:(NSDictionary *)jsonDic;
@end
