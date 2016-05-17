//
//  SearchDisplayVC.m
//  testRss
//
//  Created by Станислав on 17.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import "SearchDisplayVC.h"
#import "FeedsTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DetailVC.h"
#import "Facade.h"
#import "NewsFeedRoot.h"

@implementation SearchDisplayVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.title.text = [[self.searchResults objectAtIndex:indexPath.row] title];
    cell.textField.text = [[self.searchResults objectAtIndex:indexPath.row] descr];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:[[self.searchResults objectAtIndex:indexPath.row] imageUrl]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailVC *detailVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"DetailVC"];
    for (RSSArticle * rss in _allFeeds) {
        if ([rss isEqual:[self.searchResults objectAtIndex:[indexPath row]]]) {
            detailVC.feedNumber = [_allFeeds indexOfObject:rss];
        }
    }
    detailVC.feeds = _allFeeds;
    [self.presentingViewController.navigationController pushViewController:detailVC animated:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    self.searchResults = [(NewsFeedRoot*)object results];
    self.allFeeds = [(NewsFeedRoot*)object feeds];
    // extract array from observer
    [self.tableView reloadData];
}
-(void)dealloc{
    [self.view removeFromSuperview];
    NSLog(@"DEALLOC");
}


@end
