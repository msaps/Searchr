//
//  UIImage+SCRColorDetection.h
//  Searchr
//
//  Created by Merrick Sapsford on 04/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+SCRColorDetection.h"

@interface UIImage (SCRColorDetection)

- (UIColor *)scr_averageColor;

@end
