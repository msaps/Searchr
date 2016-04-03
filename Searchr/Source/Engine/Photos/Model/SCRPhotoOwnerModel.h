//
//  SCRPhotoOwnerModel.h
//  Searchr
//
//  Created by Merrick Sapsford on 03/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRModel.h"

@interface SCRPhotoOwnerModel : SCRModel

@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *realName;

@property (nonatomic, assign) NSInteger iconFarm;
@property (nonatomic, assign) NSInteger iconServer;

@end
