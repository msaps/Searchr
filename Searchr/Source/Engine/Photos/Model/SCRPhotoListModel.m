//
//  SCRPopularPhotosModel.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRPhotoListModel.h"

NSString *const kSCRPhotoListModelPhotosKey = @"photos";
NSString *const kSCRPhotoListModelPageKey = @"page";
NSString *const kSCRPhotoListModelPagesKey = @"pages";
NSString *const kSCRPhotoListModelPerPageKey = @"perpage";
NSString *const kSCRPhotoListModelPhotoArrayKey = @"photo";

@implementation SCRPhotoListModel

- (void)evaluateDataDictionary:(NSDictionary *)dictionary {
    NSDictionary *data = dictionary[kSCRPhotoListModelPhotosKey];
    
    self.page = [data[kSCRPhotoListModelPageKey]integerValue];
    self.totalPages = [data[kSCRPhotoListModelPagesKey]integerValue];
    self.perPage = [data[kSCRPhotoListModelPerPageKey]integerValue];
    
    NSArray *photos = data[kSCRPhotoListModelPhotoArrayKey];
    NSMutableArray *photoModels = [NSMutableArray new];
    for (NSDictionary *photoDictionary in photos) {
        SCRPhotoModel *photoModel = [SCRPhotoModel modelWithDictionary:photoDictionary];
        [photoModels addObject:photoModel];
    }
    self.data = photoModels;
}

@end
