//
//  RSSManager.m
//  testRss
//
//  Created by Станислав on 14.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import "Facade.h"
#import "RSSManager.h"
#import "RssLinks.h"

@implementation RSSManager

-(BOOL)addRss:(NSString*)rssUrl{
    NSString * rssTitle = [[NSString alloc] init];
    if ((rssTitle = [[Facade sharedManager] getRssTitleFromUrl:rssUrl])){
        RssLinks * entity = (RssLinks*)[[Facade sharedManager] addEntityToCoreData:@"RssLinks"];
        entity.name = rssTitle;
        entity.url = rssUrl;
        return YES;
    }
    return NO;
}

+ (NSMutableArray*)getRssList{
    NSMutableArray * rssList = [[Facade sharedManager] fetchFromCoreData:@"RssLinks"];
    return rssList;
}

@end
