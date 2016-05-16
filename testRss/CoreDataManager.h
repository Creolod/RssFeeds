//
//  CoreDataManager.h
//  testRss
//
//  Created by Станислав on 13.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"


@class AppDelegate;
@interface CoreDataManager : NSObject

+(NSManagedObjectContext *)managedObjectContext;
+(NSManagedObject *)addEntity:(NSString*)entityName;
+(NSMutableArray *)fetchThis:(NSString *)entityName;
+(void)deleteEntity:(NSManagedObject *)objectForDelete;
+(NSMutableArray *)fetchThis:(NSString *)entityName key:(NSString*)key value:(NSString*)value;

@end
