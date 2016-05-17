//
//  DetailVC.h
//  testRss
//
//  Created by Станислав on 16.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSArticle.h"

@interface DetailVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextView *titleTextView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeightConstraint;
@property (assign, nonatomic) NSInteger feedNumber;
@property (strong, nonatomic) NSMutableArray <RSSArticle*> * feeds;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addFavorite;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *placeHolder;
@property (assign, nonatomic) BOOL isItFromNewsFeed;

@end
