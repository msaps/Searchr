//
//  SCRPagedModel.h
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRModel.h"

@interface SCRPagedModel<T> : SCRModel

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger totalPages;
@property (nonatomic, assign) NSInteger perPage;
@property (nonatomic, assign) NSInteger totalItems;

@property (nonatomic, strong) T data;

@end
