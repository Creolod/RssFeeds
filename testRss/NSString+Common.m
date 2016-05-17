//
//  NSString+Common.m
//  testRss
//
//  Created by Станислав on 18.05.16.
//  Copyright © 2016 test. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

- (BOOL)containsString:(NSString *)string
               options:(NSStringCompareOptions)options {
    NSRange rng = [self rangeOfString:string options:options];
    return rng.location != NSNotFound;
}

- (BOOL)containsString:(NSString *)string {
    return [self containsString:string options:0];
}

@end
