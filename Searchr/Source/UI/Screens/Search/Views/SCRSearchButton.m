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
    
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.activityIndicator.color = [UIColor scr_flickrBlue];
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

#pragma mark - Public

- (void)startLoadingAnimated:(BOOL)animated {
    if (animated) {
        self.activityIndicator.alpha = 0.0f;
        [self.activityIndicator startAnimating];
        [UIView animateWithDuration:0.25f animations:^{
            self.activityIndicator.alpha = 1.0f;
            self.imageView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            if (finished) {
                self.imageView.hidden = YES;
                self.imageView.alpha = 1.0f;
            }
        }];
    } else {
        [self.activityIndicator startAnimating];
        self.imageView.hidden = YES;
    }
}

- (void)stopLoadingAnimated:(BOOL)animated {
    if (animated) {
        self.imageView.alpha = 0.0f;
        self.imageView.hidden = NO;
        [UIView animateWithDuration:0.25f animations:^{
            self.activityIndicator.alpha = 0.0f;
            self.imageView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            if (finished) {
                [self.activityIndicator stopAnimating];
                self.activityIndicator.alpha = 1.0f;
            }
        }];
    } else {
        [self.activityIndicator stopAnimating];
        self.imageView.hidden = NO;
    }
}

@end
