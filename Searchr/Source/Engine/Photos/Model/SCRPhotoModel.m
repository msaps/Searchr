//
//  SCRPhotoModel.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRPhotoModel.h"

NSString *const kSCRPhotoModelFarmKey = @"farm";
NSString *const kSCRPhotoModelIdKey = @"id";
NSString *const kSCRPhotoModelIsFamilyKey = @"isfamily";
NSString *const kSCRPhotoModelIsFriendKey = @"isfriend";
NSString *const kSCRPhotoModelIsPublicKey = @"ispublic";
NSString *const kSCRPhotoModelOwnerKey = @"owner";
NSString *const kSCRPhotoModelSecretKey = @"secret";
NSString *const kSCRPhotoModelServerKey = @"server";
NSString *const kSCRPhotoModelTitleKey = @"title";

@implementation SCRPhotoModel

- (void)evaluateDataDictionary:(NSDictionary *)dictionary {
    self.farm = [dictionary[kSCRPhotoModelFarmKey]integerValue];
    self.identifier = dictionary[kSCRPhotoModelIdKey];
    self.isFamily = [dictionary[kSCRPhotoModelIsFamilyKey]boolValue];
    self.isFriend = [dictionary[kSCRPhotoModelIsFriendKey]boolValue];
    self.isPublic = [dictionary[kSCRPhotoModelIsPublicKey]boolValue];
    self.owner = dictionary[kSCRPhotoModelOwnerKey];
    self.secret = dictionary[kSCRPhotoModelSecretKey];
    self.server = [dictionary[kSCRPhotoModelServerKey]integerValue];
    self.title = dictionary[kSCRPhotoModelTitleKey];
}

@end
