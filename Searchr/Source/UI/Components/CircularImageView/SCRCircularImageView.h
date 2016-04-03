//
//  SCRCircularImageView.h
//  Searchr
//
//  Created by Merrick Sapsford on 03/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface SCRCircularImageView : UIImageView

@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

@end
