//
//  SCRPhotoOwnerModelWithUrl.h
//  Searchr
//
//  Created by Merrick Sapsford on 03/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCRPhotoOwnerModel.h"
#import "SCRConfig.h"

@interface SCRPhotoOwnerModelWithUrl : NSObject

@property (nonatomic, strong, readonly, nullable) SCRPhotoOwnerModel *photoOwnerModel;
@property (nonatomic, strong, readonly, nullable) NSURL *iconUrl;

+ (nullable instancetype)photoOwnerModelWithModel:(nullable SCRPhotoOwnerModel *)photoOwnerModel
                                           config:(nonnull SCRConfig *)config;

@end
