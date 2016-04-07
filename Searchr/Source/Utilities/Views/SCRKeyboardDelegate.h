//
//  SCRKeyboardDelegate.h
//  Searchr
//
//  Created by Merrick Sapsford on 07/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCRKeyboardDelegate;

NS_ASSUME_NONNULL_BEGIN
@interface SCRKeyboardUpdate : NSObject

@property (nonatomic, assign, readonly) CGRect beginFrame;
@property (nonatomic, assign, readonly) CGRect endFrame;

@property (nonatomic, assign, readonly) CGFloat animationDuration;
@property (nonatomic, assign, readonly) UIViewAnimationCurve animationCurve;

@property (nonatomic, assign, readonly) BOOL isLocal;

+ (instancetype)updateWithDictionary:(NSDictionary *)updateDictionary;

@end

@protocol SCRKeyboardDelegate <NSObject>
@optional

- (void)keyboardDelegate:(SCRKeyboardDelegate *)delegate willShowKeyboardWithUpdate:(SCRKeyboardUpdate *)update;

- (void)keyboardDelegate:(SCRKeyboardDelegate *)delegate didShowKeyboardWithUpdate:(SCRKeyboardUpdate *)update;

- (void)keyboardDelegate:(SCRKeyboardDelegate *)delegate willHideKeyboardWithUpdate:(SCRKeyboardUpdate *)update;

- (void)keyboardDelegate:(SCRKeyboardDelegate *)delegate didHideKeyboardWithUpdate:(SCRKeyboardUpdate *)update;

@end

@interface SCRKeyboardDelegate : NSObject

@property (nonatomic, weak, readonly) id<SCRKeyboardDelegate> responder;

+ (instancetype)keyboardDelegateForResponder:(id<SCRKeyboardDelegate>)responder;

@end
NS_ASSUME_NONNULL_END
