//
//  SCRCommsContextImpl.h
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRCommsContext.h"
#import "SCRConfig.h"

@interface SCRCommsContextImpl : NSObject <SCRCommsContext>

+ (instancetype)commsContextWithConfig:(SCRConfig *)config;

@end
