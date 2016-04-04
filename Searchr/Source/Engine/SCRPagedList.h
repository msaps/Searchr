//
//  SCRPagedList.h
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCRPagedList<T> : NSObject

/**
 The current page of the paged list.
 */
@property (nonatomic, assign) NSInteger page;
/**
 The size of items in each page.
 */
@property (nonatomic, assign) NSInteger pageSize;
/**
 The total number of available pages
 */
@property (nonatomic, assign) NSInteger totalPagesAvailable;

/**
 Data in the paged list.
 */
@property (nonatomic, strong, nullable) NSArray<T> *data;

/**
 Create a paged list with a page of data.
 */
+ (nullable instancetype)pagedListWithData:(nullable T)data pageSize:(NSInteger)pageSize currentPage:(NSInteger)currentPage;
/**
 Add a page of data to the paged list.
 */
- (void)addPageWithData:(nullable T)data pageNumber:(NSInteger)page;
/**
 Clear all data from the paged list.
 */
- (void)removeAllData;

@end
