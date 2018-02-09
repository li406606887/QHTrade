//
//  MycontractSegmentcontrolView.m
//  QHTrade
//
//  Created by user on 2017/6/26.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "MycontractSegmentcontrolView.h"
#import "MyContractViewModel.h"

@interface MycontractSegmentcontrolView()
@property(nonatomic,strong)MyContractViewModel *viewModel;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSMutableArray *buttonArray;
@property(nonatomic,assign)int oldIndex;
@end

@implementation MycontractSegmentcontrolView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (MyContractViewModel*)viewModel;

    return [super initWithViewModel:viewModel];
}
-(void)setupViews{
    for (int i = 0 ; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = RGB(239, 240, 241);
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        button.showsTouchWhenHighlighted = NO;
        [button addTarget:self action:@selector(buttonClickWithTag:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"Dynamics_MyContract_segment_selected"] forState:UIControlStateSelected];
        [button setTitleColor:RGB(164, 165, 166) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.tag = i;
        [self addSubview:button];
        if (i==0)button.selected = YES;
        @weakify(self)
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self);
            make.left.equalTo(self).with.offset(SCREEN_WIDTH*0.25*i);
            make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.25, 30));
        }];
        [self.buttonArray addObject:button];
    }
}
-(void)buttonClickWithTag:(UIButton *)button{
    
    [self.viewModel.segmentControlClickSubject sendNext:[NSString stringWithFormat:@"%ld",button.tag]];
    button.selected = !button.selected;
    UIButton *oldButton = self.buttonArray[self.oldIndex];
    oldButton.selected = !button.selected;
    self.oldIndex = (int)button.tag;
}
-(int)oldIndex{
    if (!_oldIndex) {
        _oldIndex = 0;
    }
    return _oldIndex;
}
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [[NSArray alloc] initWithObjects:@"持仓",@"挂单",@"委托",@"成交", nil];
    }
    return _titleArray;
}
-(NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

@end
