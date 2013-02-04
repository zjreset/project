//
//  EntityBase.m
//  project
//
//  Created by runes on 13-1-31.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "EntityBase.h"

@implementation EntityBase
@synthesize baseId,code,baseName,baseType,status,statusName;

-(NSMutableArray*) initEntityBase:(NSDictionary *)jsonDic
{
    NSMutableArray * entityBaseList = [[[NSMutableArray alloc] init] autorelease];
    if (jsonDic != nil) {
        EntityBase *eb;
        for(NSDictionary* dictionary in jsonDic) {
            eb = [[[EntityBase alloc] init] autorelease];
            if(![[dictionary objectForKey:@"id"] isEqual:[NSNull null]]){
                eb.baseId = [[dictionary objectForKey:@"id"] integerValue];
            }
            else{
                eb.baseId = 0;
            }
            eb.baseName = [dictionary objectForKey:@"baseName"];
            eb.baseType = [dictionary objectForKey:@"baseType"];
            eb.code = [dictionary objectForKey:@"code"];
            eb.status = [dictionary objectForKey:@"status"];
            eb.statusName = [dictionary objectForKey:@"statusName"];
            [entityBaseList addObject:eb];
        }
    }
    return entityBaseList;
}

@end
