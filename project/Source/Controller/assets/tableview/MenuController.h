#import <Three20/Three20.h>

typedef enum {
  MenuPageNone,
  MenuPageAssetsSearch,
  MenuPageAssetsStore,
  MenuPageAssetsSite,
  MenuPageAssetsRoom,
  MenuPageAssetsDrop,
} MenuPage;

@interface MenuController : TTTableViewController<UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    MenuPage        _page;
    NSString		*savedSearchTerm;
}

@property(nonatomic) MenuPage page;
@property (nonatomic, copy) NSString *savedSearchTerm;

@end
