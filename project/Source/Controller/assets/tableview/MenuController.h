#import <Three20/Three20.h>
#import "CommonEnum.h"

@interface MenuController : TTTableViewController<UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    MenuPage        _page;
    NSString		*savedSearchTerm;
    UIAlertView     *_dataAlertView;
    NSMutableArray  *_dataListContent;
    UITableView     *_dataTableView;
    NSString        *_searchTypeCode;
}

@property(nonatomic) MenuPage page;
@property (nonatomic, copy) NSString *savedSearchTerm;

@end
