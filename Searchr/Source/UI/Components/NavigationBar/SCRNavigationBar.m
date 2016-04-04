//
//  SCRNavigationBar.m
//  Searchr
//
//  Created by Merrick Sapsford on 04/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import "SCRNavigationBar.h"
#import "UIColor+SCRColorPalette.h"

@implementation SCRNavigationBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:19.0f weight:UIFontWeightLight],
                                 NSForegroundColorAttributeName : [UIColor scr_flickrPink]};
    self.tintColor = [UIColor scr_flickrBlue];
}

@end
