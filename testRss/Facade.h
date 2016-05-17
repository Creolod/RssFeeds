//
//  Facade.h
//  testRss
//
//  Created by Станислав on 14.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"



@interface Facade : NSObject
+ (id)sharedManager;
-(BOOL)addRss:(NSString*)rssUrl;
-(NSMutableArray*)getRssList;
-(NSString*)getRssTitleFromUrl:(NSString*)url;
-(NSMutableArray*)updateNews;
-(NSMutableArray*)getNews;
-(BOOL)getInternetStatus;
-(BOOL)checkURL:(NSString*)url;


//CoreDataManager
-(NSMutableArray *)fetchFromCoreData:(NSString*)entityName;
-(NSManagedObject*)addEntityToCoreData:(NSString*)entityName;
-(void)deleteEntityFromCoreData:(NSManagedObject*)objectForDelete;
-(NSMutableArray*)fetchFromCoreData:(NSString*)entityName withKey:(NSString*)key andValue:(NSString*)value;
@end