//
//  HCustomAlterView.h
//  HCustomAlterView
//
//  Created by 何青 on 2018/1/9.
//  Copyright © 2018年 何青. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCustomAlterView ;

@protocol HCustomAlterViewDelegate <NSObject>
@optional
- (void)HCustomAlterView:(HCustomAlterView *_Nullable)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface HCustomAlterView : UIView

@property (nonatomic, assign) id <HCustomAlterViewDelegate> delegate;
@property (nonatomic, strong) UIView *contentView;
-(instancetype _Nullable )initWithTitle:(NSString *_Nullable)title message:(nullable NSString *)message delegate:(nullable id)delegate ButtonTitles:(nullable NSString *)otherButtonTitles, ...;

- (instancetype _Nullable )initWithTitle:(NSString *_Nullable)title contentView:(UIView *_Nullable)contentView;

- (void)showInWindow;

- (void)showInView:(UIView *_Nullable)view;

- (void)cancle;

@end
