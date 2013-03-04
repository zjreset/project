//
//  AssetsRecordTableViewController.m
//  project
//
//  Created by runes on 13-2-2.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "AssetsRecordTableViewController.h"
#import "AssetsSearchDataSource.h"

@interface AssetsRecordTableViewController ()

@end

@implementation AssetsRecordTableViewController

- (id)initWithURLQuery:(MenuPage)page query:(NSDictionary *)query{
    self = [super init];
    if (self) {
        _entityBase = [query objectForKey:@"entityBase"];
        _assetsTypeTop = [query objectForKey:@"assetsTypeTop"];
        _page = page;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 加载视图时的响应
 */
- (void)loadView {
    [super loadView];
    
    NSString *title = @"新增资产";
    switch (_page) {
        case MenuPageAssetsSearch:
            
            break;
        case MenuPageAssetsStore:
            title = @"资产入库";
            break;
        case MenuPageAssetsSite:
            
            break;
        case MenuPageAssetsRoom:
            
            break;
        case MenuPageAssetsCar:
            
            break;
        default:
            break;
    }
    self.navigationItem.rightBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(selectButtonItem)] autorelease];
}

- (void) selectButtonItem
{
    TTURLAction *action =  [[TTURLAction actionWithURLPath:[NSString stringWithFormat:@"tt://assetsRecordPage?page=%i&baseId=%i&bastType=%@",_page,_entityBase.baseId,_entityBase.baseType]] applyAnimated:YES];
    [[TTNavigator navigator] openURLAction:action];
}

/**
 * 创建模型
 */
-(void)createModel
{
    self.dataSource = [[[AssetsSearchDataSource alloc] initWithURLQuery:[NSString stringWithFormat:@"{baseId:%i,assetsTypeCode='%@'}",_entityBase.baseId,_assetsTypeTop.assetsTypeCode]] autorelease];
}

//对tableView下拉刷新的操作
- (id)createDelegate
{
    TTTableViewDragRefreshDelegate *delegate = [[TTTableViewDragRefreshDelegate alloc] initWithController:self];
    return [delegate autorelease];
}

/**
 * 点击列表项时的响应
 */
- (void) didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    if ([object userInfo]) {
        TTURLAction *action =  [[[TTURLAction actionWithURLPath:@"tt://assetsRecordQuery"]
                                 applyQuery:[NSDictionary dictionaryWithObject:[object userInfo] forKey:@"assetsRecord"]]
                                applyAnimated:YES];
        [[TTNavigator navigator] openURLAction:action];
    }
}

/**
 * 点击查询结果框cell的响应
 */
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TTTableViewCell *cell = (TTTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    TTTableItem *object = [cell object];
    [self didSelectObject:object atIndexPath:indexPath];
}

@end
