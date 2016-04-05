//
//  SCRPhotoModelWithInfo.h
//  Searchr
//
//  Created by Merrick Sapsford on 03/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRPhotoModel.h"
#import "SCRPhotoOwnerModel.h"
#import "SCRPhotoDatesModel.h"

@interface SCRPhotoModelWithInfo : SCRPhotoModel

@property (nonatomic, copy, nullable) NSString *description;

@property (nonatomic, strong, readonly, nullable) SCRPhotoOwnerModel *ownerModel;
@property (nonatomic, strong, readonly, nullable) SCRPhotoDatesModel *datesModel;

@end
