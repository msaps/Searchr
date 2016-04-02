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
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    UIImage *cachedImage = [[[UIImageView class]sharedImageCache]cachedImageForRequest:urlRequest];
    
    if (cachedImage) {
        [self doSetImage:cachedImage animated:NO];
    } else {
        
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
                    [self doSetImage:image animated:YES];
                });
            });
            
        } failure:nil];
        [queue addOperation:operation];
    }
}

- (void)doSetImage:(UIImage *)image animated:(BOOL)animated {
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
