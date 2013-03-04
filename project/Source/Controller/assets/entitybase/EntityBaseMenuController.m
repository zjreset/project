#import "EntityBaseMenuController.h"
#import "EntityBaseSearchDataSource.h"
#import "EntityBase.h"
#import "CustomDaragRefresh.h"

static NSString * EntityBaseSearchString = @"%@";
static NSString * EntityBaseStoreString = @"&baseType=4%@";
static NSString * EntityBaseSiteString = @"&baseType=1%@";
static NSString * EntityBaseRoomString = @"&baseType=3%@";
static NSString * EntityBaseCarString = @"&baseType=2%@";

@implementation EntityBaseMenuController
@synthesize page = _page,savedSearchTerm;
///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (NSString*)nameForMenuPage:(MenuPage)page {
  switch (page) {
    case MenuPageAssetsSite:
      return @"基站";
    case MenuPageAssetsStore:
      return @"库房";
    case MenuPageAssetsRoom:
      return @"中心机房";
    case MenuPageAssetsCar:
      return @"移动基站";
    default:
      return @"";
  }
}

- (NSString*)imageForMenuPage:(MenuPage)page {
    switch (page) {
        case MenuPageAssetsSearch:
            return @"icon_glass.png";
        case MenuPageAssetsStore:
            return @"icon_home.png";
        case MenuPageAssetsSite:
            return @"icon_copy.png";
        case MenuPageAssetsRoom:
            return @"icon_star.png";
        case MenuPageAssetsCar:
            return @"icon_time.png";
        default:
            return @"";
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithMenu:(MenuPage)page {
    if (self = [super init]) {
        self.page = page;
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        _page = MenuPageNone;
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

/**
 * 加载视图时的响应
 */
- (void)loadView {
    [super loadView];
    //设置查询框及临时查询列表
    self.searchViewController = self;
    
    _searchController.pausesBeforeSearching = YES;
    _searchController.searchBar.placeholder = [NSString stringWithFormat:@"输入%@名称查询" ,[self nameForMenuPage:_page]];
    //self.searchDisplayController.searchBar.showsSearchResultsButton = YES;
    
    //设置scopeBar
    //_searchController.searchBar.showsScopeBar = YES;
    //_searchController.searchBar.scopeButtonTitles = [[NSArray alloc] initWithObjects:@"资产编码", @"资产条码", @"资产名称", @"资产类型", nil];
    _searchController.searchResultsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth  | UIViewAutoresizingFlexibleHeight;
    _searchController.searchResultsTableView.delegate = self;
    //_searchController.searchResultsViewController.variableHeightRows = NO;
    self.tableView.tableHeaderView = _searchController.searchBar;
    
    //设置代理
    _searchController.searchBar.delegate = self;
    _searchController.delegate = self;
    
    self.navigationItem.leftBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"返回主页面" style:UIBarButtonItemStyleBordered
                                     target:@"tt://main"
                                     action:@selector(openURLFromButton:)] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController

- (void)setPage:(MenuPage)page {
    _page = page;
    //设置标题以及资源按钮
    self.title = [self nameForMenuPage:_page];
    
    UIImage* image = [UIImage imageNamed:[self imageForMenuPage:_page]];
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:_page] autorelease];
}

/**
 * 创建模型
 */
-(void)createModel
{
    if (_page == MenuPageAssetsSearch) {
        self.dataSource = [[[EntityBaseSearchDataSource alloc] initWithURLQuery:[NSString stringWithFormat:EntityBaseSearchString,@""]] autorelease];
    }
    else if (_page == MenuPageAssetsStore) {
        self.dataSource = [[[EntityBaseSearchDataSource alloc] initWithURLQuery:[NSString stringWithFormat:EntityBaseStoreString,@""]] autorelease];
    }
    else if (_page == MenuPageAssetsSite) {
        self.dataSource = [[[EntityBaseSearchDataSource alloc] initWithURLQuery:[NSString stringWithFormat:EntityBaseSiteString,@""]] autorelease];
    }
    else if (_page == MenuPageAssetsRoom) {
        self.dataSource = [[[EntityBaseSearchDataSource alloc] initWithURLQuery:[NSString stringWithFormat:EntityBaseRoomString,@""]] autorelease];
    }
    else if (_page == MenuPageAssetsCar) {
        self.dataSource = [[[EntityBaseSearchDataSource alloc] initWithURLQuery:[NSString stringWithFormat:EntityBaseCarString,@""]] autorelease];
    }
    
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
        TTURLAction *action =  [[[TTURLAction actionWithURLPath:[NSString stringWithFormat:@"tt://entityBaseGridQuery?page=%i",_page]]
                                 applyQuery:[NSDictionary dictionaryWithObject:[object userInfo] forKey:@"entityBase"]]
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

- (NSString *) getSearchString:(NSString*)searchString
{
    switch (_page) {
        case MenuPageAssetsSearch:
            return [NSString stringWithFormat:EntityBaseSearchString,searchString];
        case MenuPageAssetsStore:
            return [NSString stringWithFormat:EntityBaseStoreString,searchString];
        case MenuPageAssetsSite:
            return [NSString stringWithFormat:EntityBaseSiteString,searchString];
        case MenuPageAssetsRoom:
            return [NSString stringWithFormat:EntityBaseRoomString,searchString];
        case MenuPageAssetsCar:
            return [NSString stringWithFormat:EntityBaseCarString,searchString];
        default:
            return @"{}";
    }
}

#pragma mark -
#pragma mark Content Filtering
/**
 * 根据过滤信息设置过滤list
 */
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSString *searchString = nil;
    if (![searchText isEqual:[NSNull null]] && searchText.length > 0) {
        searchString = [self getSearchString:[NSString stringWithFormat:@"&baseName=%@",searchText]];
        [self.dataSource search:searchString];
    }
    else{
        searchString = [self getSearchString:@""];
        [self.dataSource search:searchString];
    }
}

/**
 * 查询数据返回之后更新searchResultTableView的数据
 */
- (void)modelDidFinishLoad:(id<TTModel>)model
{
    [super modelDidFinishLoad:model];
    self.searchDisplayController.searchResultsDataSource = self.dataSource;
    [self.searchDisplayController.searchResultsTableView reloadData];
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods
/**
 * 发生更换检索字符串时执行的方法
 */
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    savedSearchTerm = searchString;
    return YES;
}

/**
 * 发生更改检索scope时执行的方法
 */
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

/**
 * 初始化search bar时将取消按钮的标题更改为中文
 */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)_searchBar
{
    _searchBar.showsCancelButton = YES;
    for (id cc in [_searchBar subviews]) {
        if ([cc isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)cc;
            [button setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
}
@end
