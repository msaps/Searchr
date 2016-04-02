//
//  SCRPhotosController.h
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRControllerBase.h"
#import "SCRPhotoModel.h"
#import "SCRPagedList.h"

@protocol SCRPhotosController;

@protocol SCRPhotosControllerDelegate <NSObject>

/**
 The photos controller has loaded a new set of interesting photos
 
 @param photosController
 The photos controller.
 
 @param interestingPhotos
 The interesting photos list.
 */
- (void)photosController:(nonnull id<SCRPhotosController>)photosController
didLoadInterestingPhotos:(nonnull SCRPagedList<SCRPhotoModel *> *)interestingPhotos;
/**
 The photos controller has failde to load a new set of interesting photos
 
 @param photosController
 The photos controller.
 
 @param error
 The error that caused the failure.
 */
- (void)photosController:(nonnull id<SCRPhotosController>)photosController
didFailToLoadInterestingPhotos:(nonnull NSError *)error;

@end

@protocol SCRPhotosController <SCRControllerBase>

/**
 Interesting photos.
 */
@property (nonatomic, strong, readonly, nullable) SCRPagedList<SCRPhotoModel *> *interestingPhotos;

/**
 Load the next interesting photos page from Flickr.
 */
- (void)getInterestingPhotos;

@end
