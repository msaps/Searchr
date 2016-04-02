//
//  SCRPhotosController.h
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRControllerBase.h"

@protocol SCRPhotosControllerDelegate <NSObject>



@end

@protocol SCRPhotosController <SCRControllerBase>

- (void)loadInterestingPhotos;

- (void)testMethod;

@end
