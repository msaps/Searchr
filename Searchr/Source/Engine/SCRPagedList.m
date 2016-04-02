//
//  SCRPagedList.m
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRPagedList.h"

@interface SCRPagedList<T> () {
    NSMutableArray<T> *_data;
}
@end

@implementation SCRPagedList

#pragma mark - Init

+ (instancetype)pagedListWithData:(id)data pageSize:(NSInteger)pageSize currentPage:(NSInteger)currentPage {
    return [[[self class]alloc]initListWithData:data pageSize:pageSize currentPage:currentPage];
}

- (instancetype)initListWithData:(id)data pageSize:(NSInteger)pageSize currentPage:(NSInteger)currentPage {
    if (self = [super init]) {
        _page = currentPage;
        _pageSize = pageSize;
        _data = [[NSMutableArray alloc]initWithArray:data];
    }
    return self;
}

#pragma mark - Public

- (void)addPageWithData:(id)data pageNumber:(NSInteger)page {
    [_data addObjectsFromArray:data];
    self.page = page;
}

@end
