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
    NSMutableArray<RssFeed*>* feeds;
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

-(void)loadFeeds{
    feeds = [[NSMutableArray alloc] init];
    feeds = [[Facade sharedManager] fetchFromCoreData:@"RssFeed"];
    [self.tableVIew reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"segueDetail"]) {
        RSSArticle * article = [[RSSArticle alloc] initWithEntity:[feeds objectAtIndex:[[self.tableVIew indexPathForCell:sender] row]]];
        DetailVC * detailVC = [segue destinationViewController];
        detailVC.rssArticle = article;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
