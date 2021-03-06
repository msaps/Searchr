//
//  UIColor+SCRColorDetection.h
//  Searchr
//
//  Created by Merrick Sapsford on 04/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SCRReadableForegroundColor) {
    SCRReadableForegroundColorWhite,
    SCRReadableForegroundColorBlack
};

@interface UIColor (SCRColorDetection)

+ (SCRReadableForegroundColor)readableForegroundColorForBackgroundColor:(UIColor *)backgroundColor;

@end
