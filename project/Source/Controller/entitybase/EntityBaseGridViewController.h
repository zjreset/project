//
//  EntityBaseGridViewController.h
//  project
//
//  Created by runes on 13-2-1.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Three20UI/Three20UI.h>
#import "EntityBase.h"
typedef enum {
    EntityBaseGridMenuPageNone,
    EntityBaseGridMenuPageAssetsSearch,
    EntityBaseGridMenuPageAssetsSite,
    EntityBaseGridMenuPageAssetsStore,
    EntityBaseGridMenuPageAssetsRoom,
    EntityBaseGridMenuPageAssetsCar,
} EntityBaseGridMenuPage;
@interface EntityBaseGridViewController : TTViewController<TTLauncherViewDelegate,UIAlertViewDelegate,TTURLRequestDelegate>
{
    EntityBaseGridMenuPage        _page;
    TTLauncherView      * _launcherView;
    EntityBase          * _entityBase;
}
@property(nonatomic) EntityBaseGridMenuPage page;
@property (nonatomic, assign) NSMutableArray * assetsTypeTopList;
@end
