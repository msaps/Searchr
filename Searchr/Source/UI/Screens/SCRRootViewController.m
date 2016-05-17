//
//  SCRRootViewController.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRRootViewController.h"
#import "SCRPhotoModelWithUrl.h"
#import "SCRWeakSelf.h"
#import "UIImageView+SCRFlickrLoading.h"

@interface SCRRootViewController () <SCRPhotosControllerDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIView *blurViewContainer;

@property (nonatomic, assign) SCRReadableForegroundColor requiredForegroundColor;

@end

@implementation SCRRootViewController

@synthesize requiredForegroundColor = _requiredForegroundColor;

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.engine.photosController addListener:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([self.engine.photosController interestingPhotos].data.count == 0) {
        [self.engine.photosController getInterestingPhotos];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    switch (self.requiredForegroundColor) {
        case SCRReadableForegroundColorWhite:
            return UIStatusBarStyleLightContent;
            
        default:
            return UIStatusBarStyleDefault;
    }
}

#pragma mark - Internal

- (SCRPhotoModel *)randomPhotoModelFromList:(SCRPagedList<SCRPhotoModel *> *)photoModel {
    NSInteger index = arc4random_uniform((int)photoModel.data.count - 1);
    return photoModel.data[index];
}

#pragma mark - Public

- (void)setRequiredForegroundColor:(SCRReadableForegroundColor)requiredForegroundColor {
    _requiredForegroundColor = requiredForegroundColor;
    
    for (SCRViewControllerBase *childViewController in self.childViewControllers) {
        childViewController.requiredForegroundColor = requiredForegroundColor;
    }
    
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - SCRPhotosControllerDelegate

- (void)photosController:(id<SCRPhotosController>)photosController
didLoadInterestingPhotos:(SCRPagedList<SCRPhotoModel *> *)interestingPhotos {
    
    SCRPhotoModel *photo = [self randomPhotoModelFromList:interestingPhotos];
    SCRPhotoModelWithUrl *photoWithUrl = [SCRPhotoModelWithUrl photoModelWithModel:photo
                                                                            config:self.engine.config];
    
    
    
    // load the interesting photo
    [self.imageView scr_setImageWithUrl:photoWithUrl.photoUrl
                               animated:YES
                            clearOnLoad:NO
                                success:
     ^(UIImage * _Nonnull image) {
         
         // get the required foreground color from the image
         UIColor *averageImageColor = [image averageColor];
         SCRReadableForegroundColor readableColor = [UIColor readableForegroundColorForBackgroundColor:averageImageColor];
         
         // display the image
         self.requiredForegroundColor = readableColor;
         
         // fade in blur view
         [UIView animateWithDuration:0.15f animations:^{
             self.blurViewContainer.alpha = 1.0f;
         }];
         
    } failure:nil];
}

- (void)photosController:(id<SCRPhotosController>)photosController didFailToLoadInterestingPhotos:(NSError *)error {
    
}

@end
