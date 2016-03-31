//
//  SCRControllerBaseImpl.m
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRControllerBaseImpl.h"

@implementation SCRControllerBaseImpl

@synthesize commsContext = _commsContext;

#pragma mark - Init

- (instancetype)initWithCommsContext:(id<SCRCommsContext>)commsContext {
    if (self = [super init]) {
        _commsContext = commsContext;
    }
    return self;
}

@end
