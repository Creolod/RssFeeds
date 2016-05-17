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

@interface AllNewsVC (){
    NSMutableArray<RSSArticle*> * feeds ;
    NSArray * array;
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
    feeds = [[NSMutableArray alloc] init];
    [self getFeeds];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

-(void)getFeeds{
    feeds = [[Facade sharedManager] getNews];
    if (feeds.count == 0 || !feeds) {
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
        detailVC.feedNumber = [[self.tableView indexPathForCell:sender] row];
        detailVC.feeds = feeds;
    }
}

/*


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
