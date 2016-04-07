//
//  SCREngine.h
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SCRConfig.h"
#import "SCRPhotosController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SCREngine : NSObject

/**
 The current configuration for the application.
 */
@property (nonatomic, strong, readonly) SCRConfig *config;
/**
 The communication context for the application.
 */
@property (nonatomic, strong, readonly) id<SCRCommsContext> commsContext;

/**
 The controller responsible for photos.
 */
@property (nonatomic, strong, readonly) id<SCRPhotosController> photosController;

+ (instancetype)engineWithCommsContext:(id<SCRCommsContext>)commsContext
                                config:(SCRConfig *)config;
@end

NS_ASSUME_NONNULL_END
