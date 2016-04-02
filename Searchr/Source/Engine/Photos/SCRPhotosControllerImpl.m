//
//  SCRPhotosControllerImpl.m
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRPhotosControllerImpl.h"

@interface SCRPhotosControllerImpl ()

@property (nonatomic, strong) SCRRequest *request;

@end

@implementation SCRPhotosControllerImpl

- (void)testMethod {
    
    [[self.commsContext photosApi]getInterestingPhotosWithPage:1 pageSize:10 success:^(SCRPhotoListModel * _Nullable popularPhotos) {
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
