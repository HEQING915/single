//
//  HCustomAlterView.m
//  HCustomAlterView
//
//  Created by 何青 on 2018/1/9.
//  Copyright © 2018年 何青. All rights reserved.
//

#import "HCustomAlterView.h"
#import "UIView+FLExtension.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define CornerRadius 4
#define leftW 15
#define btnW 35
@implementation HCustomAlterView

- (UILabel *)createLableWithFrame:(CGRect)frame font:(CGFloat)font  textColor:(UIColor *)color bgColor:(UIColor *)bgColor  textAlignment:(NSTextAlignment)textAlignment{
    UILabel *lb = [[UILabel alloc] initWithFrame:frame];
    lb.textColor = color;
    lb.font = [UIFont systemFontOfSize:font];
    lb.backgroundColor = bgColor;
    lb.textAlignment = textAlignment;
    lb.numberOfLines = 0;
    return lb;
}

- (UIButton *)createButtonWithFrame:(CGRect)frame font:(CGFloat)font textColor:(UIColor *)color bgColor:(UIColor *)bgcolor{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = frame;
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.backgroundColor = bgcolor;
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    btn.layer.borderWidth = 0.5f;
    btn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    btn.layer.cornerRadius = CornerRadius;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

-(instancetype _Nullable )initWithTitle:(NSString *_Nullable)title message:(nullable NSString *)message delegate:(nullable id)delegate ButtonTitles:(nullable NSString *)otherButtonTitles, ...{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        va_list params;
        id argument;
        if (otherButtonTitles) {
            va_start(params, otherButtonTitles);
            [arr addObject:otherButtonTitles];
            while ((argument = va_arg(params, id))) {//返回参数列表中指针arg_ptr所指的参数，返回类型为type，并使指针arg_ptr指向参数列表中下一个参数
                [arr addObject:argument];
            }
            va_end(params);//释放列表指针
            _delegate = delegate;
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
            
            _contentView = [[UIView alloc] initWithFrame:CGRectMake(40, 0, ScreenWidth - 80, 200)];
            _contentView.backgroundColor = [UIColor whiteColor];
            _contentView.layer.cornerRadius = CornerRadius;
            _contentView.layer.masksToBounds = YES;
            [self addSubview:_contentView];
            
            UILabel *titleLb = [self createLableWithFrame:CGRectMake(leftW, 10, _contentView.width-leftW*2, 30) font:16 textColor:[UIColor blackColor] bgColor:[UIColor clearColor] textAlignment:NSTextAlignmentCenter];
            titleLb.text = title;
            [_contentView addSubview:titleLb];
            
            UILabel *messageLb = [self createLableWithFrame:CGRectMake(leftW, titleLb.bottom + 5, _contentView.width - leftW*2, 30) font:14 textColor:[UIColor darkGrayColor] bgColor:[UIColor clearColor] textAlignment:NSTextAlignmentLeft];
            messageLb.text = message;
            [messageLb sizeToFit];
            [_contentView addSubview:messageLb];
            
            CGFloat bottom = messageLb.bottom;
          if (arr.count == 2){
                UIButton *btn = [self createButtonWithFrame:CGRectMake(leftW, messageLb.bottom +10, (_contentView.width - leftW*2-5)/2, btnW) font:15 textColor:[UIColor darkGrayColor] bgColor:[UIColor whiteColor]];
                btn.tag = 10;
                [btn setTitle:arr[0] forState:UIControlStateNormal];
                [_contentView addSubview:btn];
                
                UIButton *btn1 = [self createButtonWithFrame:CGRectMake(btn.right + 5, messageLb.bottom +10, (_contentView.width - leftW*2-5)/2, btnW) font:15 textColor:[UIColor darkGrayColor] bgColor:[UIColor whiteColor]];
                btn1.tag = 11;
                [btn1 setTitle:arr[1] forState:UIControlStateNormal];
                [_contentView addSubview:btn1];
              bottom = btn1.bottom;
            }else{
                for (int i =0; i < arr.count; i++) {
                    UIButton *btn = [self createButtonWithFrame:CGRectMake(leftW, messageLb.bottom + (5+btnW)*i+10, _contentView.width - leftW *2, btnW) font:15 textColor:[UIColor darkGrayColor] bgColor:[UIColor whiteColor]];
                    [btn setTitle:arr[i] forState:UIControlStateNormal];
                    btn.tag = 10+i;
                    [_contentView addSubview:btn];
                    bottom = btn.bottom;
                }
            }
            _contentView.height = bottom + 15;
            _contentView.top = ScreenHeight/2 - _contentView.height/2;
            _contentView.transform = CGAffineTransformMakeScale(0, 0);
        }
    }
    return self;
}

- (instancetype _Nullable )initWithTitle:(NSString *_Nullable)title contentView:(UIView *_Nullable)contentView{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(40, 0, ScreenWidth - 80, 200)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = CornerRadius;
        _contentView.layer.masksToBounds = YES;
        [self addSubview:_contentView];
        
        UILabel *titleLb = [self createLableWithFrame:CGRectMake(leftW, 10, _contentView.width-leftW*2, 30) font:16 textColor:[UIColor blackColor] bgColor:[UIColor clearColor] textAlignment:NSTextAlignmentCenter];
        titleLb.text = title;
        [_contentView addSubview:titleLb];
        
        UIView *labMsg = [[UIView alloc] initWithFrame:CGRectMake(leftW, titleLb.bottom+10, _contentView.width-leftW*2, contentView.height)];
        [labMsg addSubview:contentView];
        [_contentView addSubview:labMsg];

        _contentView.height = labMsg.bottom + 15;
        _contentView.top = ScreenHeight/2 - _contentView.height/2;
        
        UILabel *line = [self createLableWithFrame:CGRectMake(ScreenWidth/2, _contentView.bottom, 1, 40) font:12 textColor:[UIColor whiteColor] bgColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
        [self addSubview:line];
        
        UIButton *cancleBtn = [self createButtonWithFrame:CGRectMake((ScreenWidth - 30)/2, line.bottom, 30, 30) font:14 textColor:[UIColor lightGrayColor] bgColor:[UIColor whiteColor]];
        [cancleBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [self addSubview:cancleBtn];
        
    }
    return self;
}

- (void)showInWindow{
//    [[UIApplication sharedApplication].keyWindow addSubview:self];
//    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        _contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
//    } completion:^(BOOL finished) {
//
//    }];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.98, 0.98, 0.98)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    [self.layer addAnimation:animation forKey:nil];
}

- (void)showInView:(UIView *_Nullable)view{
    [view addSubview:self];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
//    [view addSubview:self];
//    CAKeyframeAnimation * animation;
//    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    animation.duration = 0.3;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    NSMutableArray *values = [NSMutableArray array];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.98, 0.98, 0.98)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
//    animation.values = values;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
//    [self.layer addAnimation:animation forKey:nil];
}

- (void)cancle{
    [UIView animateWithDuration:0.5 animations:^{
        _contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        _contentView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)clickBtnAction:(UIButton *)sender{
    [self cancle];
    if ([self.delegate respondsToSelector:@selector(HCustomAlterView:clickedButtonAtIndex:)]) {
        [self.delegate HCustomAlterView:self clickedButtonAtIndex:sender.tag];
    }
}

@end
