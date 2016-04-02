//
//  SCRSearchBuilder.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRSearchBuilder.h"

NSString *const kSCRSearchBuilderTextKey = @"text";
NSString *const kSCRSearchBuilderMinimumUploadDateKey = @"min_upload_date";
NSString *const kSCRSearchBuilderMaximumUploadDateKey = @"max_upload_date";
NSString *const kSCRSearchBuilderMinimumTakenDateKey = @"min_taken_date";
NSString *const kSCRSearchBuilderMaximumTakenDateKey = @"max_taken_date";
NSString *const kSCRSearchBuilderLatitudeKey = @"lat";
NSString *const kSCRSearchBuilderLongitudeKey = @"lon";
NSString *const kSCRSearchBuilderRadiusKey = @"radius";
NSString *const kSCRSearchBuilderRadiusUnitsKey = @"radius_units";

NSString *const kSCRSearchBuilderRadiusUnitKilometers = @"km";
NSString *const kSCRSearchBuilderRadiusUnitMiles = @"mi";

@interface SCRSearchBuilder () {
    NSMutableDictionary *_components;
}

@end

@implementation SCRSearchBuilder

#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        _components = [NSMutableDictionary new];
    }
    return self;
}

#pragma mark - Lifecycle

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        SCRSearchBuilder *otherSearch = (SCRSearchBuilder *)object;
        return [self.components isEqualToDictionary:otherSearch.components];
    }
    return NO;
}

#pragma mark - Public

- (void)setText:(NSString *)text {
    _text = text;
    [self registerComponent:text forKey:kSCRSearchBuilderTextKey];
}

- (void)setMinimumUploadDate:(NSDate *)minimumUploadDate {
    _minimumUploadDate = minimumUploadDate;
    [self registerComponent:minimumUploadDate forKey:kSCRSearchBuilderMinimumUploadDateKey];
}

- (void)setMaximumUploadDate:(NSDate *)maximumUploadDate {
    _maximumUploadDate = maximumUploadDate;
    [self registerComponent:maximumUploadDate forKey:kSCRSearchBuilderMaximumUploadDateKey];
}

- (void)setMinimumTakenDate:(NSDate *)minimumTakenDate {
    _minimumTakenDate = minimumTakenDate;
    [self registerComponent:minimumTakenDate forKey:kSCRSearchBuilderMinimumTakenDateKey];
}

- (void)setMaximumTakenDate:(NSDate *)maximumTakenDate {
    _maximumTakenDate = maximumTakenDate;
    [self registerComponent:maximumTakenDate forKey:kSCRSearchBuilderMaximumTakenDateKey];
}

- (void)setLocationCoordinate:(CLLocationCoordinate2D)locationCoordinate {
    _locationCoordinate = locationCoordinate;
    [self registerComponent:@(locationCoordinate.latitude) forKey:kSCRSearchBuilderLatitudeKey];
    [self registerComponent:@(locationCoordinate.longitude) forKey:kSCRSearchBuilderLongitudeKey];
}

- (void)setLocationRadius:(NSInteger)locationRadius {
    _locationRadius = locationRadius;
    [self registerComponent:@(locationRadius)
                     forKey:kSCRSearchBuilderRadiusKey];
}

- (void)setLocationRadiusUnit:(SCRSearchRadiusUnit)locationRadiusUnit {
    _locationRadiusUnit = locationRadiusUnit;
    [self registerComponent:[self locationRadiusUnitStringForRadiusUnit:locationRadiusUnit]
                     forKey:kSCRSearchBuilderRadiusUnitsKey];
}

- (NSDictionary *)components {
    return _components;
}

#pragma mark - Internal

- (void)registerComponent:(id)data forKey:(NSString *)key {
    [_components setObject:data forKey:key];
}

- (NSString *)locationRadiusUnitStringForRadiusUnit:(SCRSearchRadiusUnit)radiusUnit {
    switch (self.locationRadiusUnit) {
        case SCRSearchRadiusUnitKilometers:
            return kSCRSearchBuilderRadiusUnitKilometers;
            
        case SCRSearchRadiusUnitMiles:
            return kSCRSearchBuilderRadiusUnitMiles;
            
    }
}

@end
