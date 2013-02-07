//
//  AssetsProp.m
//  project
//
//  Created by runes on 13-2-6.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "AssetsProp.h"
#import "SBJson.h"

@implementation AssetsProp
@synthesize propId,assetsTypeCode,name,type,innerOder,isShow,isSearch,searchMethod,sortNumb,showStyle,isValueDic,showName,accessLimit,valueTypeDicCode,valueTypeDicName,value;

-(NSMutableArray*) initAssetsPropWithJsonStr:(NSString *)jsonStr
{
    NSMutableArray * assetsPropList = [[[NSMutableArray alloc] init] autorelease];
    if (![jsonStr isEqual:[NSNull null]]) {
        SBJsonParser * jsonParser = [[SBJsonParser alloc] init];
        NSDictionary *jsonDic = [jsonParser objectWithString:jsonStr];
        [jsonParser release];
        if (jsonDic != nil) {
            AssetsProp *ap;
            for(NSDictionary* dictionary in jsonDic) {
                ap = [[[AssetsProp alloc] init] autorelease];
                if(![[dictionary objectForKey:@"id"] isEqual:[NSNull null]]){
                    ap.propId = [[dictionary objectForKey:@"id"] integerValue];
                }
                else{
                    ap.propId = 0;
                }
                ap.assetsTypeCode = [dictionary objectForKey:@"assetsTypeCode"];
                ap.name = [dictionary objectForKey:@"name"];
                ap.type = [dictionary objectForKey:@"type"];
                if(![[dictionary objectForKey:@"innerOder"] isEqual:[NSNull null]]){
                    ap.innerOder = [[dictionary objectForKey:@"innerOder"] integerValue];
                }
                else{
                    ap.innerOder = 0;
                }
                if(![[dictionary objectForKey:@"isShow"] isEqual:[NSNull null]]){
                    ap.isShow = [[dictionary objectForKey:@"isShow"] integerValue];
                }
                else{
                    ap.isShow = 0;
                }
                ap.searchMethod = [dictionary objectForKey:@"searchMethod"];
                if(![[dictionary objectForKey:@"sortNumb"] isEqual:[NSNull null]]){
                    ap.sortNumb = [[dictionary objectForKey:@"sortNumb"] integerValue];
                }
                else{
                    ap.sortNumb = 0;
                }
                ap.showStyle = [dictionary objectForKey:@"showStyle"];
                if(![[dictionary objectForKey:@"isValueDic"] isEqual:[NSNull null]]){
                    ap.isValueDic = [[dictionary objectForKey:@"isValueDic"] integerValue];
                }
                else{
                    ap.isValueDic = 0;
                }
                ap.showName = [dictionary objectForKey:@"showName"];
                if(![[dictionary objectForKey:@"accessLimit"] isEqual:[NSNull null]]){
                    ap.accessLimit = [[dictionary objectForKey:@"accessLimit"] integerValue];
                }
                else{
                    ap.accessLimit = 0;
                }
                ap.valueTypeDicCode = [dictionary objectForKey:@"valueTypeDicCode"];
                ap.valueTypeDicName = [dictionary objectForKey:@"valueTypeDicName"];
                ap.value = [dictionary objectForKey:@"value"];
                [assetsPropList addObject:ap];
            }
        }
    }
    return assetsPropList;
}
@end
