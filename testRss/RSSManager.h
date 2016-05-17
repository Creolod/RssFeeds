//
//  RSSManager.h
//  testRss
//
//  Created by Станислав on 14.05.16.
//  Copyright © 2016 test. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface RSSManager : NSObject 

-(BOOL)addRss:(NSString*)rssUrl;
+ (NSMutableArray*)getRssList;


@end
