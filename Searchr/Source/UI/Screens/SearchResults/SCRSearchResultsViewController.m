//
//  SCRSearchResultsViewController.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRSearchResultsViewController.h"
#import "SCRSearchResultCollectionViewCell.h"
#import "SCRSearchViewController.h"
#import "SCRWeakSelf.h"
#import "SCRSearchResultsFooterView.h"

NSString *const kSCRSearchResultsViewControllerReuseIdentifierPictureCell = @"pictureCell";
NSString *const kSCRSearchResultsViewControllerReuseIdentifierFooter = @"spinnerFooter";

CGFloat const kSCRSearchResultsViewControllerFooterHeight = 44.0f;

@interface SCRSearchResultsViewController () <SCRPhotosControllerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) SCRSearchResultsFooterView *currentFooterView;

@property (nonatomic, strong) SCRPagedList *searchResults;

@end

@implementation SCRSearchResultsViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.engine.photosController addListener:self];
    self.searchResults = [self.engine.photosController currentSearchResults];
    
    self.title = NSLocalizedString(@"Search Results", nil);
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SCRSearchResultCollectionViewCell class])
                                                    bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:kSCRSearchResultsViewControllerReuseIdentifierPictureCell];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SCRSearchResultsFooterView class])
                                                    bundle:[NSBundle mainBundle]]
          forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                 withReuseIdentifier:kSCRSearchResultsViewControllerReuseIdentifierFooter];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // stop search screen loading
    [[NSNotificationCenter defaultCenter]postNotificationName:SCRSearchViewControllerStopLoadingNotification object:self];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // account for nav bar insets as collection view is not root view
    CGFloat top = self.topLayoutGuide.length;
    CGFloat bottom = self.bottomLayoutGuide.length;
    UIEdgeInsets newInsets = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.collectionView.contentInset = newInsets;
}

#pragma mark - Interaction

- (IBAction)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Internal

- (NSIndexPath *)indexPathForPhotoWithIdentifier:(NSString *)identifier {
    NSInteger itemIndex = 0;
    for (SCRPhotoModel *photo in self.searchResults.data) {
        if ([photo.identifier isEqualToString:identifier]) {
            return [NSIndexPath indexPathForItem:itemIndex inSection:0];
        }
        itemIndex++;
    }
    return nil;
}

- (void)populateCell:(SCRSearchResultCollectionViewCell *)cell withPhotoModel:(SCRPhotoModel *)photoModel {
    
    SCRPhotoModelWithUrl *photoWithUrl = [SCRPhotoModelWithUrl photoModelWithModel:photoModel
                                                                            config:self.engine.config];
    [cell setPhotoWithUrl:photoWithUrl];
    
    SCRPhotoModelWithInfo *photoWithInfo = [self.engine.photosController getPhotoInfoForPhoto:photoModel];
    if (photoWithInfo) {
        [self populateCell:cell withPhotoModelWithInfo:photoWithInfo];
    } else { // start loading info
        [cell startLoadingAnimated:YES];
    }
}

- (void)populateCell:(SCRSearchResultCollectionViewCell *)cell withPhotoModelWithInfo:(SCRPhotoModelWithInfo *)photoModelWithInfo {
    [cell setPhotoWithInfo:photoModelWithInfo];
    
    SCRPhotoOwnerModelWithUrl *photoOwnerWithUrl = [SCRPhotoOwnerModelWithUrl photoOwnerModelWithModel:photoModelWithInfo.ownerModel
                                                                                                config:self.engine.config];
    [cell setPhotoOwnerWithUrl:photoOwnerWithUrl];
}

#pragma mark - SCRPhotosControllerDelegate

- (void)photosController:(id<SCRPhotosController>)photosController
        didLoadPhotoInfo:(SCRPhotoModelWithInfo *)photo {
    NSIndexPath *indexPath = [self indexPathForPhotoWithIdentifier:photo.identifier];
    SCRSearchResultCollectionViewCell *cell = (SCRSearchResultCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [self populateCell:cell withPhotoModelWithInfo:photo];
}

- (void)photosController:(id<SCRPhotosController>)photosController
didFailToLoadPhotoInfoForPhoto:(SCRPhotoModel *)photo
               withError:(NSError *)error {
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.searchResults.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SCRSearchResultCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:kSCRSearchResultsViewControllerReuseIdentifierPictureCell
                                              forIndexPath:indexPath];
    SCRPhotoModel *photo = self.searchResults.data[indexPath.row];
    
    [self populateCell:cell withPhotoModel:photo];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewFlowLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIEdgeInsets sectionInset = collectionViewLayout.sectionInset;
    CGFloat width = collectionView.bounds.size.width - (sectionInset.left + sectionInset.right);
    SCRPhotoModel *photo = self.searchResults.data[indexPath.row];
    
    SCRWeakSelfCreate;
    CGSize size = [self.viewSizer autoSizeNibViewWithRequiredWidth:width
                                                      sizeViewType:[SCRSearchResultCollectionViewCell class]
                                                        identifier:indexPath
                                                   populationBlock:
                   ^(UIView * _Nonnull view) {
                       SCRStrongSelfStart;
                       SCRSearchResultCollectionViewCell *cell = (SCRSearchResultCollectionViewCell *)view;
                       [strongSelf populateCell:cell withPhotoModel:photo];
                       SCRStrongSelfEnd;
    }];
    return size;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionFooter) {
        _currentFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                withReuseIdentifier:kSCRSearchResultsViewControllerReuseIdentifierFooter
                                                                       forIndexPath:indexPath];
        return _currentFooterView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewFlowLayout *)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section {
    
    if (self.searchResults.page != self.searchResults.totalPagesAvailable) {
        return CGSizeMake(0.0f, kSCRSearchResultsViewControllerFooterHeight + collectionViewLayout.sectionInset.bottom);
    }
    return CGSizeZero;
}

@end
