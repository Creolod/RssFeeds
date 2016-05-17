//
//  SearchDisplayVC.h
//  testRss
//
//  Created by Станислав on 17.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSArticle.h"

@interface SearchDisplayVC : UITableViewController

@property (nonatomic, strong) NSMutableArray <RSSArticle*> *searchResults;
@property (nonatomic, strong) NSMutableArray *allFeeds;

@end
