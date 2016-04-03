//
//  SCRSearchResultCollectionViewCell.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRSearchResultCollectionViewCell.h"
#import "UIImageView+SCRFlickrLoading.h"
#import "NSDate+SCRStringUtilities.h"
#import "UIImageView+SCRFlickrLoading.h"

@interface SCRSearchResultCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *authorImageView;
@property (nonatomic, weak) IBOutlet UILabel *authorLabel;
@property (nonatomic, weak) IBOutlet UIImageView *dateImageView;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *separatorHeight;

@end

@implementation SCRSearchResultCollectionViewCell

#pragma mark - Lifecycle

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
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

#pragma mark - Public

- (void)setPhotoWithUrl:(SCRPhotoModelWithUrl *)photoWithUrl {
    SCRPhotoModel *photo = photoWithUrl.photoModel;
    
    [self.imageView scr_setImageWithModel:photoWithUrl];
    self.titleLabel.text = photo.title;
}

- (void)setPhotoWithInfo:(SCRPhotoModelWithInfo *)photoWithInfo {
    
    self.authorLabel.text = photoWithInfo.ownerModel.username;
    self.dateLabel.text = [photoWithInfo.datesModel.posted scr_shortDateString];
}

- (void)setPhotoOwnerWithUrl:(SCRPhotoOwnerModelWithUrl *)photoOwnerWithUrl {
    [self.authorImageView scr_setImageWithUrl:photoOwnerWithUrl.iconUrl];
}

- (void)startLoadingAnimated:(BOOL)animated {
    
}

- (void)stopLoadingAnimated:(BOOL)animated {
    
}

@end
