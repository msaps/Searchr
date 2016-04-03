//
//  SCRSearchViewController.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRSearchViewController.h"
#import "SCRSearchButton.h"

NSString *const SCRSearchViewControllerStopLoadingNotification = @"SCRSearchViewControllerStopLoadingNotification";

@interface SCRSearchViewController () <SCRPhotosControllerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIView *contentView;
@property (nonatomic, weak) IBOutlet SCRSearchButton *searchButton;
@property (nonatomic, weak) IBOutlet UITextField *searchTextField;

@property (nonatomic, strong) SCRSearchBuilder *searchBuilder;

@property (nonatomic, assign) BOOL isLoading;

@end

@implementation SCRSearchViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(stopLoadingNotificationReceived:)
                                                name:SCRSearchViewControllerStopLoadingNotification object:nil];
    
    self.titleLabel.textColor = [UIColor scr_flickrBlue];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:NSLocalizedString(@"Searchr", nil)];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor scr_flickrPink] range:NSMakeRange(title.length - 1, 1)];
    [self.titleLabel setAttributedText:title];
    
    self.searchBuilder.text = @"Vulcan";
}

#pragma mark - Interaction

- (IBAction)searchButtonPressed:(id)sender {
    [self.engine.photosController addListener:self];
    if (self.searchBuilder.components.count > 0) {
        [self.engine.photosController getSearchResultsForSearch:self.searchBuilder];
        [self beginLoadingAnimated:YES];
    }
}

#pragma mark - Internal

- (SCRSearchBuilder *)searchBuilder {
    if (!_searchBuilder) {
        _searchBuilder = [SCRSearchBuilder new];
    }
    return _searchBuilder;
}

- (void)beginLoadingAnimated:(BOOL)animated {
    if (!self.isLoading) {
        self.isLoading = YES;
        
        [self.searchButton startLoadingAnimated:animated];
        if (animated) {
            [UIView animateWithDuration:0.25f animations:^{
                self.searchTextField.alpha = 0.0f;
                self.searchTextField.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
            } completion:^(BOOL finished) {
                self.searchTextField.hidden = YES;
                self.searchTextField.alpha = 1.0f;
                self.searchTextField.transform = CGAffineTransformIdentity;
            }];
        } else {
            self.searchTextField.hidden = YES;
        }
    }
}

- (void)stopLoadingAnimated:(BOOL)animated {
    if (self.isLoading) {
        [self.searchButton stopLoadingAnimated:animated];
        if (animated) {
            self.searchTextField.alpha = 0.0f;
            self.searchTextField.hidden = NO;
            self.searchTextField.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
            [UIView animateWithDuration:0.25f animations:^{
                self.searchTextField.alpha = 1.0f;
                self.searchTextField.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                self.isLoading = NO;
            }];
        } else {
            self.searchTextField.hidden = NO;
            self.isLoading = NO;
        }
    }
}

- (void)stopLoadingNotificationReceived:(NSNotification *)notification {
    [self stopLoadingAnimated:NO];
}

#pragma mark - SCRPhotosControllerDelegate

- (void)photosController:(id<SCRPhotosController>)photosController
        didPerformSearch:(SCRSearchBuilder *)search
             withResults:(SCRPagedList<SCRPhotoModel *> *)searchResults {
    [photosController removeListener:self];
    [self.parentViewController performSegueWithIdentifier:@"showSearchResultsSegue" sender:self];
}

- (void)photosController:(id<SCRPhotosController>)photosController
  didFailToPerformSearch:(SCRSearchBuilder *)search
               withError:(NSError *)error {
    
}

@end
