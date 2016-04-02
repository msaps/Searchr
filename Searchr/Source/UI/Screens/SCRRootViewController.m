//
//  SCRRootViewController.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRRootViewController.h"
#import "SCRPhotoModelWithUrl.h"
#import "UIImageView+AFNetworking.h"
#import <AFNetworking/AFNetworking.h>

@interface SCRRootViewController () <SCRPhotosControllerDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation SCRRootViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.engine.photosController addListener:self];    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.engine.photosController getInterestingPhotos];
}

#pragma mark - Internal

- (SCRPhotoModel *)randomPhotoModelFromList:(SCRPagedList<SCRPhotoModel *> *)photoModel {
    NSInteger index = arc4random_uniform((int)photoModel.data.count - 1);
    return photoModel.data[index];
}

#pragma mark - SCRPhotosControllerDelegate

- (void)photosController:(id<SCRPhotosController>)photosController didLoadInterestingPhotos:(SCRPagedList<SCRPhotoModel *> *)interestingPhotos {
    SCRPhotoModel *photo = [self randomPhotoModelFromList:interestingPhotos];
    SCRPhotoModelWithUrl *photoWithUrl = [SCRPhotoModelWithUrl photoModelWithModel:photo
                                                                            config:self.engine.config];
    [self.imageView scr_setImageWithModel:photoWithUrl];
}

- (void)photosController:(id<SCRPhotosController>)photosController didFailToLoadInterestingPhotos:(NSError *)error {
    
}

@end
