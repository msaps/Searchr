//
//  SCRCommsContextImpl.m
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRCommsContextImpl.h"

@implementation SCRCommsContextImpl

@synthesize flickrContext = _flickrContext;

#pragma mark - Init

+ (instancetype)commsContextWithConfig:(SCRConfig *)config {
    return [[SCRCommsContextImpl alloc]initWithConfig:config];
}

- (instancetype)initWithConfig:(SCRConfig *)config {
    if (self = [super init]) {
        
        _flickrContext = [[OFFlickrAPIContext alloc]initWithAPIKey:config.flickrApiKey
                                                      sharedSecret:config.flickrApiSecret];
    }
    return self;
}

@end
