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

@property (nonatomic, strong, readonly) id<SCRCommsContext> commsContext;

- (instancetype)initWithCommsContext:(id<SCRCommsContext>)commsContext;

@end