//
//  SCRConfig.h
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCRConfig : NSObject

/**
 Searchr Flickr API key.
 */
@property (nonatomic, copy, readonly, nonnull) NSString *flickrApiKey;
/**
 Searchr Flickr API Secret.
 */
@property (nonatomic, copy, readonly, nonnull) NSString *flickrApiSecret;
/**
 Flickr image url format.
 */
@property (nonatomic, copy, readonly, nonnull) NSString *flickrImageUrlFormat;

+ (nullable instancetype)configFromBundle:(nonnull NSBundle *)bundle;

@end
