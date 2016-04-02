//
//  SCRRequest.m
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRRequest.h"

@interface SCRRequest () <OFFlickrAPIRequestDelegate>

@property (nonatomic, strong) OFFlickrAPIRequest *request;

@property (nonatomic, strong) SCRRequestSuccessBlock successBlock;
@property (nonatomic, strong) SCRRequestFailureBlock failureBlock;

@end

@implementation SCRRequest

#pragma mark - Init

+ (instancetype)requestOfType:(SCRRequestType)requestType
                  withContext:(nonnull OFFlickrAPIContext *)context
                         path:(nonnull NSString *)path
                   parameters:(nullable NSDictionary *)parameters
                      success:(SCRRequestSuccessBlock)success
                      failure:(SCRRequestFailureBlock)failure {
    return [[[self class]alloc]initWithType:requestType
                                    context:context
                                       path:path
                                 parameters:parameters
                                    success:success failure:failure];
}

- (instancetype)initWithType:(SCRRequestType)requestType
                     context:(OFFlickrAPIContext *)context
                        path:(NSString *)path
                  parameters:(nullable NSDictionary *)parameters
                     success:(SCRRequestSuccessBlock)success
                     failure:(SCRRequestFailureBlock)failure {
    if (self = [super init]) {
        _requestType = requestType;
        _request = [[OFFlickrAPIRequest alloc]initWithAPIContext:context];
        _request.delegate = self;
        _path = path;
        _parameters = parameters;
        _successBlock = success;
        _failureBlock = failure;
        [self send];
    }
    return self;
}

#pragma mark - Public

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

#pragma mark OFFlickrAPIRequestDelegate

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary {
    if (self.successBlock) {
        self.successBlock(inResponseDictionary);
    }
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError {
    if (self.failureBlock) {
        self.failureBlock(inError);
    }
}

@end
