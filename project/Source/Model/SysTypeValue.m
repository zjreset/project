//
//  SysTypeValue.m
//  project
//
//  Created by runes on 13-2-17.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "SysTypeValue.h"

@implementation SysTypeValue
@synthesize sId,name,typeId,nameEn,nameNls,sortNum,isUsed,parentId;

-(NSMutableArray*) initSysTypeValue:(NSDictionary *)jsonDic
{
    NSMutableArray * sysTypeValueList = [[NSMutableArray alloc] init];
    if (jsonDic != nil) {
        if (jsonDic != nil) {
            SysTypeValue *ap;
            for (NSDictionary* dictionary in jsonDic) {
                ap = [[[SysTypeValue alloc] init] autorelease];
                ap.sId = [dictionary objectForKey:@"id"];
                if(![[dictionary objectForKey:@"typeId"] isEqual:[NSNull null]]){
                    ap.typeId = [[dictionary objectForKey:@"typeId"] integerValue];
                }
                else{
                    ap.typeId = 0;
                }
                if(![[dictionary objectForKey:@"sortNum"] isEqual:[NSNull null]]){
                    ap.sortNum = [[dictionary objectForKey:@"sortNum"] integerValue];
                }
                else{
                    ap.sortNum = 0;
                }
                if(![[dictionary objectForKey:@"isUsed"] isEqual:[NSNull null]]){
                    ap.isUsed = [[dictionary objectForKey:@"isUsed"] integerValue];
                }
                else{
                    ap.isUsed = 0;
                }
                ap.nameEn = [dictionary objectForKey:@"nameEn"];
                ap.name = [dictionary objectForKey:@"name"];
                ap.nameNls = [dictionary objectForKey:@"nameNls"];
                ap.parentId = [dictionary objectForKey:@"parentId"];
                [sysTypeValueList addObject:ap];
            }
        }
    }
    return sysTypeValueList;
}

@end
