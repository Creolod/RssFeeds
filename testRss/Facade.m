//
//  Facade.m
//  testRss
//
//  Created by Станислав on 14.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import "Parser.h"
#import "Facade.h"
#import "RSSManager.h"
#import "CoreDataManager.h"
#import "Reachability.h"

@implementation Facade{
    Parser * parser;
    RSSManager * rssManager;
    Reachability * reachability;
    NetworkStatus networkStatus;
}

#pragma mark - Initialization

+ (id)sharedManager {
    static Facade *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(id)init{
    self = [super init];
    if (self) {
        parser = [[Parser alloc] init];
        rssManager = [[RSSManager alloc] init];
        reachability = [Reachability reachabilityForInternetConnection];
        [reachability startNotifier];
    }
    return self;
}

#pragma mark - InternetReachability

-(BOOL)getInternetStatus{
    networkStatus= [reachability currentReachabilityStatus];
    return (networkStatus != NotReachable) ? YES :  NO;
}

-(BOOL)checkURL:(NSString*)url{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]];
}

#pragma mark - RSSManager

-(BOOL)addRss:(NSString*)rssUrl{
    return [rssManager addRss:rssUrl];
}

-(NSMutableArray*)getRssList{
    return [RSSManager getRssList];
}

#pragma mark - Parser

-(NSMutableArray*)getNews{
    return [parser getNews];
}

-(NSString*)getRssTitleFromUrl:(NSString*)url{
    return [parser getRssTitleFromUrl:url];
}

#pragma mark - CoreDataManager

-(NSMutableArray*)fetchFromCoreData:(NSString*)entityName withKey:(NSString*)key andValue:(NSString*)value{
    return [CoreDataManager fetchThis:entityName key:key value:value];
}

-(NSMutableArray *)fetchFromCoreData:(NSString*)entityName{
    return [CoreDataManager fetchThis:entityName];
}

-(NSManagedObject*)addEntityToCoreData:(NSString*)entityName{
    return [CoreDataManager addEntity:entityName];
}

-(void)deleteEntityFromCoreData:(NSManagedObject*)objectForDelete{
    [CoreDataManager deleteEntity:objectForDelete];
}

@end
