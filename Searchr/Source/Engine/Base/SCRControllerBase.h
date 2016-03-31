//
//  SCRControllerBase.h
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SCRCommsContext.h"

@protocol SCRControllerBase <NSObject>

@property (nonatomic, strong, readonly, nonnull) id<SCRCommsContext> commsContext;

- (instancetype _Nonnull)initWithCommsContext:(nonnull id<SCRCommsContext>)commsContext;

/**
 Add a listener to the controller.
 
 @param listener
 The listener to add.
 */
- (void)addListener:(nonnull id)listener;
/**
 Remove a listener from the controller.
 
 @param listener
 The listener to remove.
 */
- (void)removeListener:(nonnull id)listener;
/**
 Remove all listeners from the controller.
 */
- (void)removeAllListeners;
/**
 Step through all the active listeners for the controller.
 
 @param block
 The block that executes on each listener.
 */
- (void)enumerateListenersWithBlock:(nullable void (^)(id _Nonnull listener, NSUInteger index, BOOL * _Nonnull stop))block;

@end