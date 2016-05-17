//
//  NewsFeedRoot.h
//  testRss
//
//  Created by Станислав on 18.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSArticle.h"

@interface NewsFeedRoot : UIViewController

@property (strong, nonatomic) NSMutableArray *results;
@property (strong, nonatomic) NSMutableArray<RSSArticle*> * feeds ;
@property (strong, nonatomic) UISearchController *searchController;

@end
