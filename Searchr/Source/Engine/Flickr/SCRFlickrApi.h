//
//  SCRPhotosApi.h
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objectiveflickr/ObjectiveFlickr.h>
#import "SCRRequest.h"
#import "SCRPhotoListModel.h"
#import "SCRPhotoModelWithInfo.h"

typedef void(^SCRFlickrApiFailureBlock)(NSError * _Nullable error);
typedef void(^SCRFlickrApiPopularPhotoSuccessBlock)(SCRPhotoListModel * _Nullable popularPhotos);
typedef void(^SCRFlickrApiSearchResultsSuccessBlock)(SCRPhotoListModel * _Nullable searchResults);
typedef void(^SCRFlickrApiPhotoInfoSuccessBlock)(SCRPhotoModelWithInfo * _Nullable photoWithInfo);

@interface SCRFlickrApi : NSObject

- (nonnull instancetype)initWithFlickrContext:(nonnull OFFlickrAPIContext *)flickrContext;

- (nullable SCRRequest *)getInterestingPhotosWithPage:(NSInteger)page
                                             pageSize:(NSInteger)pageSize
                                              success:(nullable SCRFlickrApiPopularPhotoSuccessBlock)success
                                              failure:(nullable SCRFlickrApiFailureBlock)failure;

- (nullable SCRRequest *)getSearchResultsForParameters:(nonnull NSDictionary *)parameters
                                                  page:(NSInteger)page
                                              pageSize:(NSInteger)pageSize
                                               success:(nullable SCRFlickrApiSearchResultsSuccessBlock)success
                                               failure:(nullable SCRFlickrApiFailureBlock)failure;

- (nullable SCRRequest *)getPhotoInfoForPhotoWithId:(nonnull NSString *)photoId
                                        photoSecret:(nonnull NSString *)photoSecret
                                            success:(nullable SCRFlickrApiPhotoInfoSuccessBlock)success
                                            failure:(nullable SCRFlickrApiFailureBlock)failure;

@end
