//
//  FavoriteNewsVC.h
//  testRss
//
//  Created by Станислав on 13.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllNewsVC.h"
#import "NewsFeedRoot.h"
@interface FavoriteNewsVC : NewsFeedRoot <UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;

@end
