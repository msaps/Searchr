//
//  UIView+SCRKeyboardDismiss.h
//  Searchr
//
//  Created by Merrick Sapsford on 04/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIView (SCRKeyboardDismiss) <UIGestureRecognizerDelegate>

@property (nonatomic, assign) IBInspectable BOOL canDismissKeyboard;

- (void)becomeKeyboardDismissalResponder;

- (void)resignFirstResponderWithCompletion:(void (^) (BOOL resigned))completion;

@end
