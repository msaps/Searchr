//
//  SCRSearch.h
//  Searchr
//
//  Created by Merrick Sapsford on 05/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SCRPagedList.h"
#import "SCRPhotoModel.h"

typedef NS_ENUM(NSInteger, SCRSearchRadiusUnit) {
    SCRSearchRadiusUnitKilometers,
    SCRSearchRadiusUnitMiles
};

@interface SCRSearch : NSObject <NSCopying>

/**
 The image related text to search for.
 */
@property (nonatomic, copy, nullable, readonly) NSString *text;
/**
 The minimum upload date for photos in the search.
 */
@property (nonatomic, strong, nullable, readonly) NSDate *minimumUploadDate;
/**
 The maximum upload date for photos in the search.
 */
@property (nonatomic, strong, nullable, readonly) NSDate *maximumUploadDate;
/**
 The minimum taken date for photos in the search.
 */
@property (nonatomic, strong, nullable, readonly) NSDate *minimumTakenDate;
/**
 The maximum taken date for photos in the search.
 */
@property (nonatomic, strong, nullable, readonly) NSDate *maximumTakenDate;
/**
 The coordinate to use for location filtering the search.
 */
@property (nonatomic, assign, readonly) CLLocationCoordinate2D locationCoordinate;
/**
 The location radius for location filtering the search.
 */
@property (nonatomic, assign, readonly) NSInteger locationRadius;
/**
 The unit to use for location filtering the search.
 */
@property (nonatomic, assign, readonly) SCRSearchRadiusUnit locationRadiusUnit;

/**
 The search did fail to load.
 */
@property (nonatomic, assign, readonly, getter=didFailLoad) BOOL failed;

/**
 The results loaded for the search.
 */
@property (nonatomic, strong, nullable, readonly) SCRPagedList<SCRPhotoModel *> *results;

@end
