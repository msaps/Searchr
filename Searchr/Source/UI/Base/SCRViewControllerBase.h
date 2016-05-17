//
//  SCRViewControllerBase.h
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCREngine.h"
#import "UIColor+SCRColorPalette.h"
#import "SCRViewSizer.h"
#import "UIImage+SCRColorDetection.h"
#import "SCRDevice.h"
#import "SCRKeyboardDelegate.h"

@interface SCRViewControllerBase : UIViewController <SCRKeyboardDelegate>

/**
 The object that can provide delegation to the view controller for keyboard updates
 */
@property (nonatomic, strong) SCRKeyboardDelegate *keyboardDelegate;
/**
 The object that can provide autosizing calculations for a view.
 */
@property (nonatomic, strong) SCRViewSizer *viewSizer;
@property (nonatomic, assign) UIReadableForegroundColor requiredForegroundColor;

/**
 Update any constraints within the view controller that need adjusting for particular screen sizes.
 
 @param view
 The view controller's view.
 
 @param device
 The current device.
 */
- (void)updateViewConstraints:(UIView *)view forDevice:(SCRDevice *)device;

/**
 The engine holding all the data controllers.
 */
- (SCREngine *)engine;
/**
 The current device.
 */
- (SCRDevice *)currentDevice;

@end
