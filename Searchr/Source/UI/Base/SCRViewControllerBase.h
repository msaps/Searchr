//
//  SCRViewControllerBase.h
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCREngine.h"
#import "UIImageView+SCRFlickrLoading.h"
#import "UIColor+SCRColorPalette.h"
#import "SCRViewSizer.h"
#import "UIImage+SCRColorDetection.h"
#import "SCRDevice.h"

@interface SCRViewControllerBase : UIViewController

@property (nonatomic, strong) SCRViewSizer *viewSizer;
@property (nonatomic, assign) UIReadableForegroundColor requiredForegroundColor;

- (void)updateViewConstraints:(UIView *)view forDevice:(SCRDevice *)device;

- (SCREngine *)engine;
- (SCRDevice *)currentDevice;

@end
