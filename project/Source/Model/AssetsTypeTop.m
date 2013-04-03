//
//  AssetsTypeTop.m
//  project
//
//  Created by runes on 13-2-1.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "AssetsTypeTop.h"

@implementation AssetsTypeTop
@synthesize assetsTypeTopId,assetsTypeCode,assetsTypeName,remark,count,URL,icon;

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
            att.icon2x = [NSString stringWithFormat:@"bundle://%@@2x.png",[dictionary objectForKey:@"iconCls"]];
            att.URL = [NSString stringWithFormat:@"fb://item%@",att.assetsTypeCode];
            [assetsTypeTopList addObject:att];
        }
    }
    return assetsTypeTopList;
}
@end
