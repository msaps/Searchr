//
//  SCRViewSizer.m
//  Searchr
//
//  Created by Merrick Sapsford on 03/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRViewSizer.h"
#import <PureLayout/PureLayout.h>

@interface SCRViewSizer ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, UIView *> *sizingViews;
@property (nonatomic, strong) NSMutableDictionary *cachedSizes;

@end

@implementation SCRViewSizer

#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        _sizingViews = [NSMutableDictionary new];
        _cachedSizes = [NSMutableDictionary new];
    }
    return self;
}

#pragma mark - Public

- (CGSize)autoSizeNibViewWithRequiredWidth:(CGFloat)width
                              sizeViewType:(nonnull Class)sizeViewType
                                identifier:(nonnull id)identifier
                           populationBlock:(nonnull SCRViewSizerPopulationBlock)populationBlock {
    
    CGSize cachedSize = [self cachedSizeForIdentifier:identifier];
    if (!CGSizeEqualToSize(cachedSize, CGSizeZero)) {
        return cachedSize;
    }
    
    UIView *sizingView = [self.sizingViews objectForKey:NSStringFromClass(sizeViewType)];
    UIView *populationView = sizingView;
    if (!sizingView) {
        UINib *sizingViewNib = [UINib nibWithNibName:NSStringFromClass(sizeViewType) bundle:[NSBundle mainBundle]];
        sizingView = [[sizingViewNib instantiateWithOwner:self options:nil]firstObject];
    }
    
    // account for UICollectionViewCell contentView weirdness
    if ([sizingView isKindOfClass:[UICollectionViewCell class]]) {
        UICollectionViewCell *cell = (UICollectionViewCell *)sizingView;
        sizingView = cell.contentView;
        populationView = cell;
    }
    
    return [self autoSizeViewWithRequiredWidth:width
                                    sizingView:sizingView
                                populationView:populationView
                                    identifier:identifier
                               populationBlock:populationBlock];
}

- (CGSize)autoSizeViewWithRequiredWidth:(CGFloat)width
                           sizeViewType:(Class)sizeViewType
                             identifier:(id)identifier
                        populationBlock:(SCRViewSizerPopulationBlock)populationBlock {
    
    CGSize cachedSize = [self cachedSizeForIdentifier:identifier];
    if (!CGSizeEqualToSize(cachedSize, CGSizeZero)) {
        return cachedSize;
    }
    
    UIView *sizingView = [self.sizingViews objectForKey:NSStringFromClass(sizeViewType)];
    if (!sizingView) {
        sizingView = [sizeViewType new];
        [self.sizingViews setObject:sizingView forKey:NSStringFromClass(sizeViewType)];
    }
    
    return [self autoSizeViewWithRequiredWidth:width
                                    sizingView:sizingView
                                populationView:sizingView
                                    identifier:identifier
                               populationBlock:populationBlock];
}

#pragma mark - Internal

- (CGSize)autoSizeViewWithRequiredWidth:(CGFloat)width
                             sizingView:(UIView *)sizingView
                         populationView:(UIView *)populationView
                             identifier:(id)identifier
                        populationBlock:(SCRViewSizerPopulationBlock)populationBlock {
    
    if (populationBlock) {
        populationBlock(populationView);
    }
    
    CGSize size = [sizingView systemLayoutSizeFittingSize:CGSizeMake(width, 0.0f)
                            withHorizontalFittingPriority:UILayoutPriorityRequired
                                  verticalFittingPriority:UILayoutPriorityDefaultLow];
    if (identifier) { // cache calculated size
        [self.cachedSizes setObject:[NSValue valueWithCGSize:size] forKey:identifier];
    }
    
    return size;
}

- (CGSize)cachedSizeForIdentifier:(NSString *)identifier {
    if ([self.cachedSizes objectForKey:identifier]) { // if size is already known
        return [[self.cachedSizes objectForKey:identifier]CGSizeValue];
    }
    return CGSizeZero;
}

@end
