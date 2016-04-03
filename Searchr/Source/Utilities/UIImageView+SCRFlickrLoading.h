//
//  UIImageView+SCRFlickrLoading.h
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCRPhotoModelWithUrl.h"

@interface UIImageView (SCRFlickrLoading)

- (void)scr_setImageWithModel:(nonnull SCRPhotoModelWithUrl *)photoModel;

- (void)scr_setImageWithUrl:(nonnull NSURL *)url;

@end
