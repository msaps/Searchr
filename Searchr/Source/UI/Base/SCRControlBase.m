//
//  SCRControlBase.m
//  Searchr
//
//  Created by Merrick Sapsford on 04/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRControlBase.h"
#import "SCRNibLoader.h"

@implementation SCRControlBase

#pragma mark - Init

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self baseInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    
    SCRNibLoader *nibLoader = [SCRNibLoader new];
    [nibLoader addNibViewToView:self];
}

@end
