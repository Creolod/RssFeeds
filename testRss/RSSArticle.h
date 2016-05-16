//
//  RSSArticle.h
//  testRss
//
//  Created by Станислав on 13.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RssFeed.h"

@interface RSSArticle : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* descr;
@property (strong, nonatomic) NSString* imageUrl;
@property (strong, nonatomic) NSDate* pubDate;
@property (strong, nonatomic) NSString* url;

-(id)initWithTitle:(NSString*)title description:(NSString*)descr imageUrl:(NSString*)imageUrl pubDate:(NSDate*)pubDate url:(NSString*)url;
-(id)initWithEntity:(RssFeed*)managedObject;


@end
