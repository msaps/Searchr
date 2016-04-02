//
//  SCRPhotosControllerImpl.m
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRPhotosControllerImpl.h"
#import "SCRWeakSelf.h"

NSInteger const kSCRPhotosControllerImplPageSize = 20;

@interface SCRPhotosControllerImpl ()

@property (nonatomic, strong) SCRRequest *request;

@end

@implementation SCRPhotosControllerImpl

@synthesize interestingPhotos = _interestingPhotos;

#pragma mark - Public

- (void)getInterestingPhotos {
    
    if (!self.interestingPhotos) {
        _interestingPhotos = [SCRPagedList new];
    }
    
    SCRWeakSelfCreate;
    [[self.commsContext flickrApi]getInterestingPhotosWithPage:self.interestingPhotos.page + 1
                                                      pageSize:kSCRPhotosControllerImplPageSize
                                                       success:
     ^(SCRPhotoListModel * _Nullable popularPhotos) {
         SCRStrongSelfStart;
         
         strongSelf.interestingPhotos.pageSize = popularPhotos.perPage;
         [strongSelf.interestingPhotos addPageWithData:popularPhotos.data
                                            pageNumber:popularPhotos.page];
         
         [strongSelf enumerateListenersWithBlock:^(id  _Nonnull listener, NSUInteger index, BOOL * _Nonnull stop) {
             if ([listener respondsToSelector:@selector(photosController:didLoadInterestingPhotos:)]) {
                 [listener photosController:strongSelf didLoadInterestingPhotos:strongSelf.interestingPhotos];
             }
         }];

         SCRStrongSelfEnd;
     } failure:
     ^(NSError * _Nullable error) {
         SCRStrongSelfStart;
         [self enumerateListenersWithBlock:^(id  _Nonnull listener, NSUInteger index, BOOL * _Nonnull stop) {
             if ([listener respondsToSelector:@selector(photosController:didFailToLoadInterestingPhotos:)]) {
                 [listener photosController:strongSelf didFailToLoadInterestingPhotos:error];
             }
         }];
         SCRStrongSelfEnd;
    }];
    
}

@end
