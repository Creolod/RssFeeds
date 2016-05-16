//
//  Parser.m
//  testRss
//
//  Created by Станислав on 13.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import "Facade.h"
#import "Parser.h"
#import "RssLinks.h"

@implementation Parser

NSArray <RssLinks *> * array;
BOOL rssTitleBool;
BOOL defaultImageBool;
NSString * currentRssUrl;

-(id)init{
    self = [super init];
    return self;
}

-(NSString*)getRssTitleFromUrl:(NSString*)rssUrl{
    currentRssUrl = rssUrl;
    rssTitleBool = YES;
    if ([self getNewsFromUrl:rssUrl]) {
        return rssTitle;
    }
    return nil;
}

-(NSMutableArray*)getNews{
    defaultImageBool = YES;
    defaultImageLink = [[NSMutableString alloc] init];
    feeds = [[NSMutableArray alloc]init];
    array = [[Facade sharedManager] getRssList];
    for (int i = 0; i < array.count; i++) {
        if (![self getNewsFromUrl:[array[i] url]]) {
            return nil;
        }
    }
    NSSortDescriptor* sortByDate = [NSSortDescriptor sortDescriptorWithKey:@"pubDate" ascending:NO];
    [feeds sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
    return feeds;
}

-(BOOL)getNewsFromUrl:(NSString*)urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    if ([parser parse]) {
        return YES;
    }
    return nil;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        title   = [[NSMutableString alloc] init];
        description    = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
        imageLink = [[NSMutableString alloc] init];
        pubDate = [[NSDate alloc] init];
        [imageLink setString:defaultImageLink];
    }
    if ([element isEqualToString:@"title"] && rssTitleBool){
        rssTitle   = [[NSMutableString alloc] init];
    }
    if ([element isEqualToString:@"media:content"] || [element isEqualToString:@"enclosure"]){
        if ([[attributeDict objectForKey:@"url"] rangeOfString:@"vid"].location == NSNotFound) {
            [imageLink setString:[attributeDict objectForKey:@"url"]];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        if (!rssTitleBool)
            [title appendString:string];
        else
            [rssTitle appendString:string];
    }
    else if ([element isEqualToString:@"description"]) {
        [description appendString:string];
        
    }else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    } else if ([element isEqualToString:@"pubDate"]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZ"];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [dateFormatter setLocale:enUSPOSIXLocale];
        if ([dateFormatter dateFromString:string]) {
            pubDate = [dateFormatter dateFromString:string];
        }
    }
    if ([element isEqualToString:@"url"] && defaultImageBool) {
        [defaultImageLink setString:string];
        defaultImageBool = NO;
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        rssArticle = [[RSSArticle alloc] initWithTitle:title description:description imageUrl:imageLink pubDate:pubDate url:link];
        [feeds addObject:rssArticle];
    }
    if ([elementName isEqualToString:@"title"] && rssTitleBool){
        rssTitleBool = NO;
    }
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    
}

-(void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError{
    
}
@end
