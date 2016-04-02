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
@synthesize flickrApi = _flickrApi;

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

#pragma mark - Public

- (SCRFlickrApi *)photosApi {
    if (!_flickrApi) {
        _flickrApi = [[SCRFlickrApi alloc]initWithFlickrContext:self.flickrContext];
    }
    return _flickrApi;
}

@end
