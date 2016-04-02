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

typedef void(^SCRPhotosApiFailureBlock)(NSError * _Nullable error);
typedef void(^SCRPhotosApiPopularPhotoSuccessBlock)(SCRPhotoListModel * _Nullable popularPhotos);

@interface SCRPhotosApi : NSObject

- (nonnull instancetype)initWithFlickrContext:(nonnull OFFlickrAPIContext *)flickrContext;

- (nullable SCRRequest *)getInterestingPhotosWithPage:(NSInteger)page
                                             pageSize:(NSInteger)pageSize
                                              success:(nullable SCRPhotosApiPopularPhotoSuccessBlock)success
                                              failure:(nullable SCRPhotosApiFailureBlock)failure;

@end
