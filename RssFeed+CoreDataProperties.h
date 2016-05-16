//
//  RssFeed+CoreDataProperties.h
//  testRss
//
//  Created by Станислав on 16.05.16.
//  Copyright © 2016 test. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RssFeed.h"

NS_ASSUME_NONNULL_BEGIN

@interface RssFeed (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *imageUrl;
@property (nullable, nonatomic, retain) NSString *link;
@property (nullable, nonatomic, retain) NSDate *pubDate;
@property (nullable, nonatomic, retain) NSString *descr;

@end

NS_ASSUME_NONNULL_END
