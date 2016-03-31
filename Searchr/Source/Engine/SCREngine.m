//
//  SCREngine.m
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCREngine.h"

#import "SCRPhotosControllerImpl.h"

@interface SCREngine ()

@property (nonatomic, strong) id<SCRCommsContext> commsContext;

@end

@implementation SCREngine

@synthesize photosController = _photosController;

#pragma mark - Init

+ (instancetype)engineWithCommsContext:(id<SCRCommsContext>)commsContext {
    return [[SCREngine alloc]initWithCommsContext:commsContext];
}

- (instancetype)initWithCommsContext:(id<SCRCommsContext>)commsContext {
    if (self = [super init]) {
        _commsContext = commsContext;
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
