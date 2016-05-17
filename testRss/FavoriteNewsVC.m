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
#import "DetailVC.h"
#import "SearchDisplayVC.h"

@interface FavoriteNewsVC (){
    NSMutableArray<RssFeed*>* coreDataFeeds;
    SearchDisplayVC * searchDisplay;
}

@end

@implementation FavoriteNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableVIew.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self searchControllerLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadFeeds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)searchControllerLoad{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    searchDisplay = [storyboard instantiateViewControllerWithIdentifier:@"SearchResults"];
    [self addObserver:searchDisplay forKeyPath:@"results" options:NSKeyValueObservingOptionNew context:nil];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchDisplay];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.definesPresentationContext = YES;
}

-(void)loadFeeds{
    self.feeds = [[NSMutableArray alloc] init];
    coreDataFeeds = [[Facade sharedManager] fetchFromCoreData:@"RssFeed"];
    for (RssFeed * feed in coreDataFeeds) {
        [self.feeds addObject:[[RSSArticle alloc] initWithEntity:feed]];
    }
    [self.tableVIew reloadData];
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.feeds.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FeedsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.title.text = [[self.feeds objectAtIndex:indexPath.row] title];
    cell.textField.text = [[self.feeds objectAtIndex:indexPath.row] descr];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:[[self.feeds objectAtIndex:indexPath.row] imageUrl]]];
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"segueDetail"]) {
        DetailVC * detailVC = [segue destinationViewController];
        detailVC.feedNumber = [[self.tableVIew indexPathForCell:sender] row];
        detailVC.feeds = self.feeds;
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title contains[c] %@ OR descr contains[c] %@", self.searchController.searchBar.text, self.searchController.searchBar.text];
    self.results = [[self.feeds filteredArrayUsingPredicate:predicate] mutableCopy];
}
- (IBAction)search:(id)sender {
    [self presentViewController:self.searchController animated:YES completion:nil];
}

@end
