//
//  SegmentedControlView.h
//  QHTrade
//
//  Created by user on 2017/7/4.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentedControlView : UIView
@property(nonatomic,copy)void (^itemClick)(int index);
-(instancetype)initWithFrame:(CGRect)frame item:(NSArray *)items;
@property(nonatomic,assign) int selectedIndex;
@property(nonatomic,weak)UIColor *defultTitleColor;//默认标题颜色
@property(nonatomic,weak)UIColor *selectedTitleColor;//选中标题颜色
@property(nonatomic,weak)UIColor *defultBackgroundColor;//默认背景颜色
@property(nonatomic,weak)UIColor *selectedBackgroundColor;//选中背景颜色
@property(nonatomic,assign)CGFloat font;//字号大小
@property(nonatomic,assign)int  oldIndex;
@property(nonatomic,strong) NSArray *titleArray;//字号大小

@property (nonatomic,strong) UIButton *firstBtn;
@property (nonatomic,strong) UIButton *secondBtn;

@end
