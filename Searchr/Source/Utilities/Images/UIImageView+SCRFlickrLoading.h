//
//  UIImageView+SCRFlickrLoading.h
//  Searchr
//
//  Created by Merrick Sapsford on 17/05/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SCRFlickrLoadingSuccessBlock)(UIImage *_Nonnull image);
typedef void(^SCRFlickrLoadingFailureBlock)(NSError *_Nonnull error);

@interface UIImageView (SCRFlickrLoading)

- (void)scr_setImageWithUrl:(nonnull NSURL *)url
                    success:(nullable SCRFlickrLoadingSuccessBlock)success
                    failure:(nullable SCRFlickrLoadingFailureBlock)failure;

- (void)scr_setImageWithUrl:(nonnull NSURL *)url
                   animated:(BOOL)animated
                clearOnLoad:(BOOL)clearOnLoad
                    success:(nullable SCRFlickrLoadingSuccessBlock)success
                    failure:(nullable SCRFlickrLoadingFailureBlock)failure;

@end
