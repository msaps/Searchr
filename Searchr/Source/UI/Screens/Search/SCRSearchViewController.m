//
//  SCRSearchViewController.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRSearchViewController.h"
#import "SCRSearchButton.h"
#import "UIView+SCRKeyboardDismiss.h"

NSString *const SCRSearchViewControllerStopLoadingNotification = @"SCRSearchViewControllerStopLoadingNotification";
CGFloat const kSCRSearchViewControllerKeyboardPadding = 24.0f;

typedef void(^UIViewAnimationCompletion)(BOOL finished);

@interface SCRSearchViewController () <SCRPhotosControllerDelegate, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet SCRSearchButton *searchButton;
@property (nonatomic, weak) IBOutlet UITextField *searchTextField;

@property (nonatomic, strong) SCRSearchBuilder *searchBuilder;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *titlelabelTopMargin;

@property (nonatomic, assign) BOOL isLoading;

@end

@implementation SCRSearchViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view becomeKeyboardDismissalResponder];
    
    self.keyboardDelegate = [SCRKeyboardObserver keyboardObserverForResponder:self];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(stopLoadingNotificationReceived:)
                                                name:SCRSearchViewControllerStopLoadingNotification object:nil];
    
    [self updateTitleLabelForegroundColor];
    
    // set component appearance
    self.searchTextField.alpha = 0.0f;
    self.searchTextField.placeholder = NSLocalizedString(@"Search Flickr...", nil);
    self.searchTextField.tintColor = [UIColor scr_flickrPink];
    self.searchButton.alpha = 0.0f;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // fade in components
    if (self.searchButton.alpha == 0.0f) {
        [UIView animateWithDuration:0.25f animations:^{
            self.searchButton.alpha = 1.0f;
            self.searchTextField.alpha = 1.0f;
        }];
    }
}

- (void)setRequiredForegroundColor:(SCRReadableForegroundColor)requiredForegroundColor {
    [super setRequiredForegroundColor:requiredForegroundColor];
    [UIView animateWithDuration:0.25f animations:^{
        [self updateTitleLabelForegroundColor];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - Interaction

- (IBAction)searchButtonPressed:(id)sender {
    if ([sender isKindOfClass:[UITextField class]]) {
        [sender resignFirstResponder];
    }
    
    [self.engine.photosController addListener:self];
    if ([self.searchBuilder isValid]) {
        
        if ([self.searchBuilder.search isEqual:[self.engine.photosController currentSearch]] &&
            ![self.engine.photosController currentSearch].didFailLoad) { // if results already exist for current search
            [self showSearchResultsScreen];
        } else { // new search required
            [self beginLoadingAnimated:YES completion:^(BOOL finished) {
                [self.engine.photosController getSearchResultsForSearch:self.searchBuilder.search];
            }];
        }
    }
}

#pragma mark - Internal

- (SCRSearchBuilder *)searchBuilder {
    if (!_searchBuilder) {
        _searchBuilder = [SCRSearchBuilder new];
    }
    return _searchBuilder;
}

- (void)beginLoadingAnimated:(BOOL)animated completion:(UIViewAnimationCompletion)completion {
    if (!self.isLoading) {
        self.isLoading = YES;
        
        [self.searchButton startLoadingAnimated:animated];
        if (animated) {
            [self.view.layer removeAllAnimations];
            [UIView animateWithDuration:0.25f animations:^{
                self.searchTextField.alpha = 0.0f;
                self.searchTextField.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
            } completion:^(BOOL finished) {
                if (finished) {
                    self.searchTextField.hidden = YES;
                    self.searchTextField.alpha = 1.0f;
                    self.searchTextField.transform = CGAffineTransformIdentity;
                }
                if (completion) {
                    completion(finished);
                }
            }];
        } else {
            self.searchTextField.hidden = YES;
        }
    }
}

- (void)stopLoadingAnimated:(BOOL)animated completion:(UIViewAnimationCompletion)completion {
    if (self.isLoading) {
        [self.searchButton stopLoadingAnimated:animated];
        if (animated) {
            [self.view.layer removeAllAnimations];
            self.searchTextField.alpha = 0.0f;
            self.searchTextField.hidden = NO;
            self.searchTextField.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
            [UIView animateWithDuration:0.25f animations:^{
                self.searchTextField.alpha = 1.0f;
                self.searchTextField.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (finished) {
                    self.isLoading = NO;
                }
                if (completion) {
                    completion(finished);
                }
            }];
        } else {
            self.searchTextField.hidden = NO;
            self.isLoading = NO;
        }
    }
}

- (void)stopLoadingNotificationReceived:(NSNotification *)notification {
    [self stopLoadingAnimated:NO completion:nil];
}

- (void)showSearchResultsScreen {
    [self.engine.photosController removeListener:self];
    [self.parentViewController performSegueWithIdentifier:@"showSearchResultsSegue" sender:self];
}

- (void)updateTitleLabelForegroundColor {
    
    BOOL requiresWhite = (self.requiredForegroundColor == SCRReadableForegroundColorWhite);
    
    self.titleLabel.textColor = requiresWhite ? [UIColor whiteColor] : [UIColor scr_flickrBlue];
    if (requiresWhite) {
        self.titleLabel.shadowColor = [[UIColor blackColor]colorWithAlphaComponent:0.15f];
    }
    
    // highlight last letter
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:NSLocalizedString(@"Searchr", nil)];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor scr_flickrPink] range:NSMakeRange(title.length - 1, 1)];
    [self.titleLabel setAttributedText:title];
}

#pragma mark - SCRPhotosControllerDelegate

- (void)photosController:(id<SCRPhotosController>)photosController
        didPerformSearch:(SCRSearchBuilder *)search
             withResults:(SCRPagedList<SCRPhotoModel *> *)searchResults {
    [self showSearchResultsScreen];
}

- (void)photosController:(id<SCRPhotosController>)photosController
  didFailToPerformSearch:(nonnull SCRSearchBuilder *)search withError:(nonnull NSError *)error {
    [self stopLoadingAnimated:YES completion:^(BOOL finished) {
        // display alert
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Search Failed", nil)
                                                                                 message:NSLocalizedString(@"Could not load photos, please check your connection", nil)
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:nil]];
        [self.parentViewController presentViewController:alertController
                                                animated:YES
                                              completion:nil];
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    
    if ([[self.engine.photosController currentSearch]isEqual:self.searchBuilder]) {
        _searchBuilder = nil;
    }
    
    // update search text
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.searchBuilder.text = text;
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.returnKeyType = UIReturnKeySearch;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self searchButtonPressed:textField];
    return YES;
}

#pragma mark - SCRKeyboardDelegate

- (void)keyboardDelegate:(SCRKeyboardObserver *)delegate willShowKeyboardWithUpdate:(SCRKeyboardUpdate *)update {
    CGFloat searchButtonBottom = CGRectGetMaxY(self.searchButton.frame) + kSCRSearchViewControllerKeyboardPadding;
    CGFloat keyboardTop = CGRectGetMinY(update.endFrame);
    
    if (keyboardTop < searchButtonBottom) { // scroll content up if needed
        CGFloat yOffset = searchButtonBottom - keyboardTop;
        
        [UIView animateWithDuration:update.animationDuration delay:0.0f options:(NSUInteger)update.animationCurve animations:^{
            [self.scrollView setContentOffset:CGPointMake(0.0f, yOffset) animated:NO];
        } completion:nil];
    }
}

- (void)keyboardDelegate:(SCRKeyboardObserver *)delegate willHideKeyboardWithUpdate:(SCRKeyboardUpdate *)update {
    
    if (!CGPointEqualToPoint(self.scrollView.contentOffset, CGPointZero)) {
        [UIView animateWithDuration:update.animationDuration delay:0.0f options:(NSUInteger)update.animationCurve animations:^{
            [self.scrollView setContentOffset:CGPointZero animated:NO];
        } completion:nil];
    }
}

@end
