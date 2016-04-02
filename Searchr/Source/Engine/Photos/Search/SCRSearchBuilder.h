//
//  SCRSearchBuilder.h
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSInteger, SCRSearchRadiusUnit) {
    SCRSearchRadiusUnitKilometers,
    SCRSearchRadiusUnitMiles
};

@interface SCRSearchBuilder : NSObject

@property (nonatomic, copy, nullable) NSString *text;

@property (nonatomic, strong, nullable) NSDate *minimumUploadDate;
@property (nonatomic, strong, nullable) NSDate *maximumUploadDate;

@property (nonatomic, strong, nullable) NSDate *minimumTakenDate;
@property (nonatomic, strong, nullable) NSDate *maximumTakenDate;

@property (nonatomic, assign) CLLocationCoordinate2D locationCoordinate;
@property (nonatomic, assign) NSInteger locationRadius;
@property (nonatomic, assign) SCRSearchRadiusUnit locationRadiusUnit;

@property (nonatomic, strong, readonly, nonnull) NSDictionary *components;

@end
