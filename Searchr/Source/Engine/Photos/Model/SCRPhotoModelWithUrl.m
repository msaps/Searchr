//
//  SCRPhotoModelWithUrl.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRPhotoModelWithUrl.h"

NSString *const kSCRPhotoModelWithUrlFarmIdFormat = @"{farm-id}";
NSString *const kSCRPhotoModelWithUrlServerIdFormat = @"{server-id}";
NSString *const kSCRPhotoModelWithUrlIdFormat = @"{id}";
NSString *const kSCRPhotoModelWithUrlApiSecretFormat = @"{o-secret}";
NSString *const kSCRPhotoModelWithUrlSizeFormat = @"{size}";
NSString *const kSCRPhotoModelWithUrlFileFormat = @"{format}";

@interface SCRPhotoModelWithUrl ()

@property (nonatomic, strong) SCRConfig *config;

@end

@implementation SCRPhotoModelWithUrl

#pragma mark - Init

+ (instancetype)photoModelWithModel:(SCRPhotoModel *)photoModel
                             config:(nonnull SCRConfig *)config {
    return [[[self class]alloc]initWithModel:photoModel
                                      config:config];
}

- (instancetype)initWithModel:(SCRPhotoModel *)photoModel
                       config:(nonnull SCRConfig *)config {
    if (self = [super init]) {
        _photoModel = photoModel;
        _config = config;
        if (photoModel) {
            [self buildUrl];
        }
    }
    if (_photoModel) {
        return self;
    }
    return nil;
}

#pragma mark - Public

- (void)setPhotoSize:(SCRPhotoModelPhotoSize)photoSize {
    _photoSize = photoSize;
    [self buildUrl];
}

#pragma mark - Internal

- (void)buildUrl {
    NSMutableString *urlString = [self.config.flickrImageUrlFormat mutableCopy];
    
    [urlString replaceOccurrencesOfString:kSCRPhotoModelWithUrlFarmIdFormat
                               withString:[NSString stringWithFormat:@"%li", self.photoModel.farm]
                                  options:NSLiteralSearch range:NSMakeRange(0, urlString.length)];
    [urlString replaceOccurrencesOfString:kSCRPhotoModelWithUrlServerIdFormat
                               withString:[NSString stringWithFormat:@"%li", self.photoModel.server]
                                  options:NSLiteralSearch range:NSMakeRange(0, urlString.length)];
    [urlString replaceOccurrencesOfString:kSCRPhotoModelWithUrlIdFormat
                               withString:self.photoModel.identifier
                                  options:NSLiteralSearch range:NSMakeRange(0, urlString.length)];
    [urlString replaceOccurrencesOfString:kSCRPhotoModelWithUrlApiSecretFormat
                               withString:self.photoModel.secret
                                  options:NSLiteralSearch range:NSMakeRange(0, urlString.length)];
    [urlString replaceOccurrencesOfString:kSCRPhotoModelWithUrlSizeFormat
                               withString:[self photoSizeStringForSize:self.photoSize]
                                  options:NSLiteralSearch range:NSMakeRange(0, urlString.length)];
    [urlString replaceOccurrencesOfString:kSCRPhotoModelWithUrlFileFormat
                               withString:[self photoFormatStringForFormat:self.photoFormat]
                                  options:NSLiteralSearch range:NSMakeRange(0, urlString.length)];
    
    _photoUrl = [NSURL URLWithString:urlString];
}

- (NSString *)photoSizeStringForSize:(SCRPhotoModelPhotoSize)size {
    switch (size) {
        case SCRPhotoModelPhotoSizeSmallSquare:
            return @"s";
            
        case SCRPhotoModelPhotoSizeLargeSquare:
            return @"q";
            
        case SCRPhotoModelPhotoSizeThumbnail:
            return @"t";
         
        case SCRPhotoModelPhotoSizeSmall:
            return @"n";
            
        case SCRPhotoModelPhotoSizeMedium:
            return @"z";
            
        case SCRPhotoModelPhotoSizeLarge:
            return @"b";
            
        case SCRPhotoModelPhotoSizeExtraLarge:
            return @"k";
    }
    return @"";
}

- (NSString *)photoFormatStringForFormat:(SCRPhotoModelPhotoFormat)format {
    switch (format) {
        case SCRPhotoModelPhotoFormatGIF:
            return @".gif";
            
        case SCRPhotoModelPhotoFormatPNG:
            return @".png";
            
        case SCRPhotoModelPhotoFormatJPEG:
            return @".jpg";
            
        default:break;
    }
}

@end
