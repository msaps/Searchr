//
//  SCRPhotoModelWithInfo.m
//  Searchr
//
//  Created by Merrick Sapsford on 03/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRPhotoModelWithInfo.h"

NSString *const kSCRPhotoModelWithInfoPhotoKey = @"photo";
NSString *const kSCRPhotoModelWithInfoOwnerKey = @"owner";
NSString *const kSCRPhotoModelWithInfoDatesKey = @"dates";
NSString *const kSCRPhotoModelWithInfoDescriptionKey = @"description";
NSString *const kSCRPhotoModelWithInfoTextValueKey = @"_text";

@implementation SCRPhotoModelWithInfo

- (void)evaluateDataDictionary:(NSDictionary *)dictionary {
    NSDictionary *photoDictionary = [dictionary objectForKey:kSCRPhotoModelWithInfoPhotoKey];
    [super evaluateDataDictionary:photoDictionary];
    _ownerModel = [SCRPhotoOwnerModel modelWithDictionary:[photoDictionary objectForKey:kSCRPhotoModelWithInfoOwnerKey]];
    _datesModel = [SCRPhotoDatesModel modelWithDictionary:[photoDictionary objectForKey:kSCRPhotoModelWithInfoDatesKey]];
    
    NSDictionary *descriptionDictionary = [photoDictionary objectForKey:kSCRPhotoModelWithInfoDescriptionKey];
    if (descriptionDictionary) {
        _photoDescription = [descriptionDictionary objectForKey:kSCRPhotoModelWithInfoTextValueKey];
    }
}

@end
