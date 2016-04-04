//
//  SCRNibLoader.h
//  Searchr
//
//  Created by Merrick Sapsford on 04/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCRNibLoader : NSObject

@property (nonatomic, strong, nullable, readonly) UIView *nibView;

- (nullable UIView *)addNibViewToView:(nonnull UIView *)view;

- (nullable UIView *)addNibViewToView:(nonnull UIView *)view bundle:(nonnull NSBundle *)bundle;

@end
