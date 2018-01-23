//
//  ViewController.m
//  HCustomAlterView
//
//  Created by 何青 on 2018/1/9.
//  Copyright © 2018年 何青. All rights reserved.
//

#import "ViewController.h"
#import "HCustomAlterView.h"
#import "UIView+FLExtension.h"

@interface ViewController ()<HCustomAlterViewDelegate>
{
    HCustomAlterView *alter;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickbtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(100, 200, 100, 40);
    [btn1 setTitle:@"点我" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clickbtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

- (void)clickbtn{
    alter = [[HCustomAlterView alloc] initWithTitle:@"温馨提示" message:@"这是一个弹框,这是一个弹框,这是一个弹框,这是一个弹框" delegate:self ButtonTitles:@"我知道了",nil];
    [alter showInView:self.view];
}


- (void)clickbtn1{
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 110, 100)];
    CGFloat w = (contentView.width - 20)/3;
    for (int i = 0; i<3; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5+(w+5)*i, 5, w, w*1.2)];
        btn.backgroundColor = [UIColor cyanColor];
        [contentView addSubview:btn];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:btn];
    }
    
    UILabel *textlb = [[UILabel  alloc] initWithFrame:CGRectMake(0, w*1.2+10, contentView.width, 40)];
    textlb.font = [UIFont systemFontOfSize:13];
    textlb.attributedText = [self getAttributedStringWithString:@"活动说明：\n1、每天限抽奖一次；\n2、奖品：新年时长*7、代金券、金币等；\n3、活动时间：大年初一到十五" lineSpace:6];
    textlb.numberOfLines = 0;
    CGSize size = [textlb.text sizeWithFont:textlb.font constrainedToSize:CGSizeMake(contentView.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    textlb.textColor = [UIColor darkGrayColor];
    textlb.height = size.height+30;
    [contentView addSubview:textlb];
    contentView.height = textlb.bottom + 10;
    
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 110 , 100)];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myTap)];
//    [imgView addGestureRecognizer:tap];
//    imgView.userInteractionEnabled = YES;
//    imgView.backgroundColor = [UIColor cyanColor];
    alter = [[HCustomAlterView alloc] initWithTitle:@"新年大抽奖" contentView:contentView];
    [alter showInWindow];
}

- (void)selectAction:(UIButton *)sender{
    
}

- (void)myTap{
    [alter cancle];
}

#pragma mark - HCustomAlterViewDelegate

- (void)HCustomAlterView:(HCustomAlterView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"index ===== %ld",buttonIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;
}

@end
