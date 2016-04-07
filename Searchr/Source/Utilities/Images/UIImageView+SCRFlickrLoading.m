//
//  UIImageView+SCRFlickrLoading.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "UIImageView+SCRFlickrLoading.h"
#import "UIImageView+AFNetworking.h"
#import <AFNetworking/AFNetworking.h>

@implementation UIImageView (SCRFlickrLoading)

- (void)scr_setImageWithModel:(SCRPhotoModelWithUrl *)photoModel {
    
    NSURL *url = photoModel.photoUrl;
    [self doSetImageWithUrl:url placeholder:nil];
}

- (void)scr_setImageWithUrl:(NSURL *)url {
    [self doSetImageWithUrl:url placeholder:nil];
}

- (void)doSetImageWithUrl:(NSURL *)url placeholder:(UIImage *)placeholder {
    [self scr_loadImageWithUrl:url
                   placeholder:placeholder
                    completion:
     ^(UIImage * _Nullable image, BOOL fromCache, NSError * _Nullable error) {
        if (image) {
            [self setImage:image animated:!fromCache];
        }
    }];
}

- (void)scr_loadImageWithUrl:(NSURL *)url placeholder:(UIImage *)placeholder completion:(SCRFlickrImageLoadingCompletionBlock)completion  {
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    UIImage *cachedImage = [[[UIImageView class]sharedImageCache]cachedImageForRequest:urlRequest];
    
    if (cachedImage) {
        if (completion) {
            completion(cachedImage, YES, nil);
        }
    } else {
        
        // set placeholder temporarily
        static UIImage *_placeholderImage;
        if (!placeholder) {
            if (!_placeholderImage) {
                _placeholderImage = [UIImage new];
            }
            self.image = _placeholderImage;
        }
        
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:urlRequest];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSError *error = nil;
                AFImageResponseSerializer *serializer = [AFImageResponseSerializer serializer];
                UIImage *image = [serializer responseObjectForResponse:operation.response
                                                                  data:responseObject
                                                                 error:&error];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[[UIImageView class]sharedImageCache]cacheImage:image
                                                          forRequest:urlRequest];
                    if (completion) {
                        completion(image, NO, nil);
                    }
                });
            });
            
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            if (completion) {
                completion(nil, NO, error);
            }
        }];
        [queue addOperation:operation];
    }
}

- (void)setImage:(UIImage *)image animated:(BOOL)animated {
    if (animated) {
        [UIView transitionWithView:self
                          duration:0.5f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            [self setImage:image];
                        } completion:nil];
    } else {
        [self setImage:image];
    }
}

@end
