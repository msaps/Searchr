//
//  SCRSearchButton.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRSearchButton.h"
#import "UIColor+SCRColorPalette.h"

@implementation SCRSearchButton

#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageView.image = [self.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.imageView.tintColor = [UIColor scr_flickrBlue];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.bounds.size.width / 2.0f;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.transform = highlighted ? CGAffineTransformMakeScale(0.9f, 0.9f) : CGAffineTransformIdentity;
    }];
}

@end
