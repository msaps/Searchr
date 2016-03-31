//
//  SCRRequest.m
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRRequestBase.h"

@interface SCRRequestBase ()

@property (nonatomic, strong) OFFlickrAPIRequest *request;

@end

@implementation SCRRequestBase

#pragma mark - Init

+ (instancetype)requestWithContext:(OFFlickrAPIContext *)context
                              path:(NSString *)path {
    return [[[self class]alloc]initWithContext:context path:path];
}

- (instancetype)initWithContext:(OFFlickrAPIContext *)context
                           path:(NSString *)path {
    if (self = [super init]) {
        _request = [[OFFlickrAPIRequest alloc]initWithAPIContext:context];
        _path = path;
    }
    return self;
}

#pragma mark - Public

- (void)setDelegate:(id<SCRRequestDelegate>)delegate {
    self.request.delegate = delegate;
}

- (id<SCRRequestDelegate>)delegate {
    return (id<SCRRequestDelegate>)self.request.delegate;
}

- (SCRRequestType)requestType {
    return SCRRequestTypeUnknown;
}

- (void)send {
    switch (self.requestType) {
        case SCRRequestTypeGet:
            [self.request callAPIMethodWithGET:self.path arguments:self.parameters];
            break;
            
        case SCRRequestTypePost:
            [self.request callAPIMethodWithPOST:self.path arguments:self.parameters];
            break;
            
        default:
            break;
    }
}

- (NSTimeInterval)requestTimeoutInterval {
    return self.request.requestTimeoutInterval;
}

- (void)setRequestTimeoutInterval:(NSTimeInterval)inTimeInterval {
    self.request.requestTimeoutInterval = inTimeInterval;
}

- (BOOL)isRunning {
    return self.request.isRunning;
}

- (void)cancel {
    [self.request cancel];
}

@end
