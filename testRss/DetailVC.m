//
//  DetailVC.m
//  testRss
//
//  Created by Станислав on 16.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import "DetailVC.h"
#import "Facade.h"
#import "RssFeed.h"

@interface DetailVC (){
    NSMutableArray * fetchResult;
}

@end

@implementation DetailVC{
    BOOL savedBool;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    fetchResult = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    [self preload];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:NO];
    [self viewDidAppearLoad];
    [self.placeHolder setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:NO];
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)preload{
    [self.tabBarController.tabBar setHidden:YES];
    self.imageWidth.constant = self.view.frame.size.width * 0.4;
    fetchResult = [[Facade sharedManager] fetchFromCoreData:@"RssFeed" withKey:@"title" andValue:self.rssArticle.title];
    if (fetchResult.count > 0) {
        [self save:YES];
    } else{
        [self save:NO];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.textView.contentInset = UIEdgeInsetsMake(-10.0, 0, 0,0);
    [self.textView setText:self.rssArticle.descr];
    [self.titleTextView setText:self.rssArticle.title];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM, yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:self.rssArticle.pubDate];
    self.dateLabel.text = stringFromDate;
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.rssArticle.imageUrl]]];
}

-(void)save:(BOOL)cond{
    savedBool = cond;
    if (cond) {
        self.addFavorite.image = [UIImage imageNamed:@"starFilled"];
    } else{
        self.addFavorite.image = [UIImage imageNamed:@"star"];
    }
}

-(void)viewDidAppearLoad{
    UIBezierPath * imgRect = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.imageWidth.constant, self.imageWidth.constant)];
    self.textView.textContainer.exclusionPaths = @[imgRect];
    
    CGSize textViewSize = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, CGFLOAT_MAX)];
    self.heightConstraint.constant = textViewSize.height;
    
    textViewSize = [self.titleTextView sizeThatFits:CGSizeMake(self.titleTextView.frame.size.width, CGFLOAT_MAX)];
    self.titleHeightConstraint.constant = textViewSize.height - 20;
}

- (IBAction)addFavoriteFeed:(id)sender {
    if (!savedBool) {
        RssFeed * rssFeed = (RssFeed*)[[Facade sharedManager] addEntityToCoreData:@"RssFeed"];
        rssFeed.title = self.rssArticle.title;
        rssFeed.descr = self.rssArticle.descr;
        rssFeed.link = self.rssArticle.url;
        rssFeed.imageUrl = self.rssArticle.imageUrl;
        [self save:YES];
    } else{
        [[Facade sharedManager] deleteEntityFromCoreData:[fetchResult objectAtIndex:0]];
        [self save:NO];
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
