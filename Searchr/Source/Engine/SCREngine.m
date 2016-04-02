//
//  SCREngine.m
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCREngine.h"

#import "SCRPhotosControllerImpl.h"

@implementation SCREngine

@synthesize photosController = _photosController;

#pragma mark - Init

+ (instancetype)engineWithCommsContext:(id<SCRCommsContext>)commsContext
                                config:(SCRConfig *)config {
    return [[SCREngine alloc]initWithCommsContext:commsContext config:config];
}

- (instancetype)initWithCommsContext:(id<SCRCommsContext>)commsContext
                              config:(SCRConfig *)config {
    if (self = [super init]) {
        _commsContext = commsContext;
        _config = config;
    }
    return self;
}

#pragma mark - Controllers

- (id<SCRPhotosController>)photosController {
    if (!_photosController) {
        _photosController = [[SCRPhotosControllerImpl alloc]initWithCommsContext:self.commsContext];
    }
    return _photosController;
}

@end
