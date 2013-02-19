//
//  AssetsSearchDataSource.m
//  project
//
//  Created by runes on 13-1-21.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "EntityBaseSearchDataSource.h"
#import "AppDelegate.h"
#import "EntityBase.h"
#import "SBJson.h"

@implementation EntityBaseSearchDataSource

-(id)initWithURLQuery:(NSString*)query{
    if(self=[super init]){
        _entityBase_model=[[EntityBaseModel alloc] initWithURLQuery:query];
    }
    return self;
}

- (void)dealloc {
    //TT_RELEASE_SAFELY(_assetsRecord_model);
    [super dealloc];
}

- (id<TTModel>)model {
    return _entityBase_model;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
    [super tableViewDidLoadModel:tableView];
    NSMutableArray* items = [[[NSMutableArray alloc] init]autorelease];
    int count = _entityBase_model.entityBaseSearchList.count;
    UIImage* defaultPerson = TTIMAGE(@"bundle://defaultPerson.png");
    if (count) {
        for (int i = 0; i < count; i++)
        {
            EntityBase * entityBase = [_entityBase_model.entityBaseSearchList objectAtIndex:i];
            //TTTableImageItem *item = [TTTableImageItem itemWithText: assetsRecord.name imageURL:assetsRecord.photoPath];
            TTTableSubtitleItem *item = [TTTableSubtitleItem itemWithText:entityBase.baseName
                                                                 subtitle:entityBase.statusName
                                                                 imageURL:nil
                                                                 defaultImage:defaultPerson
                                                                 URL:nil accessoryURL:nil];
            
            item.userInfo = entityBase;
            [items addObject: item];
            //TT_RELEASE_SAFELY(item);
        }
        //判断是否有页长倍数的余数,如果有则加载TableMoreButton;
        if(!([items count]%10) && [items count]){
            [items addObject:[TTTableMoreButton itemWithText:@"加载更多..."]];
        }
    }
    else{
        TTTableImageItem *item = [TTTableImageItem itemWithText: @"没有查询到该记录" imageURL:nil];
        item.userInfo = nil;
        [items addObject: item];
        //TT_RELEASE_SAFELY(item);
    }
    self.items = items;
    //TT_RELEASE_SAFELY(items);
}

- (void)tableView:(UITableView*)tableView cell:(UITableViewCell*)cell willAppearAtIndexPath:(NSIndexPath*)indexPath {
    [super tableView:tableView cell:cell willAppearAtIndexPath:indexPath];
    //判断页面是否上拉到TableMoreButton处,如果出现,则加载更多页
    if (indexPath.row == self.items.count-1 && self.items.count-1 && [cell isKindOfClass:[TTTableMoreButtonCell class]]) {
        TTTableMoreButton* moreLink = [(TTTableMoreButtonCell *)cell object];
        moreLink.isLoading = YES;
        [(TTTableMoreButtonCell *)cell setAnimating:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        _entityBase_model.pageSize = _entityBase_model.pageSize + 10;
        [self.model load:TTURLRequestCachePolicyDefault more:YES];
    }
}

//外部响应入口
- (void)search:(NSString*)text {
    _entityBase_model.searchQuery = text;
    _entityBase_model.pageSize = 10;
    [self.model load:TTURLRequestCachePolicyDefault more:YES];
}

#pragma mark - Table view data source
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //tableView.rowHeight = 66;
    return [super tableView:tableView numberOfRowsInSection:section];
}
@end
