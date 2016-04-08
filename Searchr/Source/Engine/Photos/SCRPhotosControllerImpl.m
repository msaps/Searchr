//
//  SCRPhotosControllerImpl.m
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRPhotosControllerImpl.h"
#import "SCRWeakSelf.h"
#import "SCRSearch+Private.h"

NSInteger const kSCRPhotosControllerImplPageSize = 20;

@interface SCRPhotosControllerImpl ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, SCRPhotoModelWithInfo *> *photoInfo;

@end

@implementation SCRPhotosControllerImpl

@synthesize interestingPhotos = _interestingPhotos;
@synthesize currentSearch = _currentSearch;

#pragma mark - Public

- (void)getInterestingPhotos {
    
    SCRWeakSelfCreate;
    [[self.commsContext flickrApi]getInterestingPhotosWithPage:self.interestingPhotos.page + 1
                                                      pageSize:kSCRPhotosControllerImplPageSize
                                                       success:
     ^(SCRPhotoListModel * _Nullable popularPhotos) {
         SCRStrongSelfStart;
         
         strongSelf.interestingPhotos.pageSize = popularPhotos.perPage;
         strongSelf.interestingPhotos.totalItems = popularPhotos.totalItems;
         strongSelf.interestingPhotos.totalPagesAvailable = popularPhotos.totalPages;
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

- (void)getSearchResultsForSearch:(SCRSearch *)search {
    
    if (![search isEqual:self.currentSearch]) {
        _currentSearch = [search copy];
    }
    
    SCRWeakSelfCreate;
    [[self.commsContext flickrApi]getSearchResultsForParameters:search.components
                                                           page:self.currentSearch.results.page + 1
                                                       pageSize:kSCRPhotosControllerImplPageSize
                                                        success:
     ^(SCRPhotoListModel * _Nullable searchResults) {
         SCRStrongSelfStart;
         
         strongSelf.currentSearch.results.pageSize = searchResults.perPage;
         strongSelf.currentSearch.results.totalItems = searchResults.totalItems;
         strongSelf.currentSearch.results.totalPagesAvailable = searchResults.totalPages;
         [strongSelf.currentSearch.results addPageWithData:searchResults.data
                                               pageNumber:searchResults.page];
         
         [strongSelf enumerateListenersWithBlock:^(id  _Nonnull listener, NSUInteger index, BOOL * _Nonnull stop) {
             if ([listener respondsToSelector:@selector(photosController:didPerformSearch:withResults:)]) {
                 [listener photosController:strongSelf
                           didPerformSearch:strongSelf.currentSearch
                                withResults:strongSelf.currentSearch.results];
             }
         }];
         
         SCRStrongSelfEnd;
     } failure:^(NSError * _Nullable error) {
         SCRStrongSelfStart;
         
         [strongSelf.currentSearch setFailed:YES];
         
         [self enumerateListenersWithBlock:^(id  _Nonnull listener, NSUInteger index, BOOL * _Nonnull stop) {
             if ([listener respondsToSelector:@selector(photosController:didFailToPerformSearch:withError:)]) {
                 [listener photosController:strongSelf didFailToPerformSearch:strongSelf.currentSearch withError:error];
             }
         }];
         SCRStrongSelfEnd;
     }];
}

- (SCRPhotoModelWithInfo *)getPhotoInfoForPhoto:(SCRPhotoModel *)photo {
    
    SCRPhotoModelWithInfo *photoWithInfo = [self.photoInfo objectForKey:photo.identifier];
    if (!photoWithInfo) { // need to download info
        
        SCRWeakSelfCreate;
        [[self.commsContext flickrApi]getPhotoInfoForPhotoWithId:photo.identifier
                                                     photoSecret:photo.secret
                                                         success:
         ^(SCRPhotoModelWithInfo * _Nullable photoWithInfo) {
             SCRStrongSelfStart;
             
             [strongSelf.photoInfo setObject:photoWithInfo forKey:photo.identifier];
             
             [strongSelf enumerateListenersWithBlock:^(id  _Nonnull listener, NSUInteger index, BOOL * _Nonnull stop) {
                 if ([listener respondsToSelector:@selector(photosController:didLoadPhotoInfo:)]) {
                     [listener photosController:strongSelf didLoadPhotoInfo:photoWithInfo];
                 }
             }];
             
             SCRStrongSelfEnd;
         } failure:^(NSError * _Nullable error) {
             SCRStrongSelfStart;
             [self enumerateListenersWithBlock:^(id  _Nonnull listener, NSUInteger index, BOOL * _Nonnull stop) {
                 if ([listener respondsToSelector:@selector(photosController:didFailToLoadPhotoInfoForPhoto:withError:)]) {
                     [listener photosController:strongSelf didFailToLoadPhotoInfoForPhoto:photo withError:error];
                 }
             }];
             SCRStrongSelfEnd;
        }];
        
        return nil;
        
    } else { // info already loaded
        return photoWithInfo;
    }
}

- (SCRPagedList<SCRPhotoModel *> *)interestingPhotos {
    if (!_interestingPhotos) {
        _interestingPhotos = [SCRPagedList new];
    }
    return _interestingPhotos;
}

- (NSMutableDictionary<NSString *,SCRPhotoModelWithInfo *> *)photoInfo {
    if (!_photoInfo) {
        _photoInfo = [NSMutableDictionary new];
    }
    return _photoInfo;
}

@end
