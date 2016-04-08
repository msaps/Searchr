//
//  SCRSearchBuilder.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRSearchBuilder.h"
#import "SCRSearch+Private.h"

@implementation SCRSearchBuilder

#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        _search = [SCRSearch new];
    }
    return self;
}

#pragma mark - Public

- (void)setText:(NSString *)text {
    [self.search setText:text];
}

- (NSString *)text {
    return self.search.text;
}

- (void)setMinimumUploadDate:(NSDate *)minimumUploadDate {
    [self.search setMinimumUploadDate:minimumUploadDate];
}

- (NSDate *)minimumUploadDate {
    return self.search.minimumUploadDate;
}

- (void)setMaximumUploadDate:(NSDate *)maximumUploadDate {
    [self.search setMaximumUploadDate:maximumUploadDate];
}

- (NSDate *)maximumUploadDate {
    return self.search.maximumUploadDate;
}

- (void)setMinimumTakenDate:(NSDate *)minimumTakenDate {
    [self.search setMinimumTakenDate:minimumTakenDate];
}

- (NSDate *)minimumTakenDate {
    return self.search.minimumTakenDate;
}

- (void)setMaximumTakenDate:(NSDate *)maximumTakenDate {
    [self.search setMaximumTakenDate:maximumTakenDate];
}

- (NSDate *)maximumTakenDate {
    return self.search.maximumTakenDate;
}

- (void)setLocationCoordinate:(CLLocationCoordinate2D)locationCoordinate {
    [self.search setLocationCoordinate:locationCoordinate];
}

- (CLLocationCoordinate2D)locationCoordinate {
    return self.search.locationCoordinate;
}

- (void)setLocationRadius:(NSInteger)locationRadius {
    [self.search setLocationRadius:locationRadius];
}

- (NSInteger)locationRadius {
    return self.search.locationRadius;
}

- (void)setLocationRadiusUnit:(SCRSearchRadiusUnit)locationRadiusUnit {
    [self.search setLocationRadiusUnit:locationRadiusUnit];
}

- (SCRSearchRadiusUnit)locationRadiusUnit {
    return self.search.locationRadiusUnit;
}

- (BOOL)isValid {
    return self.search.components.count > 0;
}

@end
