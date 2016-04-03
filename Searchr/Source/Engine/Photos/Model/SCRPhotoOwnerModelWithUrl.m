//
//  SCRPhotoOwnerModelWithUrl.m
//  Searchr
//
//  Created by Merrick Sapsford on 03/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRPhotoOwnerModelWithUrl.h"

NSString *const kSCRPhotoOwnerModelWithUrlIconFarmFormat = @"{icon-farm}";
NSString *const kSCRPhotoOwnerModelWithUrlIconServerFormat = @"{icon-server}";
NSString *const kSCRPhotoOwnerModelWithUrlOwnerNsidFormat = @"{nsid}";

@interface SCRPhotoOwnerModelWithUrl ()

@property (nonatomic, strong) SCRConfig *config;

@end

@implementation SCRPhotoOwnerModelWithUrl

#pragma mark - Init

+ (instancetype)photoOwnerModelWithModel:(SCRPhotoOwnerModel *)photoOwnerModel
                                  config:(SCRConfig *)config {
    return [[[self class]alloc]initWithPhotoOwnerModel:photoOwnerModel
                                                config:config];
}

- (instancetype)initWithPhotoOwnerModel:(SCRPhotoOwnerModel *)photoOwnerModel
                                 config:(SCRConfig *)config {
    if (photoOwnerModel && config) {
        if (self = [super init]) {
            _config = config;
            _photoOwnerModel = photoOwnerModel;
            [self buildUrl];
        }
        return self;
    }
    return nil;
}

#pragma mark - Internal

- (void)buildUrl {
    NSString *urlString;
    if (self.photoOwnerModel.iconServer > 0) {
        NSMutableString *urlFormat = [self.config.flickrBuddyIconUrlFormat mutableCopy];
        
        [urlFormat replaceOccurrencesOfString:kSCRPhotoOwnerModelWithUrlIconFarmFormat
                                   withString:[NSString stringWithFormat:@"%li", self.photoOwnerModel.iconFarm]
                                      options:NSLiteralSearch range:NSMakeRange(0, urlFormat.length)];
        [urlFormat replaceOccurrencesOfString:kSCRPhotoOwnerModelWithUrlIconServerFormat
                                   withString:[NSString stringWithFormat:@"%li", self.photoOwnerModel.iconServer]
                                      options:NSLiteralSearch range:NSMakeRange(0, urlFormat.length)];
        [urlFormat replaceOccurrencesOfString:kSCRPhotoOwnerModelWithUrlOwnerNsidFormat
                                   withString:self.photoOwnerModel.identifier
                                      options:NSLiteralSearch range:NSMakeRange(0, urlFormat.length)];
        urlString = urlFormat;
        
    } else {
        urlString = self.config.flickrBuddyIconDefaultUrl;
    }
    _iconUrl = [NSURL URLWithString:urlString];
}

@end
