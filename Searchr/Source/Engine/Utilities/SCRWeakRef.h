//
//  SCRWeakRef.h
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCRWeakRef<T> : NSProxy

@property (nonatomic, weak) T ref;

+ (instancetype)weakRefWithObject:(T)object;

- (instancetype)initWithObject:(T)object;

@end
