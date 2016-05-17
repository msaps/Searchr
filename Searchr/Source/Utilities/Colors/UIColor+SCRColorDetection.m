//
//  UIColor+;
//  Searchr
//
//  Created by Merrick Sapsford on 04/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "UIColor+SCRColorDetection.h"

@implementation UIColor (SCRColorDetection)

/**
 Inspired by the answer http://stackoverflow.com/questions/2509443/check-if-uicolor-is-dark-or-bright
 on Remy Vanherweghem
 */
+ (SCRReadableForegroundColor)readableForegroundColorForBackgroundColor:(UIColor *)backgroundColor {
    size_t componentCount = CGColorGetNumberOfComponents(backgroundColor.CGColor);
    const CGFloat *componentColors = CGColorGetComponents(backgroundColor.CGColor);
    
    CGFloat darknessScore = 0.0f;
    if (componentCount == 2) {
        darknessScore = (((componentColors[0] * 255.0f) * 299.0f) + ((componentColors[0] * 255.0f) * 587.0f) + ((componentColors[0] * 255.0f) * 114.0f)) / 1000.0f;
    } else if (componentCount == 4) {
        darknessScore = (((componentColors[0] * 255.0f) * 299.0f) + ((componentColors[1] * 255.0f) * 587.0f) + ((componentColors[2] * 255.0f) * 114.0f)) / 1000.0f;
    }

    if (darknessScore >= 125.0f) {
        return SCRReadableForegroundColorBlack;
    }
    return SCRReadableForegroundColorWhite;
}

@end
