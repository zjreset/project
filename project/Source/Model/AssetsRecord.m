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
remark,resp,status,startTimeStr,typeCode,typeName,useStatus,valid;

-(NSMutableArray*) initAssetsRecord:(NSDictionary *)jsonDic
{
    NSMutableArray * assetsRecordList = [[NSMutableArray alloc] init];
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
            if ([[dictionary objectForKey:@"baseCode"] isEqual:[NSNull null]]) {
                ar.baseCode = [dictionary objectForKey:@"baseCode"];
            }
            if ([[dictionary objectForKey:@"typeCode"] isEqual:[NSNull null]]) {
                ar.typeCode = [dictionary objectForKey:@"typeCode"];
            }
            if ([[dictionary objectForKey:@"baseCode"] isEqual:[NSNull null]]) {
                ar.barcode = [dictionary objectForKey:@"baseCode"];
            }
            if ([[dictionary objectForKey:@"assetsCode"] isEqual:[NSNull null]]) {
                ar.assetsCode = [dictionary objectForKey:@"assetsCode"];
            }
            if (![[dictionary objectForKey:@"name"] isEqual:[NSNull null]]) {
                ar.name = [dictionary objectForKey:@"name"];
            }
            else{
                ar.name = @"没有名称";
            }
            ar.pinyin = [dictionary objectForKey:@"pinyin"];
            if ([[dictionary objectForKey:@"position"] isEqual:[NSNull null]]) {
                ar.position = [dictionary objectForKey:@"position"];
            }
            if ([[dictionary objectForKey:@"assetsOwners"] isEqual:[NSNull null]]) {
                ar.assetsOwners = [dictionary objectForKey:@"assetsOwners"];
            }
            if ([[dictionary objectForKey:@"status"] isEqual:[NSNull null]]) {
                ar.status = [dictionary objectForKey:@"status"];
            }
            if (![[dictionary objectForKey:@"useStatus"] isEqual:[NSNull null]]) {
                ar.useStatus = [[dictionary objectForKey:@"useStatus"] integerValue];
            }
            else{
                ar.useStatus = 0;
            }
            if ([[dictionary objectForKey:@"startTimeStr"] isEqual:[NSNull null]]) {
                ar.startTimeStr = [dictionary objectForKey:@"startTimeStr"];
            }
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
            if (![[dictionary objectForKey:@"changeType"] isEqual:[NSNull null]]) {
                ar.changeType = [dictionary objectForKey:@"changeType"];
            }
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

- (NSString*)getAssetsTypeTopPhotoPath:(AssetsRecord*)ar
{
    NSString *photoPath = @"bundle://Placeholder.png";
    if (![ar.assetsTypeCode isEqual:[NSNull null]]) {
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        for (AssetsTypeTop *assetsTypeTop in delegate.assetsTypeTopList)
        {
            if ([assetsTypeTop.assetsTypeCode compare:ar.assetsTypeCode] == NSOrderedSame) {
                photoPath = assetsTypeTop.icon;
                return photoPath;
            }
        }
        
    }
    return photoPath;
}

@end
