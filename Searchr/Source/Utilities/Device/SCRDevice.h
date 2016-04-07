//
//  SCRDevice.h
//  Searchr
//
//  Created by Merrick Sapsford on 05/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SCRDeviceScreenClassification) {
    SCRDeviceScreenClassificationSmall,
    SCRDeviceScreenClassificationMedium,
    SCRDeviceScreenClassificationLarge,
    SCRDeviceScreenClassificationExtraLarge,
    SCRDeviceScreenClassificationiPad
};

@interface SCRDevice : NSObject

@property (nonatomic, assign, readonly) CGSize screenSize;
@property (nonatomic, assign, readonly) SCRDeviceScreenClassification screenClassification;

@end
