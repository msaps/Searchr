//
//  SCRRequest.h
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <objectiveflickr/ObjectiveFlickr.h>

typedef NS_ENUM(NSInteger, SCRRequestType) {
    SCRRequestTypeUnknown,
    SCRRequestTypePost,
    SCRRequestTypeGet
};

@protocol SCRRequestDelegate <OFFlickrAPIRequestDelegate>
@end

@interface SCRRequestBase : NSObject

/**
 The object that acts as a delegate to the request.
 */
@property (nonatomic, weak, nullable) id<SCRRequestDelegate> delegate;
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
+ (nullable instancetype)requestWithContext:(nonnull OFFlickrAPIContext *)context
                                       path:(nonnull NSString *)path;

/**
 Send the request.
 */
- (void)send;
/**
 Whether the request is currently running.
 */
- (BOOL)isRunning;
/**
 Cancel the request.
 */
- (void)cancel;

@end
