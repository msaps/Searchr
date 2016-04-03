//
//  SCRViewSizer.h
//  Searchr
//
//  Created by Merrick Sapsford on 03/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SCRViewSizerPopulationBlock)(UIView * _Nonnull view);

@interface SCRViewSizer : NSObject

/**
 Calculate the required size for a view from a nib.
 
 @param width
 The required width.
 
 @param sizeViewType
 The type of view to use for sizing (Nib file must have class name).
 
 @param identifier
 Unique identifier for the view to allow for size caching.
 
 @param populationBlock
 The block for populating the view.
 */
- (CGSize)autoSizeNibViewWithRequiredWidth:(CGFloat)width
                              sizeViewType:(nonnull Class)sizeViewType
                                identifier:(nonnull id)identifier
                           populationBlock:(nonnull SCRViewSizerPopulationBlock)populationBlock;
/**
 Calculate the required size for a view.
 
 @param width
 The required width.
 
 @param sizeViewType
 The type of view to use for sizing.
 
 @param identifier
 Unique identifier for the view to allow for size caching.
 
 @param populationBlock
 The block for populating the view.
 */
- (CGSize)autoSizeViewWithRequiredWidth:(CGFloat)width
                           sizeViewType:(nonnull Class)sizeViewType
                             identifier:(nonnull id)identifier
                        populationBlock:(nonnull SCRViewSizerPopulationBlock)populationBlock;

@end
