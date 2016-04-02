//
//  SCRPhotoModelWithUrl.h
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCRPhotoModel.h"
#import "SCRConfig.h"

typedef NS_ENUM(NSInteger, SCRPhotoModelPhotoSize) {
    SCRPhotoModelPhotoSizeLarge,
    SCRPhotoModelPhotoSizeSmallSquare,
    SCRPhotoModelPhotoSizeLargeSquare,
    SCRPhotoModelPhotoSizeThumbnail,
    SCRPhotoModelPhotoSizeSmall,
    SCRPhotoModelPhotoSizeMedium,
    SCRPhotoModelPhotoSizeExtraLarge
};

typedef NS_ENUM(NSInteger, SCRPhotoModelPhotoFormat) {
    SCRPhotoModelPhotoFormatJPEG,
    SCRPhotoModelPhotoFormatPNG,
    SCRPhotoModelPhotoFormatGIF
};

@interface SCRPhotoModelWithUrl : NSObject

@property (nonatomic, strong, readonly, nullable) SCRPhotoModel *photoModel;
@property (nonatomic, strong, readonly, nullable) NSURL *photoUrl;
@property (nonatomic, assign) SCRPhotoModelPhotoSize photoSize;
@property (nonatomic, assign) SCRPhotoModelPhotoFormat photoFormat;

+ (nullable instancetype)photoModelWithModel:(nullable SCRPhotoModel *)photoModel
                                      config:(nonnull SCRConfig *)config;

@end
