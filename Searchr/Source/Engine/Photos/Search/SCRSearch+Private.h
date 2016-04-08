//
//  SCRSearchPrivate.h
//  Searchr
//
//  Created by Merrick Sapsford on 05/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRSearch.h"

@interface SCRSearch () {
    NSMutableDictionary *_components;
}

/**
 The components to search for.
 */
@property (nonatomic, strong, readonly, nonnull) NSDictionary *components;

- (void)setFailed:(BOOL)failed;

- (void)setText:(nonnull NSString *)text;
- (void)setMinimumUploadDate:(nonnull NSDate *)minimumUploadDate;
- (void)setMaximumUploadDate:(nonnull NSDate *)maximumUploadDate;
- (void)setMinimumTakenDate:(nonnull NSDate *)minimumTakenDate;
- (void)setMaximumTakenDate:(nonnull NSDate *)maximumTakenDate;
- (void)setLocationCoordinate:(CLLocationCoordinate2D)locationCoordinate;
- (void)setLocationRadius:(NSInteger)locationRadius;
- (void)setLocationRadiusUnit:(SCRSearchRadiusUnit)locationRadiusUnit;

@end
