//
//  SCRModel.h
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCRModel<T> : NSObject

@property (nonatomic, copy, readonly, nullable) NSDictionary *dictionary;

+ (nullable instancetype)modelWithDictionary:(nullable NSDictionary *)dictionary;

- (void)evaluateDataDictionary:(nonnull NSDictionary *)dictionary;

@end
