//
//  SCRAppDelegate.h
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCREngine.h"
#import "SCRDevice.h"

@interface SCRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong, readonly) SCREngine *engine;
@property (nonatomic, strong, readonly) SCRDevice *currentDevice;

@end

