//
//  SCRNibLoader.m
//  Searchr
//
//  Created by Merrick Sapsford on 04/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRNibLoader.h"
#import <PureLayout/PureLayout.h>

@implementation SCRNibLoader

- (UIView *)addNibViewToView:(UIView *)view {
    return [self addNibViewToView:view bundle:[NSBundle bundleForClass:[view class]]];
}

- (UIView *)addNibViewToView:(UIView *)view bundle:(NSBundle *)bundle {
    view.clipsToBounds = YES;
    
    NSString *nibName = NSStringFromClass([view class]);
    NSString *path = [bundle pathForResource:nibName ofType:@"nib"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
        
        UINib *nib = [UINib nibWithNibName:nibName bundle:bundle];
        UIView *nibView = [[nib instantiateWithOwner:self options:nil]firstObject];
        
        [view addSubview:nibView];
        [nibView autoPinEdgesToSuperviewEdges];
        
        _nibView = nibView;
        return nibView;
    }
    return nil;
}

@end
