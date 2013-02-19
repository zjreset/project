//
//  AppDelegate.m
//  project
//
//  Created by runes on 12-12-11.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import "AppDelegate.h"
#import "SysTypeValue.h"
#import "TUser.h"
#import "LoginViewController.h"
#import "Reachability.h"
#import "TabBarController.h"
#import "MenuController.h"
#import "MainViewController.h"
#import "AssetsRecordViewController.h"
#import "EntityBaseMenuController.h"
#import "EntityBaseTabBarController.h"
#import "EntityBaseGridViewController.h"
#import "AssetsRecordTableViewController.h"

@implementation AppDelegate
@synthesize SERVER_HOST,JSESSIONID,sysTypeValueList = _sysTypeValueList,userList = _userList;

- (void)dealloc
{
    [_window release];
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
    TT_RELEASE_SAFELY(SERVER_HOST);
    TT_RELEASE_SAFELY(JSESSIONID);
    TT_RELEASE_SAFELY(_sysTypeValueList);
    [super dealloc];
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //全局变量远端服务器URL地址
    SERVER_HOST = @"http://192.168.0.49:8088/runes_dw";
    
    //网络检测,
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    hostReach = [[Reachability reachabilityWithHostName:@"www.apple.com"] retain];
    [hostReach startNotifier];
    
    //开始设置首页跳转页面
    TTNavigator* navigator = [TTNavigator navigator];
    navigator.persistenceMode = TTNavigatorPersistenceModeAll;
    self.window = [[[UIWindow alloc] initWithFrame:TTScreenBounds()] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    navigator.window = self.window;
    
    TTURLMap* map = navigator.URLMap;
    
    //页面URL集,默认URL
    [map from:@"*" toViewController:[TTWebController class]];
    //用户登陆页面
    [map from:@"tt://login" toSharedViewController:[LoginViewController class]];
    //主页
    [map from:@"tt://main" toSharedViewController:[MainViewController class]];
    //主TAB页
    [map from:@"tt://tabBar" toSharedViewController:[TabBarController class]];
    //菜单页
    [map from:@"tt://menu/(initWithMenu:)" toSharedViewController:[MenuController class]];
    //资产查询详情
    [map from:@"tt://assetsRecordTableViewQuery/(initWithURLQuery:)" toViewController:[AssetsRecordTableViewController class]];
    //主TAB页
    [map from:@"tt://entityTabBar" toSharedViewController:[EntityBaseTabBarController class]];
    //菜单页
    [map from:@"tt://entityMenu/(initWithMenu:)" toSharedViewController:[EntityBaseMenuController class]];
    //站址详情
    [map from:@"tt://entityBaseGridQuery?url=(initWithURL:)" toViewController:[EntityBaseGridViewController class]];
    //菜单页
    [map from:@"tt://assetsRecordQuery?url=(initWithNavigatorURL:)" toModalViewController:[AssetsRecordViewController class]];
    //菜单页
    [map from:@"tt://assetsRecordPage/(initWithPageTag:)" toModalViewController:[AssetsRecordViewController class]];
    
    // Before opening the tab bar, we see if the controller history was persisted the last time
    if (![navigator restoreViewControllers]) {
        //进入默认登陆页面
        [navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://login"]];
    }
    [self.window setRootViewController:navigator.rootViewController];
    return YES;
}

- (void)reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    UIAlertView *alert;
    switch (status) {
        case NotReachable:
            alert = [[UIAlertView alloc] initWithTitle:@""
                                               message:@"无法连接到网络,请检查网络设置"
                                              delegate:nil
                                     cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alert release];
            break;
        case ReachableViaWWAN:
            alert = [[UIAlertView alloc] initWithTitle:@""
                                               message:@"检测到您没有使用WIFI网络"
                                              delegate:nil
                                     cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alert release];
            break;
        case ReachableViaWiFi:  //使用WIFI网络
            break;
    }
}

- (void)setSysTypeValues
{
    NSString *server_base = [NSString stringWithFormat:@"%@/admin/systypevalue!findTypeValueAll.action", SERVER_HOST];
    TTURLRequest* request = [TTURLRequest requestWithURL: server_base delegate: self];
    [request setHttpMethod:@"POST"];
    
    request.contentType=@"application/x-www-form-urlencoded";
    NSString* postBodyString = [NSString stringWithFormat:@"isMobile=true"];
    request.cachePolicy = TTURLRequestCachePolicyNoCache;
    NSData* postData = [NSData dataWithBytes:[postBodyString UTF8String] length:[postBodyString length]];
    
    [request setHttpBody:postData];
    request.userInfo = @"SysTypeValue";
    [request send];
    
    request.response = [[[TTURLDataResponse alloc] init] autorelease];
}

- (void)setTUser
{
    NSString *server_base = [NSString stringWithFormat:@"%@/userInfo/tuser!findUserAll.action", SERVER_HOST];
    TTURLRequest* request = [TTURLRequest requestWithURL: server_base delegate: self];
    [request setHttpMethod:@"POST"];
    
    request.contentType=@"application/x-www-form-urlencoded";
    NSString* postBodyString = [NSString stringWithFormat:@"isMobile=true"];
    request.cachePolicy = TTURLRequestCachePolicyNoCache;
    NSData* postData = [NSData dataWithBytes:[postBodyString UTF8String] length:[postBodyString length]];
    
    [request setHttpBody:postData];
    request.userInfo = @"TUser";
    [request send];
    
    request.response = [[[TTURLDataResponse alloc] init] autorelease];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidStartLoad:(TTURLRequest*)request {
    //加入请求开始的一些进度条
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
    TTURLDataResponse* dataResponse = (TTURLDataResponse*)request.response;
    NSString *json = [[NSString alloc] initWithData:dataResponse.data encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",json);
    SBJsonParser * jsonParser = [[SBJsonParser alloc] init];
    NSDictionary *jsonDic = [jsonParser objectWithString:json];
    [jsonParser release];
	[json release];
	request.response = nil;
    bool success = [[jsonDic objectForKey:@"success"] boolValue];
    if (!success) {
        //创建对话框 提示用户获取请求数据失败
        UIAlertView * alert= [[UIAlertView alloc] initWithTitle:[jsonDic objectForKey:@"msg"] message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else{
        static NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch | NSNumericSearch | NSWidthInsensitiveSearch | NSForcedOrderingSearch;
        if (request.userInfo != nil && [request.userInfo compare:@"SysTypeValue" options:comparisonOptions] == NSOrderedSame) {
            SysTypeValue *sysTypeValue = [[SysTypeValue alloc] init];
            _sysTypeValueList = [sysTypeValue initSysTypeValue:[jsonDic objectForKey:@"sysTypeValueList"]];
            TT_RELEASE_SAFELY(sysTypeValue);
        }
        else if (request.userInfo != nil && [request.userInfo compare:@"TUser" options:comparisonOptions] == NSOrderedSame) {
            TUser *tUser = [[TUser alloc] init];
            _userList = [tUser initTUser:[jsonDic objectForKey:@"userList"]];
            TT_RELEASE_SAFELY(tUser);
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
    //[loginButton setTitle:@"Failed to load, try again." forState:UIControlStateNormal];
    UIAlertView * alert= [[UIAlertView alloc] initWithTitle:@"获取http请求失败!" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //将这个UIAlerView 显示出来
    [alert show];
    //释放
    [alert release];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"project" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"project.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
