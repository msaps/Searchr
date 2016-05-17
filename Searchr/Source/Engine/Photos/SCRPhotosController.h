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
#import "SCRSearch.h"
#import "SCRSearchBuilder.h"
#import "SCRFlickrAPI.h"

@protocol SCRPhotosController;

@protocol SCRPhotosControllerDelegate <NSObject>
@optional

/**
 The photos controller has loaded a new set of interesting photos.
 
 @param photosController
 The photos controller.
 
 @param interestingPhotos
 The interesting photos list.
 */
- (void)photosController:(nonnull id<SCRPhotosController>)photosController
didLoadInterestingPhotos:(nonnull SCRPagedList<SCRPhotoModel *> *)interestingPhotos;
/**
 The photos controller has failed to load a new set of interesting photos.
 
 @param photosController
 The photos controller.
 
 @param error
 The error that caused the failure.
 */
- (void)photosController:(nonnull id<SCRPhotosController>)photosController
didFailToLoadInterestingPhotos:(nonnull NSError *)error;

/**
 The photos controller has performed a successful search.
 
 @param photosController
 The photos controller.
 
 @param search
 The search.
 
 @param searchResults
 The results from the search.
 */
- (void)photosController:(nonnull id<SCRPhotosController>)photosController
        didPerformSearch:(nonnull SCRSearch *)search
             withResults:(nonnull SCRPagedList<SCRPhotoModel *> *)searchResults;
/**
 The photos controller has failed to perform a search
 
 @param photosController
 The photos controller.
 
 @param search
 The search.
 
 @param error
 The error that caused the failure.
 */
- (void)photosController:(nonnull id<SCRPhotosController>)photosController
  didFailToPerformSearch:(nonnull SCRSearch *)search
               withError:(nonnull NSError *)error;

/**
 The photos controller has successfully loaded information for a photo.
 
 @param photosController
 The photos controller.
 
 @param photo
 The loaded photo with information.
 */
- (void)photosController:(nonnull id<SCRPhotosController>)photosController
        didLoadPhotoInfo:(nonnull SCRPhotoModelWithInfo *)photo;
/**
 The photos controller has failed load information for a photo.
 
 @param photosController
 The photos controller.
 
 @param photo
 The photo to get information from.
 
 @param error
 The error that caused the failure.
 */
- (void)photosController:(nonnull id<SCRPhotosController>)photosController
didFailToLoadPhotoInfoForPhoto:(nonnull SCRPhotoModel *)photo
               withError:(nonnull NSError *)error;

@end

@protocol SCRPhotosController <SCRControllerBase>

/**
 Interesting photos.
 */
@property (nonatomic, strong, readonly, nullable) SCRPagedList<SCRPhotoModel *> *interestingPhotos;
/**
 The current search.
 */
@property (nonatomic, strong, readonly, nullable) SCRSearch *currentSearch;

/**
 Load the next interesting photos page from Flickr.
 */
- (void)getInterestingPhotos;

/**
 Perform a search for photos on Flickr.
 */
- (void)getSearchResultsForSearch:(nonnull SCRSearch *)search;

/**
 Load information for a photo from Flickr.
 */
- (nullable SCRPhotoModelWithInfo *)getPhotoInfoForPhoto:(nonnull SCRPhotoModel *)photo;

@end
