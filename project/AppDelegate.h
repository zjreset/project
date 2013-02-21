//
//  AppDelegate.h
//  project
//
//  Created by runes on 12-12-11.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>

@class Reachability;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    Reachability  *hostReach;   //对手机网络状况的检测
    NSMutableArray *_sysTypeValueList;
    NSMutableArray *_userList;
    NSMutableArray *_assetsTypeTopList;
}
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,retain) NSString *SERVER_HOST;
@property (nonatomic,retain) NSString *JSESSIONID;
@property (nonatomic,retain) NSMutableArray *sysTypeValueList;
@property (nonatomic,retain) NSMutableArray *userList;
@property (nonatomic,retain) NSMutableArray *assetsTypeTopList;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)setSysTypeValues;
- (void)setTUser;
- (void)setAssetsTypeTop;
@end
