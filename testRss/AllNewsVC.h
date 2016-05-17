//
//  AllNewsVC.h
//  testRss
//
//  Created by Станислав on 13.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSArticle.h"
@protocol UISearchResultsUpdating;

@interface AllNewsVC : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *errorPlaceHolder;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (strong, nonatomic) NSMutableArray *results;

@property (strong, nonatomic) NSMutableArray<RSSArticle*> * feeds ;
@property (strong, nonatomic) UISearchController *searchController;

@end
