//
//  SegmentedControlView.m
//  QHTrade
//
//  Created by user on 2017/7/4.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "SegmentedControlView.h"

#define kWidth self.size.width
#define kHeight self.size.height
#define kCount self.titleArray.count

@interface SegmentedControlView()
@property(nonatomic,strong) UIView  *segmentedView;
@property(nonatomic,strong) NSMutableArray *btnArray;
@end

@implementation SegmentedControlView

-(instancetype)initWithFrame:(CGRect)frame item:(NSArray *)items{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.titleArray = items;
        [self addSubview:self.segmentedView];
        
    }
    return self;
}

-(UIView *)segmentedView{
    if (!_segmentedView) {
        _segmentedView = [[UIView alloc] initWithFrame:self.frame];
        for (int i = 0; i<self.titleArray.count; i++) {
            UIButton *button = [self buttonWithTitle:self.titleArray[i]];
            button.tag = i;
            button.frame = CGRectMake(kWidth/kCount*i-0.5+i*0.5, 0, kWidth/kCount, kHeight);
            button.selected = i == 0 ? YES:NO;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                self.firstBtn = button;
            }else self.secondBtn = button;
            [_segmentedView addSubview:button];
            [self.btnArray addObject:button];
        }
    }
    return _segmentedView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor {
    for ( UIButton *btn in self.btnArray) {
        [btn setBackgroundColor:selectedBackgroundColor forState:UIControlStateSelected];
    }
}

-(void)setDefultBackgroundColor:(UIColor *)defultBackgroundColor {
    for ( UIButton *btn in self.btnArray) {
        [btn setBackgroundColor:defultBackgroundColor forState:UIControlStateNormal];
    }
}

-(void)setDefultTitleColor:(UIColor *)defultTitleColor {
    for ( UIButton *btn in self.btnArray) {
        [btn setTitleColor:defultTitleColor forState:UIControlStateNormal];
    }
}

-(void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    for (UIButton *btn in self.btnArray) {
        [btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
}

-(UIButton *)buttonWithTitle:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setAdjustsImageWhenHighlighted:NO];
    button.titleLabel.numberOfLines = 0;
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage createImageWithColor:DEFAULT_COLOR] forState:UIControlStateSelected];
    return button;
}

-(void)buttonClick:(UIButton*)button{
    if((int)button.tag == self.oldIndex) return;
    UIButton*oldButton = self.btnArray[self.oldIndex];
    oldButton.selected = NO;
    button.selected = YES;
    self.oldIndex = (int)button.tag;
    if (self.itemClick) {
        self.itemClick(self.oldIndex);
    }
}

-(void)setSelectedIndex:(int)selectedIndex {
    UIButton*oldButton = self.btnArray[self.oldIndex];
    oldButton.selected = NO;
    UIButton*newButton = self.btnArray[selectedIndex];;
    newButton.selected = YES;
    self.oldIndex = selectedIndex;
}



-(int)oldIndex{
    if (!_oldIndex) {
        _oldIndex = 0;
    }
    return _oldIndex;
}

-(NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}

@end
