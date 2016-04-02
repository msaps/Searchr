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

@end

@implementation SCRPhotosControllerImpl

@synthesize interestingPhotos = _interestingPhotos;
@synthesize currentSearch = _currentSearch;
@synthesize currentSearchResults = _currentSearchResults;

#pragma mark - Public

- (void)getInterestingPhotos {
    
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
     } failure:^(NSError * _Nullable error) {
         SCRStrongSelfStart;
         [self enumerateListenersWithBlock:^(id  _Nonnull listener, NSUInteger index, BOOL * _Nonnull stop) {
             if ([listener respondsToSelector:@selector(photosController:didFailToLoadInterestingPhotos:)]) {
                 [listener photosController:strongSelf didFailToLoadInterestingPhotos:error];
             }
         }];
         SCRStrongSelfEnd;
    }];
    
}

- (void)getSearchResultsForSearch:(SCRSearchBuilder *)search {
    
    if (![search isEqual:self.currentSearch]) {
        // reset current search results
    }
    
    SCRWeakSelfCreate;
    [[self.commsContext flickrApi]getSearchResultsForParameters:search.components
                                                           page:self.currentSearchResults.page + 1
                                                       pageSize:kSCRPhotosControllerImplPageSize
                                                        success:
     ^(SCRPhotoListModel * _Nullable searchResults) {
         SCRStrongSelfStart;
         
         strongSelf.currentSearchResults.pageSize = searchResults.perPage;
         [strongSelf.currentSearchResults addPageWithData:searchResults.data
                                               pageNumber:searchResults.page];
         
         [strongSelf enumerateListenersWithBlock:^(id  _Nonnull listener, NSUInteger index, BOOL * _Nonnull stop) {
             if ([listener respondsToSelector:@selector(photosController:didPerformSearch:withResults:)]) {
                 [listener photosController:strongSelf
                           didPerformSearch:search
                                withResults:strongSelf.currentSearchResults];
             }
         }];
         
         SCRStrongSelfEnd;
     } failure:^(NSError * _Nullable error) {
         SCRStrongSelfStart;
         [self enumerateListenersWithBlock:^(id  _Nonnull listener, NSUInteger index, BOOL * _Nonnull stop) {
             if ([listener respondsToSelector:@selector(photosController:didFailToLoadInterestingPhotos:)]) {
                 [listener photosController:strongSelf didFailToLoadInterestingPhotos:error];
             }
         }];
         SCRStrongSelfEnd;
     }];
}

- (SCRPagedList<SCRPhotoModel *> *)interestingPhotos {
    if (!_interestingPhotos) {
        _interestingPhotos = [SCRPagedList new];
    }
    return _interestingPhotos;
}

- (SCRPagedList<SCRPhotoModel *> *)currentSearchResults {
    if (!_currentSearchResults) {
        _currentSearchResults = [SCRPagedList new];
    }
    return _currentSearchResults;
}

@end
