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

@interface SCRSearchResultsViewController () <SCRPhotosControllerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) SCRPagedList *searchResults;

@end

@implementation SCRSearchResultsViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.engine.photosController addListener:self];
    self.searchResults = [self.engine.photosController currentSearchResults];
    
    self.title = NSLocalizedString(@"Search Results", nil);
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SCRSearchResultCollectionViewCell" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:@"pictureCell"];
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

#pragma mark - SCRPhotosControllerDelegate

- (void)photosController:(id<SCRPhotosController>)photosController
        didLoadPhotoInfo:(SCRPhotoModelWithInfo *)photo {
    NSIndexPath *indexPath = [self indexPathForPhotoWithIdentifier:photo.identifier];
    SCRSearchResultCollectionViewCell *cell = (SCRSearchResultCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [cell setPhotoWithInfo:photo];
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
    SCRSearchResultCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pictureCell" forIndexPath:indexPath];
    SCRPhotoModel *photo = self.searchResults.data[indexPath.row];
    SCRPhotoModelWithUrl *photoWithUrl = [SCRPhotoModelWithUrl photoModelWithModel:photo
                                                                            config:self.engine.config];
    
    [cell setPhotoWithUrl:photoWithUrl];
    SCRPhotoModelWithInfo *photoWithInfo = [self.engine.photosController getPhotoInfoForPhoto:photo];
    if (photoWithInfo) {
        [cell setPhotoWithInfo:photoWithInfo];
    } else { // start loading info
        
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewFlowLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIEdgeInsets sectionInset = collectionViewLayout.sectionInset;
    CGFloat width = collectionView.bounds.size.width - (sectionInset.left + sectionInset.right);
    SCRPhotoModel *photo = self.searchResults.data[indexPath.row];
    
    CGSize size = [self.viewSizer autoSizeNibViewWithRequiredWidth:width
                                                      sizeViewType:[SCRSearchResultCollectionViewCell class]
                                                        identifier:indexPath
                                                   populationBlock:
                   ^(UIView * _Nonnull view) {
                       SCRSearchResultCollectionViewCell *cell = (SCRSearchResultCollectionViewCell *)view;
                       cell.titleLabel.text = photo.title;
    }];
    return size;
}

@end
