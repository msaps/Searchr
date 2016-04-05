//
//  SCRPhotoDatesModel.h
//  Searchr
//
//  Created by Merrick Sapsford on 03/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRModel.h"

@interface SCRPhotoDatesModel : SCRModel

@property (nonatomic, strong, nullable) NSDate *lastUpdated;
@property (nonatomic, strong, nullable) NSDate *posted;
@property (nonatomic, strong, nullable) NSDate *taken;
@property (nonatomic, assign) NSInteger takenGranularity;
@property (nonatomic, assign, getter=takenIsUnknown) BOOL takenUnknown;

@end
