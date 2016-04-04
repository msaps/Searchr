//
//  UIImageView+SCRFlickrLoading.h
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCRPhotoModelWithUrl.h"

typedef void(^SCRFlickrImageLoadingCompletionBlock)(UIImage *_Nullable image, BOOL fromCache, NSError *_Nullable error);

@interface UIImageView (SCRFlickrLoading)

- (void)scr_setImageWithModel:(nonnull SCRPhotoModelWithUrl *)photoModel;

- (void)scr_setImageWithUrl:(nonnull NSURL *)url;

- (void)scr_loadImageWithUrl:(nonnull NSURL *)url completion:(nullable SCRFlickrImageLoadingCompletionBlock)completion;

- (void)setImage:(nullable UIImage *)image animated:(BOOL)animated;

@end
