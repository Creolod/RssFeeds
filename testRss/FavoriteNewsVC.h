//
//  FavoriteNewsVC.h
//  testRss
//
//  Created by Станислав on 13.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSArticle.h"
#import "AllNewsVC.h"

@interface FavoriteNewsVC : AllNews <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSMutableArray *results;
@property (strong, nonatomic) NSMutableArray<RSSArticle*> * feeds ;

@end
