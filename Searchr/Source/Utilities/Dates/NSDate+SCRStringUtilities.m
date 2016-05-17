//
//  NSDate+SCRStringUtilities.m
//  Searchr
//
//  Created by Merrick Sapsford on 03/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "NSDate+SCRStringUtilities.h"

@implementation NSDate (SCRStringUtilities)

- (NSString *)scr_shortDateString {
    NSDateFormatter *dateFormatter = [self dateFormatter];
    return [dateFormatter stringFromDate:self];
}

- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *_dateFormatter;
    if (!_dateFormatter) {
        _dateFormatter = [NSDateFormatter new];
        _dateFormatter.dateFormat = @"dd MMM yyyy";
    }
    return _dateFormatter;
}

@end
