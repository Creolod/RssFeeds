//
//  RSSArticle.m
//  testRss
//
//  Created by Станислав on 13.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import "RSSArticle.h"

@implementation RSSArticle

-(id)initWithTitle:(NSString*)title description:(NSString*)descr imageUrl:(NSString*)imageUrl pubDate:(NSDate*)pubDate url:(NSString*)url{
    self = [super init];
    if (self) {
        _title = title;
        _descr = descr;
        _imageUrl = imageUrl;
        _pubDate = pubDate;
        _url = url;
    }
    return self;
}

-(id)initWithEntity:(RssFeed*)managedObject{
    self = [super init];
    if (self) {
        _title = [managedObject title];
        _descr = [managedObject descr];
        _imageUrl = [managedObject imageUrl];
        _pubDate = [managedObject pubDate];
        _url = [managedObject link];
    }
    return self;
}

@end
