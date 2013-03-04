//
//  AssetsRecordTableViewController.h
//  project
//
//  Created by runes on 13-2-2.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Three20UI/Three20UI.h>
#import "CommonEnum.h"
#import "EntityBase.h"
#import "AssetsTypeTop.h"

@interface AssetsRecordTableViewController : TTTableViewController
{
    
    MenuPage            _page;
    EntityBase          *_entityBase;
    AssetsTypeTop       *_assetsTypeTop;
}

@end
