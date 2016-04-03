//
//  SCRSearchResultCollectionViewCell.h
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCRPhotoModelWithUrl.h"
#import "SCRPhotoModelWithInfo.h"

IB_DESIGNABLE
@interface SCRSearchResultCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

- (void)setPhotoWithUrl:(SCRPhotoModelWithUrl *)photoWithUrl;
- (void)setPhotoWithInfo:(SCRPhotoModelWithInfo *)photoWithInfo;

@end
