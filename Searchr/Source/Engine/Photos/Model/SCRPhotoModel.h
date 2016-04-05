//
//  SCRPhotoModel.h
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRModel.h"

@interface SCRPhotoModel : SCRModel

@property (nonatomic, copy, nullable) NSString *identifier;
@property (nonatomic, copy, nullable) NSString *owner;
@property (nonatomic, copy, nullable) NSString *secret;
@property (nonatomic, copy, nullable) NSString *title;

@property (nonatomic, assign) NSInteger farm;
@property (nonatomic, assign) NSInteger server;

@property (nonatomic, assign) BOOL isFamily;
@property (nonatomic, assign) BOOL isFriend;
@property (nonatomic, assign) BOOL isPublic;

@end
