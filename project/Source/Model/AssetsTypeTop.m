//
//  AssetsTypeTop.m
//  project
//
//  Created by runes on 13-2-1.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "AssetsTypeTop.h"

@implementation AssetsTypeTop
@synthesize assetsTypeTopId,assetsTypeCode,assetsTypeName,remark,count,URL,icon,icon170,icon95;

-(NSMutableArray*) initAssetsTypeTop:(NSDictionary *)jsonDic
{
    NSMutableArray * assetsTypeTopList = [[NSMutableArray alloc] init];
    if (jsonDic != nil) {
        AssetsTypeTop *att;
        for(NSDictionary* dictionary in jsonDic) {
            att = [[[AssetsTypeTop alloc] init] autorelease];
            if(![[dictionary objectForKey:@"id"] isEqual:[NSNull null]]){
                att.assetsTypeTopId = [[dictionary objectForKey:@"id"] integerValue];
            }
            else{
                att.assetsTypeTopId = 0;
            }
            att.assetsTypeName = [dictionary objectForKey:@"assetsTypeName"];
            att.assetsTypeCode = [dictionary objectForKey:@"assetsTypeCode"];
            att.remark = [dictionary objectForKey:@"remark"];
            att.count = [dictionary objectForKey:@"count"];
            att.icon = [NSString stringWithFormat:@"bundle://%@.png",[dictionary objectForKey:@"iconCls"]];
            att.icon95 = [NSString stringWithFormat:@"bundle://%@-95.png",[dictionary objectForKey:@"iconCls"]];
            att.icon170 = [NSString stringWithFormat:@"bundle://%@-170.png",[dictionary objectForKey:@"iconCls"]];
            att.URL = [NSString stringWithFormat:@"fb://item%@",att.assetsTypeCode];
            [assetsTypeTopList addObject:att];
        }
    }
    return assetsTypeTopList;
}
@end
