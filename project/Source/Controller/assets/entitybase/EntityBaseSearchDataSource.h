//
//  AssetsSearchDataSource.h
//  project
//
//  Created by runes on 13-1-21.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Three20UI/Three20UI.h>
#import "EntityBaseModel.h"
@class EntityBaseModel;

@interface EntityBaseSearchDataSource : TTListDataSource
{
    //用于监听下拉列表读取与刷新
    EntityBaseModel* _entityBase_model;
}
-(id)initWithURLQuery:(NSString*)query;
@end
