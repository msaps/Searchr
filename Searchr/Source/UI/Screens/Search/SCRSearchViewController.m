//
//  SCRSearchViewController.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRSearchViewController.h"

@interface SCRSearchViewController ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end

@implementation SCRSearchViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.textColor = [UIColor scr_flickrBlue];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:NSLocalizedString(@"Searchr", nil)];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor scr_flickrPink] range:NSMakeRange(title.length - 1, 1)];
    [self.titleLabel setAttributedText:title];
    
}

#pragma mark - Interaction

- (IBAction)searchButtonPressed:(id)sender {
}

@end
