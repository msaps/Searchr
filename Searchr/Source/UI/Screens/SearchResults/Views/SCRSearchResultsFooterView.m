//
//  SCRSearchResultsFooterView.m
//  Searchr
//
//  Created by Merrick Sapsford on 03/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRSearchResultsFooterView.h"
#import "UIColor+SCRColorPalette.h"

@interface SCRSearchResultsFooterView ()

@property (nonatomic, weak) IBOutlet UIView *errorView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation SCRSearchResultsFooterView

#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.errorLabel.text = NSLocalizedString(@"Could not load photos", nil);
    [self.errorButton setTitle:NSLocalizedString(@"Try again", nil) forState:UIControlStateNormal];
    
    self.errorLabel.textColor = [UIColor darkGrayColor];
    [self.errorButton setTitleColor:[UIColor scr_flickrBlue] forState:UIControlStateNormal];
}

#pragma mark - Public

- (void)setErrorViewVisible:(BOOL)errorViewVisible {
    self.errorView.hidden = !errorViewVisible;
    if (errorViewVisible) {
        [self.activityIndicator stopAnimating];
    } else {
        [self.activityIndicator startAnimating];
    }
}

- (BOOL)errorViewVisible {
    return !self.errorView.hidden;
}

@end
