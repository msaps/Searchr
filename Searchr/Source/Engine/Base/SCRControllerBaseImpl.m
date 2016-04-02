//
//  SCRControllerBaseImpl.m
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRControllerBaseImpl.h"
#import "SCRWeakRef.h"

@interface SCRControllerBaseImpl ()

@property (nonatomic, copy) NSMutableArray *listeners;

@end

@implementation SCRControllerBaseImpl

@synthesize commsContext = _commsContext;

#pragma mark - Init

- (instancetype)initWithCommsContext:(id<SCRCommsContext>)commsContext {
    if (self = [super init]) {
        _commsContext = commsContext;
        _listeners = [NSMutableArray new];
    }
    return self;
}

#pragma mark - Listeners

- (void)addListener:(id)listener {
    if ([self indexOfListener:listener] == NSNotFound) {
        [self.listeners addObject:[SCRWeakRef weakRefWithObject:listener]];
    }
}

- (void)removeListener:(id)listener {
    NSInteger index = [self indexOfListener:listener];
    if (index != NSNotFound) {
        [self.listeners removeObjectAtIndex:index];
    }
}

- (void)removeAllListeners {
    [self.listeners removeAllObjects];
}

- (void)enumerateListenersWithBlock:(void (^)(id, NSUInteger, BOOL *))block {
    NSMutableArray<SCRWeakRef *> *listenersToRemove = [NSMutableArray new];
    
    // enumerate copy incase listeners remove themselves when they are called
    [self.listeners.copy enumerateObjectsUsingBlock:
     ^(SCRWeakRef *listenerRef, NSUInteger idx, BOOL *stop) {
         
         // call block if listener exists
         if (listenerRef.ref) {
             block(listenerRef.ref, idx, stop);
         } else { // otherwise remove it
             [listenersToRemove addObject:listenerRef];
         }
     }];
    
    [self.listeners removeObjectsInArray:listenersToRemove];
}

- (NSInteger)indexOfListener:(id)listener {
    NSInteger index = [self.listeners indexOfObjectPassingTest:
                       ^BOOL(SCRWeakRef *weakRef, NSUInteger idx, BOOL *stop) {
                           *stop = weakRef.ref == listener;
                           return *stop;
                       }];
    return index;
}

@end
