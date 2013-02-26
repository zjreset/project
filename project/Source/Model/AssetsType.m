//
//  AssetsType.m
//  project
//
//  Created by runes on 13-2-22.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "AssetsType.h"

@implementation AssetsType
@synthesize typeCode,assetsTypeDicCode,typeId,typeName,factory,model,remark,assetsId,assetsTypeCode,iconCls;
-(NSMutableArray*) initAssetsType:(NSDictionary *)jsonDic
{
    NSMutableArray * assetsTypeList = [[NSMutableArray alloc] init];
    if (jsonDic != nil) {
        AssetsType *att;
        for(NSDictionary* dictionary in jsonDic) {
            att = [[[AssetsType alloc] init] autorelease];
            if(![[dictionary objectForKey:@"typeId"] isEqual:[NSNull null]]){
                att.typeId = [[dictionary objectForKey:@"typeId"] integerValue];
            }
            else{
                att.typeId = 0;
            }
            if(![[dictionary objectForKey:@"assetsId"] isEqual:[NSNull null]]){
                att.assetsId = [[dictionary objectForKey:@"assetsId"] integerValue];
            }
            else{
                att.assetsId = 0;
            }

            att.typeCode = [dictionary objectForKey:@"typeCode"];
            att.typeName = [dictionary objectForKey:@"typeName"];
            att.assetsTypeDicCode = [dictionary objectForKey:@"assetsTypeDicCode"];
            att.assetsTypeCode = [dictionary objectForKey:@"assetsTypeCode"];
            if(![[dictionary objectForKey:@"factory"] isEqual:[NSNull null]]){
                att.factory = [dictionary objectForKey:@"factory"];
            }
            if(![[dictionary objectForKey:@"model"] isEqual:[NSNull null]]){
                att.model = [dictionary objectForKey:@"model"];
            }
            att.remark = [dictionary objectForKey:@"remark"];
            if(![[dictionary objectForKey:@"iconCls"] isEqual:[NSNull null]]){
                att.iconCls = [NSString stringWithFormat:@"bundle://%@.png",[dictionary objectForKey:@"iconCls"]];
            }
            [assetsTypeList addObject:att];
        }
    }
    return assetsTypeList;
}

@end
