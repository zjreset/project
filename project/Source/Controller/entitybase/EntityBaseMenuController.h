#import <Three20/Three20.h>

typedef enum {
    EntityBaseMenuPageNone,
    EntityBaseMenuPageAssetsSearch,
    EntityBaseMenuPageAssetsSite,
    EntityBaseMenuPageAssetsStore,
    EntityBaseMenuPageAssetsRoom,
    EntityBaseMenuPageAssetsCar,
} EntityBaseMenuPage;

@interface EntityBaseMenuController : TTTableViewController<UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    EntityBaseMenuPage        _page;
    NSString		*savedSearchTerm;
}

@property(nonatomic) EntityBaseMenuPage page;
@property (nonatomic, copy) NSString *savedSearchTerm;

@end
