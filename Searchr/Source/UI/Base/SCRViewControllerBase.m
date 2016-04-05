//
//  SCRViewControllerBase.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRViewControllerBase.h"
#import "SCRAppDelegate.h"

@implementation SCRViewControllerBase

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViewConstraints:self.view forDevice:self.currentDevice];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController respondsToSelector:@selector(requiredForegroundColor)]) {
        ((SCRViewControllerBase *)segue.destinationViewController).requiredForegroundColor = self.requiredForegroundColor;
    }
    [super prepareForSegue:segue sender:sender];
}

- (void)updateViewConstraints:(UIView *)view forDevice:(SCRDevice *)device {
    
}

#pragma mark - Public

- (SCREngine *)engine {
    return ((SCRAppDelegate *)[UIApplication sharedApplication].delegate).engine;
}

- (SCRDevice *)currentDevice {
    return ((SCRAppDelegate *)[UIApplication sharedApplication].delegate).currentDevice;
}

- (SCRViewSizer *)viewSizer {
    if (!_viewSizer) {
        _viewSizer = [SCRViewSizer new];
    }
    return _viewSizer;
}

@end
