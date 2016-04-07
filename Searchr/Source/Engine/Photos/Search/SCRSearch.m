//
//  SCRSearch.m
//  Searchr
//
//  Created by Merrick Sapsford on 05/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRSearch.h"
#import "SCRSearchPrivate.h"

NSString *const kSCRSearchTextKey = @"text";
NSString *const kSCRSearchMinimumUploadDateKey = @"min_upload_date";
NSString *const kSCRSearchMaximumUploadDateKey = @"max_upload_date";
NSString *const kSCRSearchMinimumTakenDateKey = @"min_taken_date";
NSString *const kSCRSearchMaximumTakenDateKey = @"max_taken_date";
NSString *const kSCRSearchLatitudeKey = @"lat";
NSString *const kSCRSearchLongitudeKey = @"lon";
NSString *const kSCRSearchRadiusKey = @"radius";
NSString *const kSCRSearchRadiusUnitsKey = @"radius_units";

NSString *const kSCRSearchRadiusUnitKilometers = @"km";
NSString *const kSCRSearchRadiusUnitMiles = @"mi";

@implementation SCRSearch

@synthesize failed = _failed;
@synthesize results = _results;

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
        SCRSearch *otherSearch = (SCRSearch *)object;
        return [self.components isEqualToDictionary:otherSearch.components];
    }
    return NO;
}

- (id)copyWithZone:(NSZone *)zone {
    SCRSearch *search = [SCRSearch new];
    if (search) {
        [search setText:self.text];
        [search setMinimumUploadDate:self.minimumUploadDate];
        [search setMaximumUploadDate:self.maximumUploadDate];
        [search setMinimumTakenDate:self.minimumTakenDate];
        [search setMaximumTakenDate:self.maximumTakenDate];
        [search setLocationCoordinate:self.locationCoordinate];
        [search setLocationRadius:self.locationRadius];
        [search setLocationRadiusUnit:self.locationRadiusUnit];
    }
    return search;
}

#pragma mark - Public

- (SCRPagedList<SCRPhotoModel *> *)results {
    if (!_results) {
        _results = [SCRPagedList new];
    }
    return _results;
}

- (void)setText:(NSString *)text {
    _text = text;
    if (text.length > 0) {
        [self registerComponent:text forKey:kSCRSearchTextKey];
    } else {
        [self unregisterComponentForKey:kSCRSearchTextKey];
    }
}

- (void)setMinimumUploadDate:(NSDate *)minimumUploadDate {
    _minimumUploadDate = minimumUploadDate;
    if (minimumUploadDate) {
        [self registerComponent:minimumUploadDate forKey:kSCRSearchMinimumUploadDateKey];
    } else {
        [self unregisterComponentForKey:kSCRSearchMinimumUploadDateKey];
    }
}

- (void)setMaximumUploadDate:(NSDate *)maximumUploadDate {
    _maximumUploadDate = maximumUploadDate;
    if (maximumUploadDate) {
        [self registerComponent:maximumUploadDate forKey:kSCRSearchMaximumUploadDateKey];
    } else {
        [self unregisterComponentForKey:kSCRSearchMaximumUploadDateKey];
    }
}

- (void)setMinimumTakenDate:(NSDate *)minimumTakenDate {
    _minimumTakenDate = minimumTakenDate;
    if (minimumTakenDate) {
        [self registerComponent:minimumTakenDate forKey:kSCRSearchMinimumTakenDateKey];
    } else {
        [self unregisterComponentForKey:kSCRSearchMinimumTakenDateKey];
    }
}

- (void)setMaximumTakenDate:(NSDate *)maximumTakenDate {
    _maximumTakenDate = maximumTakenDate;
    if (maximumTakenDate) {
        [self registerComponent:maximumTakenDate forKey:kSCRSearchMaximumTakenDateKey];
    } else {
        [self unregisterComponentForKey:kSCRSearchMaximumTakenDateKey];
    }
}

- (void)setLocationCoordinate:(CLLocationCoordinate2D)locationCoordinate {
    if (CLLocationCoordinate2DIsValid(locationCoordinate)) {
        if (locationCoordinate.latitude != _locationCoordinate.latitude &&
            locationCoordinate.longitude != _locationCoordinate.longitude) {
            _locationCoordinate = locationCoordinate;
            [self registerComponent:@(locationCoordinate.latitude) forKey:kSCRSearchLatitudeKey];
            [self registerComponent:@(locationCoordinate.longitude) forKey:kSCRSearchLongitudeKey];
        }
    } else {
        [self unregisterComponentForKey:kSCRSearchLatitudeKey];
        [self unregisterComponentForKey:kSCRSearchLongitudeKey];
    }
}

- (void)setLocationRadius:(NSInteger)locationRadius {
    if (locationRadius > 0) {
        if (_locationRadius != locationRadius) {
            _locationRadius = locationRadius;
            [self registerComponent:@(locationRadius)
                             forKey:kSCRSearchRadiusKey];
        }
    } else {
        [self unregisterComponentForKey:kSCRSearchRadiusKey];
    }
}

- (void)setLocationRadiusUnit:(SCRSearchRadiusUnit)locationRadiusUnit {
    if (locationRadiusUnit != SCRSearchRadiusUnitNone) {
        if (_locationRadiusUnit != locationRadiusUnit) {
            _locationRadiusUnit = locationRadiusUnit;
            [self registerComponent:[self locationRadiusUnitStringForRadiusUnit:locationRadiusUnit]
                             forKey:kSCRSearchRadiusUnitsKey];
        }
    } else {
        [self unregisterComponentForKey:kSCRSearchRadiusUnitsKey];
    }
}

- (NSDictionary *)components {
    return _components;
}

#pragma mark - Internal

- (void)registerComponent:(id)data forKey:(NSString *)key {
    if (data && key) {
        [_components setObject:data forKey:key];
    }
}

- (void)unregisterComponentForKey:(NSString *)key {
    if (key) {
        [_components removeObjectForKey:key];
    }
}

- (NSString *)locationRadiusUnitStringForRadiusUnit:(SCRSearchRadiusUnit)radiusUnit {
    switch (self.locationRadiusUnit) {
        case SCRSearchRadiusUnitKilometers:
            return kSCRSearchRadiusUnitKilometers;
            
        case SCRSearchRadiusUnitMiles:
            return kSCRSearchRadiusUnitMiles;
            
            default:
            return nil;
    }
}

#pragma mark - Private

- (void)setFailed:(BOOL)failed {
    if (self.results.data.count == 0) { // only set failed if we have no results
        _failed = failed;
    }
}

@end
