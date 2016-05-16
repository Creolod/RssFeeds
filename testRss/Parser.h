//
//  Parser.h
//  testRss
//
//  Created by Станислав on 13.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSArticle.h"

@interface Parser : NSObject <NSXMLParserDelegate>{
    NSXMLParser* parser;
    RSSArticle* rssArticle;
    NSString* element;
    NSMutableString* title;
    NSMutableString* description;
    NSMutableString* link;
    NSMutableArray* feeds;
    NSMutableString* rssTitle;
    NSMutableString* defaultImageLink;
    NSMutableString* imageLink;
    NSDate * pubDate;
}
-(NSString*)getRssTitleFromUrl:(NSString*)rssUrl ;
-(NSMutableArray*)getNews;
@end

