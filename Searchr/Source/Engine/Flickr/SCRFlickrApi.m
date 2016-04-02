//
//  SCRPhotosApi.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRFlickrApi.h"

NSString *const kSCRFlickrApiParameterPerPageKey = @"per_page";
NSString *const kSCRFlickrApiParameterPageKey = @"page";

@interface SCRFlickrApi ()

@property (nonatomic, strong) OFFlickrAPIContext *flickrContext;

@property (nonatomic, strong) SCRRequest *interestingPhotosRequest;
@property (nonatomic, strong) SCRRequest *searchRequest;

@end

@implementation SCRFlickrApi

#pragma mark - Init

- (instancetype)initWithFlickrContext:(OFFlickrAPIContext *)flickrContext {
    if (self = [super init]) {
        _flickrContext = flickrContext;
    }
    return self;
}

#pragma mark - Public

- (SCRRequest *)getInterestingPhotosWithPage:(NSInteger)page
                                    pageSize:(NSInteger)pageSize
                                     success:(SCRFlickrApiPopularPhotoSuccessBlock)success
                                     failure:(SCRFlickrApiFailureBlock)failure {
    
    if (!self.interestingPhotosRequest.isRunning) {
        NSDictionary *parameters = @{kSCRFlickrApiParameterPerPageKey : @(pageSize),
                                     kSCRFlickrApiParameterPageKey : @(page)};
        
        _interestingPhotosRequest = [SCRRequest requestOfType:SCRRequestTypeGet
                                                  withContext:self.flickrContext
                                                         path:@"flickr.interestingness.getList"
                                                   parameters:parameters
                                                      success:
                                     ^(NSDictionary * _Nullable responseData) {
                                         SCRPhotoListModel *model = [SCRPhotoListModel modelWithDictionary:responseData];
                                         if (model && success) {
                                             success(model);
                                         }
                                     }
                                                      failure:
                                     ^(NSError * _Nullable error) {
                                         if (failure) {
                                             failure(error);
                                         }
                                     }];
        return _interestingPhotosRequest;
    }
    return nil;
}

- (SCRRequest *)getSearchResultsForParameters:(NSDictionary *)parameters
                                         page:(NSInteger)page
                                     pageSize:(NSInteger)pageSize
                                      success:(SCRFlickrApiSearchResultsSuccessBlock)success
                                      failure:(SCRFlickrApiFailureBlock)failure {
    if (!self.searchRequest.isRunning) {
        
        NSMutableDictionary *actualParameters = [NSMutableDictionary dictionary];
        [actualParameters addEntriesFromDictionary:parameters];
        [actualParameters addEntriesFromDictionary:@{
                                                     kSCRFlickrApiParameterPerPageKey : @(pageSize),
                                                     kSCRFlickrApiParameterPageKey : @(page)
                                                     }];
        
        _searchRequest = [SCRRequest requestOfType:SCRRequestTypeGet
                                       withContext:self.flickrContext
                                              path:@"flickr.photos.search"
                                        parameters:actualParameters
                                           success:
                          ^(NSDictionary * _Nullable responseData) {
                              SCRPhotoListModel *model = [SCRPhotoListModel modelWithDictionary:responseData];
                              if (model && success) {
                                  success(model);
                              }
                          }
                                           failure:
                          ^(NSError * _Nullable error) {
                              if (failure) {
                                  failure(error);
                              }
                          }];
        return _searchRequest;
    }
    return nil;
}

@end
