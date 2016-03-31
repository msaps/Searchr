//
//  SCRCommsContext.h
//  Searchr
//
//  Created by Merrick Sapsford on 31/03/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objectiveflickr/ObjectiveFlickr.h>

@protocol SCRCommsContext <NSObject>

@property (nonatomic, strong, readonly) OFFlickrAPIContext *flickrContext;

@end

