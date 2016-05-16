//
//  FeedsTableViewCell.m
//  testRss
//
//  Created by Станислав on 16.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import "FeedsTableViewCell.h"

@implementation FeedsTableViewCell

-(void) setupFromXib: (NSString*) identifier{
    UIView* view = [self loadFromNib:identifier];
    view.frame = self.frame;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [view setUserInteractionEnabled:NO];
    [self addSubview:view];
}

-(UIView*) loadFromNib:(NSString*) idendifer {
    NSBundle* bundle = [NSBundle bundleForClass:self.class];
    UINib* nib = [UINib nibWithNibName:idendifer bundle:bundle];
    return [nib instantiateWithOwner:self options:nil][0];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) { [self setupFromXib:@"feedsCell"]; }
    return self;
}

-(instancetype) initWithCoder:(NSCoder *)aDecoder{
    self =  [super initWithCoder:aDecoder];
    if (self) { 
        [self setupFromXib:@"feedsCell"]; }
    return self;
}

@end
