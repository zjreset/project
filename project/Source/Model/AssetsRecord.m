//
//  AssetsRecord.m
//  project
//
//  Created by runes on 13-1-21.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "AssetsRecord.h"
#import "AssetsProp.h"
#import "AppDelegate.h"
#import "AssetsTypeTop.h"

@implementation AssetsRecord
@synthesize assetsId,assetsCode,assetsOwners,assetsTypeCode,baseId,barcode,baseCode,changeType,assetsPropList,
    factory,isChange,model,lat,lng,name,noteTimeStr,noteUser,pinyin,position,positionName,
remark,resp,status,startTimeStr,typeCode,typeName,useStatus,valid,assetsTypeName,photoPath;

-(NSMutableArray*) initAssetsRecord:(NSDictionary *)jsonDic
{
    NSMutableArray * assetsRecordList = [[NSMutableArray alloc] init];
    if (jsonDic != nil) {
        AssetsRecord * ar;
        for (NSDictionary* dictionary in jsonDic) {
            ar = [[[AssetsRecord alloc] init] autorelease];
            if (![[dictionary objectForKey:@"assetsId"] isEqual:[NSNull null]]){
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
            if (![[dictionary objectForKey:@"baseCode"] isEqual:[NSNull null]]) {
                ar.baseCode = [dictionary objectForKey:@"baseCode"];
            }
            if (![[dictionary objectForKey:@"typeCode"] isEqual:[NSNull null]]) {
                ar.typeCode = [dictionary objectForKey:@"typeCode"];
            }
            if (![[dictionary objectForKey:@"barcode"] isEqual:[NSNull null]]) {
                ar.barcode = [dictionary objectForKey:@"barcode"];
            }
            if (![[dictionary objectForKey:@"assetsCode"] isEqual:[NSNull null]]) {
                ar.assetsCode = [dictionary objectForKey:@"assetsCode"];
            }
            if (![[dictionary objectForKey:@"name"] isEqual:[NSNull null]]) {
                ar.name = [dictionary objectForKey:@"name"];
            }
            else{
                ar.name = @"没有名称";
            }
            ar.pinyin = [dictionary objectForKey:@"pinyin"];
            if (![[dictionary objectForKey:@"position"] isEqual:[NSNull null]]) {
                ar.position = [dictionary objectForKey:@"position"];
            }
            if (![[dictionary objectForKey:@"assetsOwners"] isEqual:[NSNull null]]) {
                ar.assetsOwners = [dictionary objectForKey:@"assetsOwners"];
            }
            if (![[dictionary objectForKey:@"status"] isEqual:[NSNull null]]) {
                ar.status = [dictionary objectForKey:@"status"];
            }
            if (![[dictionary objectForKey:@"useStatus"] isEqual:[NSNull null]]) {
                ar.useStatus = [[dictionary objectForKey:@"useStatus"] integerValue];
            }
            else{
                ar.useStatus = 0;
            }
            if (![[dictionary objectForKey:@"startTimeStr"] isEqual:[NSNull null]]) {
                ar.startTimeStr = [dictionary objectForKey:@"startTimeStr"];
            }
            else {
                ar.startTimeStr = @"";
            }
            if (![[dictionary objectForKey:@"valid"] isEqual:[NSNull null]]) {
                ar.valid = [dictionary objectForKey:@"valid"];
            }
            if (![[dictionary objectForKey:@"isChange"] isEqual:[NSNull null]]){
                ar.isChange = [[dictionary objectForKey:@"isChange"] integerValue];
            }
            else{
                ar.isChange = 0;
            }
            if (![[dictionary objectForKey:@"changeType"] isEqual:[NSNull null]]) {
                ar.changeType = [dictionary objectForKey:@"changeType"];
            }
            if (![[dictionary objectForKey:@"lng"] isEqual:[NSNull null]]) {
                ar.lng = [dictionary objectForKey:@"lng"];
            }
            if (![[dictionary objectForKey:@"lat"] isEqual:[NSNull null]]) {
                ar.lat = [dictionary objectForKey:@"lat"];
            }
            if (![[dictionary objectForKey:@"resp"] isEqual:[NSNull null]]) {
                ar.resp = [dictionary objectForKey:@"resp"];
            }
            if (![[dictionary objectForKey:@"remark"] isEqual:[NSNull null]]) {
                ar.remark = [dictionary objectForKey:@"remark"];
            }
            if (![[dictionary objectForKey:@"typeName"] isEqual:[NSNull null]]) {
                ar.typeName = [dictionary objectForKey:@"typeName"];
            }
            if (![[dictionary objectForKey:@"factory"] isEqual:[NSNull null]]) {
                ar.factory = [dictionary objectForKey:@"factory"];
            }
            if (![[dictionary objectForKey:@"model"] isEqual:[NSNull null]]) {
                ar.model = [dictionary objectForKey:@"model"];
            }
            if (![[dictionary objectForKey:@"assetsTypeCode"] isEqual:[NSNull null]]) {
                ar.assetsTypeCode = [dictionary objectForKey:@"assetsTypeCode"];
            }
            if (![[dictionary objectForKey:@"assetsTypeName"] isEqual:[NSNull null]]) {
                ar.assetsTypeName = [dictionary objectForKey:@"assetsTypeName"];
            }
            if (![[dictionary objectForKey:@"positionName"] isEqual:[NSNull null]]) {
                ar.positionName = [dictionary objectForKey:@"positionName"];
            }
            if (![[dictionary objectForKey:@"noteTimeStr"] isEqual:[NSNull null]]) {
                ar.noteTimeStr = [dictionary objectForKey:@"noteTimeStr"];
            }
            if (![[dictionary objectForKey:@"noteUser"] isEqual:[NSNull null]]) {
                ar.noteUser = [dictionary objectForKey:@"noteUser"];
            }
            ar.photoPath = [self getAssetsTypeTopPhotoPath:ar];
            ar.assetsPropList = [[AssetsProp alloc] initAssetsPropWithJsonStr:[dictionary objectForKey:@"assetsPropStr"]];
            [assetsRecordList addObject:ar];
        }
    }
    return assetsRecordList;
}

-(AssetsRecord*) initAssetsRecordSingle:(NSDictionary *)jsonDic
{
    if (jsonDic != nil) {
        AssetsRecord * ar;
        ar = [[[AssetsRecord alloc] init] autorelease];
        if (![[jsonDic objectForKey:@"assetsId"] isEqual:[NSNull null]]){
            ar.assetsId = [[jsonDic objectForKey:@"assetsId"] integerValue];
        }
        else{
            ar.assetsId = 0;
        }
        if (![[jsonDic objectForKey:@"baseId"] isEqual:[NSNull null]]) {
            ar.baseId = [[jsonDic objectForKey:@"baseId"] integerValue];
        }
        else{
            ar.baseId = 0;
        }
        if (![[jsonDic objectForKey:@"baseCode"] isEqual:[NSNull null]]) {
            ar.baseCode = [jsonDic objectForKey:@"baseCode"];
        }
        if (![[jsonDic objectForKey:@"typeCode"] isEqual:[NSNull null]]) {
            ar.typeCode = [jsonDic objectForKey:@"typeCode"];
        }
        if (![[jsonDic objectForKey:@"barcode"] isEqual:[NSNull null]]) {
            ar.barcode = [jsonDic objectForKey:@"barcode"];
        }
        if (![[jsonDic objectForKey:@"assetsCode"] isEqual:[NSNull null]]) {
            ar.assetsCode = [jsonDic objectForKey:@"assetsCode"];
        }
        if (![[jsonDic objectForKey:@"name"] isEqual:[NSNull null]]) {
            ar.name = [jsonDic objectForKey:@"name"];
        }
        else{
            ar.name = @"没有名称";
        }
        ar.pinyin = [jsonDic objectForKey:@"pinyin"];
        if (![[jsonDic objectForKey:@"position"] isEqual:[NSNull null]]) {
            ar.position = [jsonDic objectForKey:@"position"];
        }
        if (![[jsonDic objectForKey:@"assetsOwners"] isEqual:[NSNull null]]) {
            ar.assetsOwners = [jsonDic objectForKey:@"assetsOwners"];
        }
        if (![[jsonDic objectForKey:@"status"] isEqual:[NSNull null]]) {
            ar.status = [jsonDic objectForKey:@"status"];
        }
        if (![[jsonDic objectForKey:@"useStatus"] isEqual:[NSNull null]]) {
            ar.useStatus = [[jsonDic objectForKey:@"useStatus"] integerValue];
        }
        else{
            ar.useStatus = 0;
        }
        if (![[jsonDic objectForKey:@"startTimeStr"] isEqual:[NSNull null]]) {
            ar.startTimeStr = [jsonDic objectForKey:@"startTimeStr"];
        }
        else {
            ar.startTimeStr = @"";
        }
        if (![[jsonDic objectForKey:@"valid"] isEqual:[NSNull null]]) {
            ar.valid = [jsonDic objectForKey:@"valid"];
        }
        if (![[jsonDic objectForKey:@"isChange"] isEqual:[NSNull null]]){
            ar.isChange = [[jsonDic objectForKey:@"isChange"] integerValue];
        }
        else{
            ar.isChange = 0;
        }
        if (![[jsonDic objectForKey:@"changeType"] isEqual:[NSNull null]]) {
            ar.changeType = [jsonDic objectForKey:@"changeType"];
        }
        if (![[jsonDic objectForKey:@"lng"] isEqual:[NSNull null]]) {
            ar.lng = [jsonDic objectForKey:@"lng"];
        }
        if (![[jsonDic objectForKey:@"lat"] isEqual:[NSNull null]]) {
            ar.lat = [jsonDic objectForKey:@"lat"];
        }
        if (![[jsonDic objectForKey:@"resp"] isEqual:[NSNull null]]) {
            ar.resp = [jsonDic objectForKey:@"resp"];
        }
        if (![[jsonDic objectForKey:@"remark"] isEqual:[NSNull null]]) {
            ar.remark = [jsonDic objectForKey:@"remark"];
        }
        if (![[jsonDic objectForKey:@"typeName"] isEqual:[NSNull null]]) {
            ar.typeName = [jsonDic objectForKey:@"typeName"];
        }
        if (![[jsonDic objectForKey:@"factory"] isEqual:[NSNull null]]) {
            ar.factory = [jsonDic objectForKey:@"factory"];
        }
        if (![[jsonDic objectForKey:@"model"] isEqual:[NSNull null]]) {
            ar.model = [jsonDic objectForKey:@"model"];
        }
        if (![[jsonDic objectForKey:@"assetsTypeCode"] isEqual:[NSNull null]]) {
            ar.assetsTypeCode = [jsonDic objectForKey:@"assetsTypeCode"];
        }
        if (![[jsonDic objectForKey:@"assetsTypeName"] isEqual:[NSNull null]]) {
            ar.assetsTypeName = [jsonDic objectForKey:@"assetsTypeName"];
        }
        if (![[jsonDic objectForKey:@"positionName"] isEqual:[NSNull null]]) {
            ar.positionName = [jsonDic objectForKey:@"positionName"];
        }
        if (![[jsonDic objectForKey:@"noteTimeStr"] isEqual:[NSNull null]]) {
            ar.noteTimeStr = [jsonDic objectForKey:@"noteTimeStr"];
        }
        if (![[jsonDic objectForKey:@"noteUser"] isEqual:[NSNull null]]) {
            ar.noteUser = [jsonDic objectForKey:@"noteUser"];
        }
        ar.photoPath = [self getAssetsTypeTopPhotoPath:ar];
        ar.assetsPropList = [[AssetsProp alloc] initAssetsPropWithJsonStr:[jsonDic objectForKey:@"assetsPropStr"]];
        return ar;
    }
    return nil;
}

- (NSString*)getAssetsTypeTopPhotoPath:(AssetsRecord*)ar
{
    NSString *photoPaths = @"bundle://Placeholder.png";
    if (![ar.assetsTypeCode isEqual:[NSNull null]]) {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        for (AssetsTypeTop *assetsTypeTop in delegate.assetsTypeTopList)
        {
            if ([assetsTypeTop.assetsTypeCode compare:ar.assetsTypeCode] == NSOrderedSame) {
                photoPaths = assetsTypeTop.icon;
                return photoPaths;
            }
        }
        
    }
    return photoPaths;
}

@end
