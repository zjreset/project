#import <Three20/Three20.h>
#import "CommonEnum.h"

@interface EntityBaseMenuController : TTTableViewController<UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    MenuPage        _page;
    NSString		*savedSearchTerm;
}

@property(nonatomic) MenuPage page;
@property (nonatomic, copy) NSString *savedSearchTerm;

@end
