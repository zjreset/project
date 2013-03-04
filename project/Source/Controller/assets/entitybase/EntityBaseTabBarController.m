#import "EntityBaseTabBarController.h"

@implementation EntityBaseTabBarController

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)viewDidLoad {
  [self setTabURLs:[NSArray arrayWithObjects:@"tt://entityMenu/2",
                                             @"tt://entityMenu/3",
                                             @"tt://entityMenu/4",
                                             @"tt://entityMenu/5",
                                             nil]];
}

@end
