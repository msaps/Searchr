//
//  SCRConfig.m
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRConfig.h"

NSString *const kSCRConfigKey = @"SCRConfig";

NSString *const kSCRConfigFlickrApiKey = @"flickrApiKey";
NSString *const kSCRConfigFlickrApiSecretKey = @"flickrApiSecret";
NSString *const kSCRConfigFlickrImageUrlFormatKey = @"flickrImageUrlFormat";

@implementation SCRConfig

#pragma mark - Init

+ (instancetype)configFromBundle:(NSBundle *)bundle {
    return [[SCRConfig alloc]initWithBundle:bundle];
}

- (instancetype)initWithBundle:(NSBundle *)bundle {
    if (self = [super init]) {
        NSDictionary *configDictionary = [bundle objectForInfoDictionaryKey:kSCRConfigKey];
        
        _flickrApiKey = configDictionary[kSCRConfigFlickrApiKey];
        _flickrApiSecret = configDictionary[kSCRConfigFlickrApiSecretKey];
        _flickrImageUrlFormat = configDictionary[kSCRConfigFlickrImageUrlFormatKey];
    }
    return self;
}

@end
