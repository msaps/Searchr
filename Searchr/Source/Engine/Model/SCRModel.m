//
//  SCRModel.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRModel.h"

@implementation SCRModel

#pragma mark - Init

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary {
    return [[[self class]alloc]initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (dictionary) {
        if (self = [super init]) {
            _dictionary = dictionary;
            [self evaluateDataDictionary:dictionary];
        }
        return self;
    }
    return nil;
}

#pragma mark - Public

- (void)evaluateDataDictionary:(NSDictionary *)dictionary {
    
}

@end
