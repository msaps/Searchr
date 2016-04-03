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

@property (nonatomic, copy) NSString *description;

@property (nonatomic, strong, readonly) SCRPhotoOwnerModel *ownerModel;
@property (nonatomic, strong, readonly) SCRPhotoDatesModel *datesModel;

@end
