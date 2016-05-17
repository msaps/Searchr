//
//  UIImageView+SCRFlickrLoading.m
//  Searchr
//
//  Created by Merrick Sapsford on 17/05/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "UIImageView+SCRFlickrLoading.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation UIImageView (SCRFlickrLoading)

- (void)scr_setImageWithUrl:(NSURL *)url
                    success:(SCRFlickrLoadingSuccessBlock)success
                    failure:(SCRFlickrLoadingFailureBlock)failure {
    [self scr_setImageWithUrl:url animated:YES clearOnLoad:YES success:success failure:failure];
}

- (void)scr_setImageWithUrl:(NSURL *)url
                   animated:(BOOL)animated
                clearOnLoad:(BOOL)clearOnLoad
                    success:(SCRFlickrLoadingSuccessBlock)success
                    failure:(SCRFlickrLoadingFailureBlock)failure {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __weak UIImageView *weakSelf = self;
    
    static UIImage *transparentPlaceholderImage;
    if (!transparentPlaceholderImage) {
        transparentPlaceholderImage = [UIImage new];
    }
    
    [self setImageWithURLRequest:request
                placeholderImage:(clearOnLoad ? transparentPlaceholderImage : nil)
                         success:
     ^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
         
         if (success) {
             success(image);
         }
         
         if (response != nil && animated) { // animate if loaded
             [UIView transitionWithView:weakSelf
                               duration:0.2f
                                options:UIViewAnimationOptionTransitionCrossDissolve
                             animations:
              ^{
                  weakSelf.image = image;
              } completion:nil];
         } else {
             weakSelf.image = image;
         }
    }
                         failure:
     ^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
         if (failure) {
             failure(error);
         }
    }];
}

@end
