//
//  SCRPhotosControllerImpl.m
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRPhotosControllerImpl.h"

@interface SCRPhotosControllerImpl () <SCRRequestDelegate>

@property (nonatomic, strong) SCRRequestGet *request;

@end

@implementation SCRPhotosControllerImpl

- (void)testMethod {
    SCRRequestGet *request = [SCRRequestGet requestWithContext:[self.commsContext flickrContext]
                                                          path:@"flickr.interestingness.getList"];
    self.request = request;
    request.delegate = self;
    [request send];
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary {
    
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError {
    
}

@end
