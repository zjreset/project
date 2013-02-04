//
//  AssetsRecord.m
//  project
//
//  Created by runes on 13-1-21.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "AssetsRecord.h"

@implementation AssetsRecord
@synthesize assetsId,assetsCode,assetsOwners,assetsTypeCode,baseId,barcode,baseCode,changeType,
    factory,isChange,model,lat,lng,name,noteTimeStr,noteUser,pinyin,position,positionName,
remark,resp,status,startTimeStr,typeCode,typeName,useStatus,valid;

-(NSMutableArray*) initAssetsRecord:(NSDictionary *)jsonDic
{
    NSMutableArray * assetsRecordList = [[[NSMutableArray alloc] init] autorelease];
    if (jsonDic != nil) {
        AssetsRecord * ar;
        for (NSDictionary* dictionary in jsonDic) {
            ar = [[[AssetsRecord alloc] init] autorelease];
            if(![[dictionary objectForKey:@"assetsId"] isEqual:[NSNull null]]){
                ar.assetsId = [[dictionary objectForKey:@"assetsId"] integerValue];
            }
            else{
                ar.assetsId = 0;
            }
            if (![[dictionary objectForKey:@"baseId"] isEqual:[NSNull null]]) {
                ar.baseId = [[dictionary objectForKey:@"baseId"] integerValue];
            }
            else{
                ar.baseId = 0;
            }
            ar.baseCode = [dictionary objectForKey:@"baseCode"];
            ar.typeCode = [dictionary objectForKey:@"typeCode"];
            ar.barcode = [dictionary objectForKey:@"barcode"];
            ar.assetsCode = [dictionary objectForKey:@"assetsCode"];
            if (![[dictionary objectForKey:@"name"] isEqual:[NSNull null]]) {
                ar.name = [dictionary objectForKey:@"name"];
            }
            else{
                ar.name = @"没有名称";
            }
            ar.pinyin = [dictionary objectForKey:@"pinyin"];
            ar.position = [dictionary objectForKey:@"position"];
            ar.assetsOwners = [dictionary objectForKey:@"assetsOwners"];
            ar.status = [dictionary objectForKey:@"status"];
            if (![[dictionary objectForKey:@"useStatus"] isEqual:[NSNull null]]) {
                ar.useStatus = [[dictionary objectForKey:@"useStatus"] integerValue];
            }
            else{
                ar.useStatus = 0;
            }
            ar.startTimeStr = [dictionary objectForKey:@"startTimeStr"];
            if (![[dictionary objectForKey:@"valid"] isEqual:[NSNull null]]) {
                ar.valid = [[dictionary objectForKey:@"valid"] doubleValue];
            }
            else{
                ar.valid = 0;
            }
            if(![[dictionary objectForKey:@"isChange"] isEqual:[NSNull null]]){
                ar.isChange = [[dictionary objectForKey:@"isChange"] integerValue];
            }
            else{
                ar.isChange = 0;
            }
            ar.changeType = [dictionary objectForKey:@"changeType"];
            if (![[dictionary objectForKey:@"lng"] isEqual:[NSNull null]]) {
                ar.lng = [[dictionary objectForKey:@"lng"] doubleValue];
            }
            else{
                ar.lng = 0;
            }
            if (![[dictionary objectForKey:@"lat"] isEqual:[NSNull null]]) {
                ar.lat = [[dictionary objectForKey:@"lat"] doubleValue];
            }
            else{
                ar.lat = 0;
            }
            ar.resp = [dictionary objectForKey:@"resp"];
            ar.remark = [dictionary objectForKey:@"remark"];
            ar.typeName = [dictionary objectForKey:@"typeName"];
            ar.factory = [dictionary objectForKey:@"factory"];
            ar.model = [dictionary objectForKey:@"model"];
            ar.assetsTypeCode = [dictionary objectForKey:@"assetsTypeCode"];
            ar.positionName = [dictionary objectForKey:@"positionName"];
            ar.noteTimeStr = [dictionary objectForKey:@"noteTimeStr"];
            ar.noteUser = [dictionary objectForKey:@"noteUser"];
            if (![ar.typeCode isEqual:[NSNull null]]) {
                if ([ar.typeCode isEqualToString:@"10001"]) {
                    ar.photoPath = @"bundle://Placeholder.png";
                }
                else{
                    ar.photoPath = @"bundle://Placeholder.png";
                }
            }
            else{
                ar.photoPath = @"bundle://Placeholder.png";
            }
            [assetsRecordList addObject:ar];
        }
    }
    return assetsRecordList;
}

@end
