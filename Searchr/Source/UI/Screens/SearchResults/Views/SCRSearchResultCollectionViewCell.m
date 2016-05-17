//
//  SCRSearchResultCollectionViewCell.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRSearchResultCollectionViewCell.h"
#import "NSDate+SCRStringUtilities.h"
#import "UIImageView+SCRFlickrLoading.h"

@interface SCRSearchResultCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIView *authorContainerView;
@property (nonatomic, weak) IBOutlet UIImageView *authorImageView;
@property (nonatomic, weak) IBOutlet UILabel *authorLabel;

@property (nonatomic, weak) IBOutlet UIView *dateContainerView;
@property (nonatomic, weak) IBOutlet UIImageView *dateImageView;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *separatorHeight;

@end

@implementation SCRSearchResultCollectionViewCell

#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.separatorHeight.constant = 0.5f;
    
    self.authorImageView.image = [self.authorImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.dateImageView.image = [self.dateImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

#pragma mark - Public

- (void)setPhotoWithUrl:(SCRPhotoModelWithUrl *)photoWithUrl {
    SCRPhotoModel *photo = photoWithUrl.photoModel;
    
    self.titleLabel.text = photo.title;
    [self.imageView scr_setImageWithUrl:photoWithUrl.photoUrl
                                success:nil failure:nil];
}

- (void)setPhotoWithInfo:(SCRPhotoModelWithInfo *)photoWithInfo {
    [self stopLoadingAnimated:YES];
    
    self.authorLabel.text = photoWithInfo.ownerModel.username;
    self.dateLabel.text = [photoWithInfo.datesModel.posted scr_shortDateString];
}

- (void)setPhotoOwnerWithUrl:(SCRPhotoOwnerModelWithUrl *)photoOwnerWithUrl {
    [self.authorImageView scr_setImageWithUrl:photoOwnerWithUrl.iconUrl
                                      success:nil failure:nil];
}

- (void)startLoadingAnimated:(BOOL)animated {
    [self.layer removeAllAnimations];
    if (animated) {
        self.activityIndicator.alpha = 0.0f;
        [self.activityIndicator startAnimating];
        [UIView animateWithDuration:0.25f animations:^{
            self.activityIndicator.alpha = 1.0f;
            self.authorContainerView.alpha = 0.0f;
            self.dateContainerView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            if (finished) {
                self.authorContainerView.hidden = YES;
                self.dateContainerView.hidden = YES;
                self.authorContainerView.alpha = 1.0f;
                self.dateContainerView.alpha = 1.0f;
            }
        }];
    } else {
        [self.activityIndicator startAnimating];
        self.authorContainerView.hidden = YES;
        self.dateContainerView.hidden = YES;
    }
}

- (void)stopLoadingAnimated:(BOOL)animated {
    [self.layer removeAllAnimations];
    if (animated) {
        self.authorContainerView.alpha = 0.0f;
        self.dateContainerView.alpha = 0.0f;
        self.authorContainerView.hidden = NO;
        self.dateContainerView.hidden = NO;
        [UIView animateWithDuration:0.25f animations:^{
            self.activityIndicator.alpha = 0.0f;
            self.authorContainerView.alpha = 1.0f;
            self.dateContainerView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            if (finished) {
                [self.activityIndicator stopAnimating];
                self.activityIndicator.alpha = 1.0f;
            }
        }];
    } else {
        [self.activityIndicator stopAnimating];
        self.authorContainerView.hidden = NO;
        self.dateContainerView.hidden = NO;
    }
}

@end
