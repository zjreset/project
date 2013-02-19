//
//  TUser.m
//  project
//
//  Created by runes on 13-2-19.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "TUser.h"

@implementation TUser
@synthesize userId,userName,departmentId,departmentName,lastAccessIp,lastAccessTimeStr,LogonTimes,realName,gendar,enable,city;

-(NSMutableArray*) initTUser:(NSDictionary *)jsonDic
{
    NSMutableArray * userList = [[NSMutableArray alloc] init];
    if (jsonDic != nil) {
        if (jsonDic != nil) {
            TUser *ap;
            for (NSDictionary* dictionary in jsonDic) {
                ap = [[[TUser alloc] init] autorelease];
                if(![[dictionary objectForKey:@"typeId"] isEqual:[NSNull null]]){
                    ap.userId = [[dictionary objectForKey:@"userId"] integerValue];
                }
                else{
                    ap.userId = 0;
                }
                if(![[dictionary objectForKey:@"departmentId"] isEqual:[NSNull null]]){
                    ap.departmentId = [[dictionary objectForKey:@"departmentId"] integerValue];
                }
                else{
                    ap.departmentId = 0;
                }
                if(![[dictionary objectForKey:@"LogonTimes"] isEqual:[NSNull null]]){
                    ap.LogonTimes = [[dictionary objectForKey:@"LogonTimes"] integerValue];
                }
                else{
                    ap.LogonTimes = 0;
                }
                if(![[dictionary objectForKey:@"enable"] isEqual:[NSNull null]]){
                    ap.enable = [[dictionary objectForKey:@"enable"] integerValue];
                }
                else{
                    ap.enable = 0;
                }
                ap.userName = [dictionary objectForKey:@"userName"];
                ap.departmentName = [dictionary objectForKey:@"departmentName"];
                ap.lastAccessIp = [dictionary objectForKey:@"lastAccessIp"];
                ap.lastAccessTimeStr = [dictionary objectForKey:@"lastAccessTimeStr"];
                ap.realName = [dictionary objectForKey:@"realName"];
                ap.gendar = [dictionary objectForKey:@"gendar"];
                ap.city = [dictionary objectForKey:@"city"];
                [userList addObject:ap];
            }
        }
    }
    return userList;
}
@end
