//
//  SCRWeakRef.m
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRWeakRef.h"

@implementation SCRWeakRef

+ (instancetype)weakRefWithObject:(id)object {
    return [[SCRWeakRef alloc] initWithObject:object];
}

- (instancetype)initWithObject:(id)object {
    self.ref = object;
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    invocation.target = self.ref;
    [invocation invoke];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.ref methodSignatureForSelector:sel];
}

@end
