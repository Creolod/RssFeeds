//
//  AllNewsVC.m
//  testRss
//
//  Created by Станислав on 13.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import "Facade.h"
#import "AllNewsVC.h"
#import "FeedsTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DetailVC.h"
#import "RSSArticle.h"
#import "SearchDisplayVC.h"

@interface AllNewsVC (){
    NSArray * array;
    SearchDisplayVC * searchDisplay;
    
}

@end

@implementation AllNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)preload{
    _feeds = [[NSMutableArray alloc] init];
    [self getFeeds];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
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

-(void)getFeeds{
    _feeds = [[Facade sharedManager] updateNews];
    if (_feeds.count == 0 || !_feeds) {
        self.errorPlaceHolder.hidden = NO;
        self.errorLabel.text = @"PULL DOWN TO REFRESH";
    } else {
        self.errorPlaceHolder.hidden = YES;
    }
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self.tableView reloadData];
    if (![[Facade sharedManager]getInternetStatus]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Can't load feeds" message:@"Check your internet connection" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action){
                                   }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else if ([[Facade sharedManager] fetchFromCoreData:@"RssLinks"].count == 0) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Can't load feeds" message:@"Add some RSS links" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action){
                                       }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else
        [self getFeeds];
    [refreshControl endRefreshing];
}


#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _feeds.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray * tempArray = [[NSMutableArray alloc] init];
    [tempArray addObjectsFromArray:_feeds];
    FeedsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.title.text = [[tempArray objectAtIndex:indexPath.row] title];
    cell.textField.text = [[tempArray objectAtIndex:indexPath.row] descr];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:[[tempArray objectAtIndex:indexPath.row] imageUrl]]];
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"segueDetail"]) {
        DetailVC * detailVC = [segue destinationViewController];
        detailVC.feedNumber = [[self.tableView indexPathForCell:sender] row];
        detailVC.feeds = _feeds;
    }
}

#pragma mark - search

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title contains[c] %@ OR descr contains[c] %@", self.searchController.searchBar.text, self.searchController.searchBar.text];
    self.results = [[_feeds filteredArrayUsingPredicate:predicate] mutableCopy];
}
- (IBAction)search:(id)sender {
    [self presentViewController:self.searchController animated:YES completion:nil];
}

@end
