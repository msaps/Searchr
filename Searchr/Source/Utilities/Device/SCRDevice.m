//
//  SCRDevice.m
//  Searchr
//
//  Created by Merrick Sapsford on 05/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRDevice.h"

@implementation SCRDevice

#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        [self configureDevice];
    }
    return self;
}

#pragma mark - Public

- (CGSize)screenSize {
    return [UIScreen mainScreen].bounds.size;
}

#pragma mark - Internal

- (void)configureDevice {
    [self classifyScreen];
}

- (void)classifyScreen {
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        if (self.screenSize.height <= 480) {
            _screenClassification = SCRDeviceScreenClassificationSmall;
        } else if (self.screenSize.height > 480 && self.screenSize.height < 667) {
            _screenClassification = SCRDeviceScreenClassificationMedium;
        } else if (self.screenSize.height >= 667 && self.screenSize.height < 736) {
            _screenClassification = SCRDeviceScreenClassificationLarge;
        } else if (self.screenSize.height >= 736) {
            _screenClassification = SCRDeviceScreenClassificationExtraLarge;
        }
    } else {
        _screenClassification = SCRDeviceScreenClassificationiPad;
    }
}

@end
