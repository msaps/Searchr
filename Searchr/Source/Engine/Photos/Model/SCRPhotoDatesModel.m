//
//  SCRPhotoDatesModel.m
//  Searchr
//
//  Created by Merrick Sapsford on 03/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRPhotoDatesModel.h"

NSString *const kSCRPhotoDatesModelLastUpdateKey = @"lastupdate";
NSString *const kSCRPhotoDatesModelPostedKey = @"posted";
NSString *const kSCRPhotoDatesModelTakenKey = @"taken";
NSString *const kSCRPhotoDatesModelTakenGranularityKey = @"takengranularity";
NSString *const kSCRPhotoDatesModelTakenUnknownKey = @"takenunknown";

@implementation SCRPhotoDatesModel

- (void)evaluateDataDictionary:(NSDictionary *)dictionary {
    
    NSNumber *lastUpdateTimestamp = [dictionary objectForKey:kSCRPhotoDatesModelLastUpdateKey];
    _lastUpdated = [NSDate dateWithTimeIntervalSince1970:[lastUpdateTimestamp integerValue]];
    
    NSNumber *postedTimestamp = [dictionary objectForKey:kSCRPhotoDatesModelPostedKey];
    _posted = [NSDate dateWithTimeIntervalSince1970:[postedTimestamp integerValue]];
    
    _taken = [dictionary objectForKey:kSCRPhotoDatesModelTakenKey];
    
    _takenGranularity = [[dictionary objectForKey:kSCRPhotoDatesModelTakenGranularityKey]integerValue];
    _takenUnknown = [[dictionary objectForKey:kSCRPhotoDatesModelTakenUnknownKey]boolValue];
}

@end
