//
//  FavoriteNewsVC.m
//  testRss
//
//  Created by Станислав on 13.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import "FavoriteNewsVC.h"
#import "RssFeed.h"
#import "Facade.h"
#import "FeedsTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RSSArticle.h"
#import "DetailVC.h"

@interface FavoriteNewsVC (){
    NSMutableArray<RssFeed*>* coreDataFeeds;
    NSMutableArray<RSSArticle*>* feeds;
}

@end

@implementation FavoriteNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableVIew.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadFeeds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)loadFeeds{
    feeds = [[NSMutableArray alloc] init];
    coreDataFeeds = [[Facade sharedManager] fetchFromCoreData:@"RssFeed"];
    for (RssFeed * feed in coreDataFeeds) {
        [feeds addObject:[[RSSArticle alloc] initWithEntity:feed]];
    }
    [self.tableVIew reloadData];
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return feeds.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FeedsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.title.text = [[feeds objectAtIndex:indexPath.row] title];
    cell.textField.text = [[feeds objectAtIndex:indexPath.row] descr];
    //    cell.image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[feeds objectAtIndex:indexPath.row] imageUrl]]]];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:[[feeds objectAtIndex:indexPath.row] imageUrl]]];
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"segueDetail"]) {
        DetailVC * detailVC = [segue destinationViewController];
        detailVC.feedNumber = [[self.tableVIew indexPathForCell:sender] row];
        detailVC.feeds = feeds;
    }
}

@end
