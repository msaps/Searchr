
//
//  SCRPhotoOwnerModel.m
//  Searchr
//
//  Created by Merrick Sapsford on 03/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRPhotoOwnerModel.h"

NSString *const kSCRPhotoOwnerModelIconFarmKey = @"iconfarm";
NSString *const kSCRPhotoOwnerModelIconServerKey = @"iconserver";
NSString *const kSCRPhotoOwnerModelIdKey = @"nsid";
NSString *const kSCRPhotoOwnerModelUserNameKey = @"username";
NSString *const kSCRPhotoOwnerModelRealNameKey = @"realname";
NSString *const kSCRPhotoOwnerModelLocationKey = @"location";

@implementation SCRPhotoOwnerModel

- (void)evaluateDataDictionary:(NSDictionary *)dictionary {
    
    _iconFarm = [[dictionary objectForKey:kSCRPhotoOwnerModelIconFarmKey]integerValue];
    _iconServer = [[dictionary objectForKey:kSCRPhotoOwnerModelIconServerKey]integerValue];
    
    _identifier = [dictionary objectForKey:kSCRPhotoOwnerModelIdKey];
    _username = [dictionary objectForKey:kSCRPhotoOwnerModelUserNameKey];
    _realName = [dictionary objectForKey:kSCRPhotoOwnerModelRealNameKey];
    _location = [dictionary objectForKey:kSCRPhotoOwnerModelLocationKey];
}

@end
