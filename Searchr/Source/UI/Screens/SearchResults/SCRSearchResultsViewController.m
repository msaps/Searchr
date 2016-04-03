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

@interface SCRSearchResultsViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) SCRPagedList *searchResults;

@end

@implementation SCRSearchResultsViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    [cell.imageView scr_setImageWithModel:photoWithUrl];
    cell.titleLabel.text = photo.title;
    
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
