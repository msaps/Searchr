//
//  SCRSearchResultCollectionViewCell.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRSearchResultCollectionViewCell.h"

@interface SCRSearchResultCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *authorImageView;
@property (nonatomic, weak) IBOutlet UIImageView *dateImageView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *separatorHeight;

@end

@implementation SCRSearchResultCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.separatorHeight.constant = 0.5f;
    
    self.authorImageView.image = [self.authorImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.dateImageView.image = [self.dateImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    // add shadow
    self.layer.masksToBounds = NO;
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    self.layer.shadowOpacity = 0.25f;
    self.layer.shadowRadius = 3.0f;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shouldRasterize = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

@end
