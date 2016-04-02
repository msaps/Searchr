//
//  SCRConfig.h
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCRConfig : NSObject

@property (nonatomic, copy, readonly) NSString *flickrApiKey;
@property (nonatomic, copy, readonly) NSString *flickrApiSecret;

+ (instancetype)configFromBundle:(NSBundle *)bundle;

@end
