//
//  AssetsRecordModel.h
//  project
//
//  Created by runes on 13-1-23.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Three20Network/Three20Network.h>

@interface EntityBaseModel : TTURLRequestModel<UIAlertViewDelegate>
{
    //资产list
    NSMutableArray * _entityBaseSearchList;
    NSString * searchScope;
    NSString * searchValue;
    NSString *_searchQuery;
    NSMutableArray *_posts;
    NSInteger _pageSize;
}

@property (nonatomic, assign) NSMutableArray * entityBaseSearchList;
@property (nonatomic, retain) NSString *searchScope;
@property (nonatomic, retain) NSString *searchValue;
@property (nonatomic, retain) NSString* searchQuery;
@property (nonatomic, retain) NSMutableArray*  posts;
@property (nonatomic) NSInteger pageSize;
- (id)initWithURLQuery:(NSString*)query;
@end
