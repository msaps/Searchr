//
//  SCREngine.h
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SCRPhotosController.h"

@interface SCREngine : NSObject

@property (nonatomic, strong, readonly) id<SCRPhotosController> photosController;

+ (instancetype)engineWithCommsContext:(id<SCRCommsContext>)commsContext;

@end
