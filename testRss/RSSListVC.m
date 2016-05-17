//
//  RSSListVC.m
//  testRss
//
//  Created by Станислав on 14.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import "RSSListVC.h"
#import "RssLinks.h"
#import "Facade.h"

@interface RSSListVC (){
    NSMutableArray <RssLinks*> * rssList;
}

@end

@implementation RSSListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)waitAction:(BOOL)condition{
    [self.loadingView setHidden:!condition];
    if (condition) [self.activityIndicator startAnimating];
    else [self.activityIndicator stopAnimating];
}

#pragma mark - IBActions

- (IBAction)addButtonAction:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"New RSS Link" message:@"Enter URL" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
     }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action){
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action){
                                   UITextField *urlTF = alert.textFields.firstObject;
                                   [self waitAction:YES];
                                   [[Facade sharedManager] addRss:urlTF.text];
                                   [self.tableView reloadData];
                                   [self waitAction:NO];
                                   [self viewWillDisappear:YES];
                                   [self viewWillAppear:YES];
                               }];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)longPressOnCell:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        CGPoint p = [sender locationInView:self.tableView];
        
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
        if (indexPath) {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            if (cell.isHighlighted) {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"New RSS Title" message:@"Enter Title" preferredStyle:UIAlertControllerStyleAlert];
                [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
                 {
                 }];
                UIAlertAction *cancelAction = [UIAlertAction
                                               actionWithTitle:@"Cancel"
                                               style:UIAlertActionStyleCancel
                                               handler:^(UIAlertAction *action){
                                               }];
                
                UIAlertAction *okAction = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action){
                                               UITextField *name = alert.textFields.firstObject;
                                               
                                               RssLinks * rssLink = [[Facade sharedManager] fetchFromCoreData:@"RssLinks" withKey:@"name" andValue:cell.textLabel.text][0];
                                               rssLink.name = name.text;
                                               [self.tableView reloadData];
                                               [self viewWillDisappear:YES];
                                               [self viewWillAppear:YES];
                                           }];
                
                [alert addAction:cancelAction];
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    rssList = [[[Facade sharedManager] getRssList] mutableCopy];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rssList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RssCell" forIndexPath:indexPath];
    cell.textLabel.text = [[rssList objectAtIndex:indexPath.row] name];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[Facade sharedManager] deleteEntityFromCoreData:[rssList objectAtIndex:indexPath.row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end
