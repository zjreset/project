#import "MenuController.h"
#import "AssetsSearchDataSource.h"
#import "AssetsRecord.h"
#import "CustomDaragRefresh.h"
#import "AppDelegate.h"
#import "AssetsTypeTop.h"

static NSString * AssetsSearchString = @"{1:1%@}";
static NSString * AssetsStoreString = @"{position:4%@}";
static NSString * AssetsSiteString = @"{position:1%@}";
static NSString * AssetsRoomString = @"{position:3%@}";
static NSString * AssetsCarString = @"{position:2%@}";
static NSString * AssetsDropString = @"{useStatus:0%@}";
static NSInteger DATATABLETAG = -5;
@implementation MenuController
@synthesize page = _page,savedSearchTerm;
///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (NSString*)nameForMenuPage:(MenuPage)page {
  switch (page) {
    case MenuPageAssetsSearch:
          return @"全部资产";
    case MenuPageAssetsStore:
          return @"库存资产";
    case MenuPageAssetsSite:
          return @"基站资产";
    case MenuPageAssetsRoom:
          return @"机房资产";
    case MenuPageAssetsCar:
          return @"移动基站";
    case MenuPageAssetsDrop:
          return @"报废资产";
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
        case MenuPageAssetsDrop:
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
    _searchController.searchBar.placeholder = NSLocalizedString(@"输入关键字进行查询", @"");
    //self.searchDisplayController.searchBar.showsSearchResultsButton = YES;
    
    //设置scopeBar
    _searchController.searchBar.showsScopeBar = YES;
    _searchController.searchBar.scopeButtonTitles = [[NSArray alloc] initWithObjects:@"资产编码", @"资产条码", @"资产名称", @"资产类型", nil];
    _searchController.searchResultsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth  | UIViewAutoresizingFlexibleHeight;
    _searchController.searchResultsTableView.delegate = self;
    //_searchController.searchResultsViewController.variableHeightRows = NO;
    self.tableView.tableHeaderView = _searchController.searchBar;
    
    //设置代理
    _searchController.searchBar.delegate = self;
    _searchController.delegate = self;
    
    //新增资产需要关联到具体的物理点,因此此处去除掉新增资产的按钮
    //[self setRightBarButtonItem];
    
    self.navigationItem.leftBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"返回主页面" style:UIBarButtonItemStyleBordered
                                     target:@"tt://main"
                                     action:@selector(openURLFromButton:)] autorelease];
    
    _dataAlertView = [[UIAlertView alloc] initWithTitle: @"请选择"
                                               message: @"\n\n\n\n\n\n\n\n\n\n\n"
                                              delegate: nil
                                     cancelButtonTitle: @"取消"
                                      otherButtonTitles: nil];
    _dataTableView = [[UITableView alloc] initWithFrame: CGRectMake(15, 50, 255, 225)];
    _dataTableView.delegate = self;
    _dataTableView.dataSource = self;
    _dataTableView.tag = DATATABLETAG;
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
        self.dataSource = [[[AssetsSearchDataSource alloc] initWithURLQuery:[NSString stringWithFormat:AssetsSearchString,@""]] autorelease];
    }
    else if (_page == MenuPageAssetsStore) {
        self.dataSource = [[[AssetsSearchDataSource alloc] initWithURLQuery:[NSString stringWithFormat:AssetsStoreString,@""]] autorelease];
    }
    else if (_page == MenuPageAssetsSite) {
        self.dataSource = [[[AssetsSearchDataSource alloc] initWithURLQuery:[NSString stringWithFormat:AssetsSiteString,@""]] autorelease];
    }
    else if (_page == MenuPageAssetsRoom) {
        self.dataSource = [[[AssetsSearchDataSource alloc] initWithURLQuery:[NSString stringWithFormat:AssetsRoomString,@""]] autorelease];
    }
    else if (_page == MenuPageAssetsCar) {
        self.dataSource = [[[AssetsSearchDataSource alloc] initWithURLQuery:[NSString stringWithFormat:AssetsCarString,@""]] autorelease];
    }
    else if (_page == MenuPageAssetsDrop) {
        self.dataSource = [[[AssetsSearchDataSource alloc] initWithURLQuery:[NSString stringWithFormat:AssetsDropString,@""]] autorelease];
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
        TTURLAction *action =  [[[TTURLAction actionWithURLPath:@"tt://assetsRecordQuery"]
                                 applyQuery:[NSDictionary dictionaryWithObject:[object userInfo] forKey:@"assetsRecord"]]
                                applyAnimated:YES];
        [[TTNavigator navigator] openURLAction:action];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == DATATABLETAG) {
        return [_dataListContent count];
    }
    return [tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == DATATABLETAG) {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        AssetsTypeTop *att;
        att = [_dataListContent objectAtIndex:indexPath.row];
        cell.textLabel.text = att.assetsTypeName;
        return cell;
    }
    else {
        return  [tableView cellForRowAtIndexPath:indexPath];
    }
}

#pragma mark - Table view delegate
/**
 * 点击查询结果框cell的响应
 */
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == DATATABLETAG) {
        AssetsTypeTop *att;
        att = [_dataListContent objectAtIndex:indexPath.row];
        [self.searchDisplayController.searchBar setText:att.assetsTypeName];
        _searchTypeCode = att.assetsTypeCode;
        NSUInteger cancelButtonIndex = _dataAlertView.cancelButtonIndex;
        [_dataAlertView dismissWithClickedButtonIndex: cancelButtonIndex animated: YES];
        [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
         [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    }
    else {
        TTTableViewCell *cell = (TTTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
        TTTableItem *object = [cell object];
        [self didSelectObject:object atIndexPath:indexPath];
    }
}

- (NSString *) getSearchString:(NSString*)searchString
{
    switch (_page) {
        case MenuPageAssetsSearch:
            return [NSString stringWithFormat:AssetsSearchString,searchString];
        case MenuPageAssetsStore:
            return [NSString stringWithFormat:AssetsStoreString,searchString];
        case MenuPageAssetsSite:
            return [NSString stringWithFormat:AssetsSiteString,searchString];
        case MenuPageAssetsRoom:
            return [NSString stringWithFormat:AssetsRoomString,searchString];
        case MenuPageAssetsCar:
            return [NSString stringWithFormat:AssetsCarString,searchString];
        case MenuPageAssetsDrop:
            return [NSString stringWithFormat:AssetsDropString,searchString];
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
        if ([scope isEqualToString:@"资产编码"])
        {
            searchString = [self getSearchString:[NSString stringWithFormat:@",assetsCode:%@",searchText]];
        }
        else if([scope isEqualToString:@"资产条码"])
        {
            searchString = [self getSearchString:[NSString stringWithFormat:@",barcode:%@",searchText]];
        }
        else if([scope isEqualToString:@"资产类型"])
        {
            searchString = [self getSearchString:[NSString stringWithFormat:@",assetsTypeCode:%@",_searchTypeCode]];
        }
        else        //资产名称
        {
            searchString = [self getSearchString:[NSString stringWithFormat:@",name:%@",searchText]];
        }
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
    _searchTypeCode = nil;
    // Return YES to cause the search result table view to be reloaded.
    savedSearchTerm = searchString;
    if([[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]] isEqualToString:@"资产类型"]){
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        _dataListContent = [[NSMutableArray alloc] initWithArray:delegate.assetsTypeTopList];
        [_dataTableView reloadData];
        [_dataAlertView addSubview: _dataTableView];
        [_dataAlertView show];
    }
    else {
        [self filterContentForSearchText:searchString scope:
         [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    }
    return YES;
}

/**
 * 发生更改检索scope时执行的方法
 */
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    _searchTypeCode = nil;
    if([[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption] isEqualToString:@"资产类型"]){
        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        _dataListContent = [[NSMutableArray alloc] initWithArray:delegate.assetsTypeTopList];
        [_dataTableView reloadData];
        [_dataAlertView addSubview: _dataTableView];
        [_dataAlertView show];
    }
    else {
        [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
         [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    }
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
