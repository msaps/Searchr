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

@interface SCRViewControllerBase : UIViewController

@property (nonatomic, strong) SCRViewSizer *viewSizer;

- (SCREngine *)engine;

@end
