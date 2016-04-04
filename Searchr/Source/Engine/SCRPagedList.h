//
//  SCRPagedList.h
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCRPagedList<T> : NSObject

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger totalPagesAvailable;

@property (nonatomic, strong, nullable) NSArray<T> *data;

+ (nullable instancetype)pagedListWithData:(nullable T)data pageSize:(NSInteger)pageSize currentPage:(NSInteger)currentPage;

- (void)addPageWithData:(nullable T)data pageNumber:(NSInteger)page;

- (void)removeAllData;

@end
