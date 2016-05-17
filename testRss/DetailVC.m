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
    RSSArticle * rssArticle;
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
    [self loadFeed];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:NO];
    [self setTextViewSizes];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:NO];
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)loadFeed{
    rssArticle = [_feeds objectAtIndex:_feedNumber];
    fetchResult = [[Facade sharedManager] fetchFromCoreData:@"RssFeed" withKey:@"title" andValue:rssArticle.title];
    if (fetchResult.count > 0) {
        [self save:YES];
    } else{
        [self save:NO];
    }
    [self.textView setText:rssArticle.descr];
    [self.titleTextView setText:rssArticle.title];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM, yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:rssArticle.pubDate];
    self.dateLabel.text = stringFromDate;
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:rssArticle.imageUrl]]];
}

-(void)preload{
    [self.navigationController.interactivePopGestureRecognizer setEnabled:NO];
    [self.tabBarController.tabBar setHidden:YES];
    self.imageWidth.constant = self.view.frame.size.width * 0.4;
    self.textView.contentInset = UIEdgeInsetsMake(-10.0, 0, 0,0);
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)save:(BOOL)cond{
    savedBool = cond;
    if (cond) {
        self.addFavorite.image = [UIImage imageNamed:@"starFilled"];
    } else{
        self.addFavorite.image = [UIImage imageNamed:@"star"];
    }
}

-(void)setTextViewSizes{
    UIBezierPath * imgRect = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.imageWidth.constant, self.imageWidth.constant)];
    self.textView.textContainer.exclusionPaths = @[imgRect];
    CGSize textViewSize = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, CGFLOAT_MAX)];
    self.heightConstraint.constant = textViewSize.height;
    textViewSize = [self.titleTextView sizeThatFits:CGSizeMake(self.titleTextView.frame.size.width, CGFLOAT_MAX)];
    self.titleHeightConstraint.constant = textViewSize.height - 20;
    [self.placeHolder setHidden:YES];
}

- (IBAction)leftSwipe:(UISwipeGestureRecognizer *)sender {
    if (_feedNumber + 1 < _feeds.count) {
        _feedNumber++;
        [self.placeHolder setHidden:NO];
        [self loadFeed];
        [self setTextViewSizes];
    } else {
        NSLog(@"END");
    }
}
- (IBAction)rightSwipe:(UISwipeGestureRecognizer *)sender {
    if (_feedNumber - 1>= 0) {
        _feedNumber--;
        [self.placeHolder setHidden:NO];
        [self loadFeed];
        [self setTextViewSizes];
    } else {
        NSLog(@"BEGIN");
    }
    
}

- (IBAction)addFavoriteFeed:(id)sender {
    if (!savedBool) {
        RssFeed * rssFeed = (RssFeed*)[[Facade sharedManager] addEntityToCoreData:@"RssFeed"];
        rssFeed.title = rssArticle.title;
        rssFeed.descr = rssArticle.descr;
        rssFeed.link = rssArticle.url;
        rssFeed.imageUrl = rssArticle.imageUrl;
        rssFeed.pubDate = rssArticle.pubDate;
        [self save:YES];
    } else{
        [[Facade sharedManager] deleteEntityFromCoreData:[fetchResult objectAtIndex:0]];
        [self save:NO];
    }
}


@end
