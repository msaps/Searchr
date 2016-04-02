//
//  SCRRequest.h
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <objectiveflickr/ObjectiveFlickr.h>

typedef void(^SCRRequestSuccessBlock)(NSDictionary *_Nullable responseData);
typedef void(^SCRRequestFailureBlock)(NSError *_Nullable error);

typedef NS_ENUM(NSInteger, SCRRequestType) {
    SCRRequestTypeUnknown,
    SCRRequestTypePost,
    SCRRequestTypeGet
};

@interface SCRRequest : NSObject

/**
 The parameters to send with the request.
 */
@property (nonatomic, copy, nullable) NSDictionary *parameters;
/**
 The type of the request.
 */
@property (nonatomic, assign, readonly) SCRRequestType requestType;
/**
 The path for the request.
 */
@property (nonatomic, copy, nonnull, readonly) NSString *path;
/**
 The timeout interval for the request.
 */
@property (nonatomic, assign) NSTimeInterval requestTimeoutInterval;

+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;
+ (nullable instancetype)requestOfType:(SCRRequestType)requestType
                           withContext:(nonnull OFFlickrAPIContext *)context
                                  path:(nonnull NSString *)path
                            parameters:(nullable NSDictionary *)parameters
                               success:(nullable SCRRequestSuccessBlock)success
                               failure:(nullable SCRRequestFailureBlock)failure;

/**
 Whether the request is currently running.
 */
- (BOOL)isRunning;
/**
 Cancel the request.
 */
- (void)cancel;

@end
