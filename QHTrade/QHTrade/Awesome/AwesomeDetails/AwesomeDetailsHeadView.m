//
//  AwesomeDetailsHeadView.m
//  QHTrade
//
//  Created by user on 2017/7/4.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "AwesomeDetailsHeadView.h"
#import "AwesomeDetailsViewModel.h"
#import "SegmentedControlView.h"
#import "AwesomeModel.h"

@interface AwesomeDetailsHeadView()
@property(nonatomic,strong) AwesomeDetailsViewModel *viewModel;
@property(nonatomic,strong) UIImageView *icon;//头像
@property(nonatomic,strong) UILabel *awesomeName;//牛人名称
@property(nonatomic,strong) UIImageView *subscribeIcon;//订阅图片
@property(nonatomic,strong) UILabel *subscribeNum;//订阅数量
@property(nonatomic,strong) UIButton *promptBtn;//风险提示
@property(nonatomic,strong) UIImageView *labelImageView;//牛人标签
@property(nonatomic,strong) UILabel *awesomeLabelOne;//标签1
@property(nonatomic,strong) UILabel *awesomeLabelTwo;//标签2
@property(nonatomic,strong) UILabel *awesomeLabelThree;//标签3
@property(nonatomic,strong) UILabel *awesomeLabelFour;//标签4
@property(nonatomic,strong) SegmentedControlView *segmentControl;
@end


@implementation AwesomeDetailsHeadView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (AwesomeDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.icon];
    [self addSubview:self.awesomeName];
    [self addSubview:self.subscribeNum];
    [self addSubview:self.subscribeIcon];
    [self addSubview:self.promptBtn];
    [self addSubview:self.labelImageView];
    [self addSubview:self.awesomeLabelOne];
    [self addSubview:self.awesomeLabelTwo];
    [self addSubview:self.awesomeLabelThree];
    [self addSubview:self.awesomeLabelFour];
    [self addSubview:self.segmentControl];
 
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.top.equalTo(self).with.offset(12);
        make.size.mas_offset(CGSizeMake(35, 35));
    }];
    
    [self.awesomeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(self.icon.mas_right).with.offset(10);
//        make.width.offset(100);
        make.height.offset(15);
    }];
    
    [self.subscribeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.awesomeName.mas_right).with.offset(10);
        make.centerY.equalTo(self.awesomeName);
        make.size.mas_offset(CGSizeMake(8, 12));
    }];
    
    [self.subscribeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subscribeIcon.mas_right).with.offset(4);
        make.centerY.equalTo(self.awesomeName);
        make.size.mas_offset(CGSizeMake(100, 12));
    }];
    
    [self.promptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(10);
        make.top.equalTo(self);
        make.size.mas_offset(CGSizeMake(100, 30));
    }];
    
    [self.labelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).with.offset(10);
        make.top.equalTo(self.awesomeName.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(14, 14));
    }];
    
    [self.awesomeLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labelImageView.mas_right).with.offset(5);
        make.top.equalTo(self.awesomeName.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(50, 14));
    }];
    
    [self.awesomeLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.awesomeLabelOne.mas_right).with.offset(5);
        make.top.equalTo(self.awesomeName.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(50, 14));
    }];
    
    [self.awesomeLabelThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.awesomeLabelTwo.mas_right).with.offset(5);
        make.top.equalTo(self.awesomeName.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(50, 14));
    }];
    
    [self.awesomeLabelFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.awesomeLabelThree.mas_right).with.offset(5);
        make.top.equalTo(self.awesomeName.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(50, 14));
    }];
    
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.icon.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(240, 20));
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.awesomeRefreshUISubject subscribeNext:^(AwesomeModel*  _Nullable model) {
        @strongify(self)
        self.viewModel.model = model;
        [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageLink,model.userImg]] placeholderImage:[UIImage imageNamed:@"touxiang_icon"]];
        self.awesomeName.text = model.userName.length>0? model.userName:@"...";
        self.subscribeNum.text = model.subNumber;
        NSArray *labelArray = [model.labels componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
        for (int i = 0 ;i<labelArray.count;i++) {
            switch (i) {
                case 0:
                    self.awesomeLabelOne.text = labelArray[i];
                    break;
                case 1:
                    self.awesomeLabelTwo.text = labelArray[i];
                    break;
                case 2:
                    self.awesomeLabelThree.text = labelArray[i];
                    break;
                case 3:
                    self.awesomeLabelFour.text = labelArray[i];
                    break;
                default:
                    break;
            }
        }
        CGFloat width = model.nameWidth;
        [self.awesomeName mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(width+10);
        }];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.contentMode = UIViewContentModeScaleToFill;
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 15;
        _icon.image = [UIImage imageNamed:@"touxiang_icon"];
    }
    return _icon;
}

-(UILabel *)awesomeName {
    if (!_awesomeName) {
        _awesomeName = [[UILabel alloc] init];
        _awesomeName.textColor = RGB(66, 66, 66);
        _awesomeName.font = [UIFont systemFontOfSize:15];
    }
    return _awesomeName;
}

-(UIButton *)promptBtn {
    if (!_promptBtn) {
        _promptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_promptBtn setTitle:@"风险揭示" forState:UIControlStateNormal];
        [_promptBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_promptBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        @weakify(self)
        [[_promptBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.viewModel.promptClickSubject sendNext:nil];
        }];
    }
    return _promptBtn;
}

-(UILabel *)subscribeNum {
    if (!_subscribeNum) {
        _subscribeNum = [[UILabel alloc] init];
        _subscribeNum.font = [UIFont systemFontOfSize:12];
        _subscribeNum.textColor = RGB(239, 92, 1);
    }
    return _subscribeNum;
}

-(UIImageView *)subscribeIcon {
    if (!_subscribeIcon) {
        _subscribeIcon = [[UIImageView alloc] init];
        [_subscribeIcon setImage:[UIImage imageNamed:@"Awesome_subscribeNum_icon"]];
    }
    return _subscribeIcon;
}

-(UIImageView *)labelImageView {
    if (!_labelImageView) {
        _labelImageView = [[UIImageView alloc] init];
        _labelImageView.image = [UIImage imageNamed:@"Awesome_Label"];
    }
    return _labelImageView;
}

-(UILabel *)awesomeLabelOne {
    if (!_awesomeLabelOne) {
        _awesomeLabelOne = [self creatLabelWithStyle];
        _awesomeLabelOne.text = @"一二三四";
    }
    return _awesomeLabelOne;
}
-(UILabel *)awesomeLabelTwo {
    if (!_awesomeLabelTwo) {
        _awesomeLabelTwo = [self creatLabelWithStyle];
        _awesomeLabelTwo.text = @"一二三四";
    }
    return _awesomeLabelTwo;
}
-(UILabel *)awesomeLabelThree {
    if (!_awesomeLabelThree) {
        _awesomeLabelThree = [self creatLabelWithStyle];
        _awesomeLabelThree.text = @"一二三四";
    }
    return _awesomeLabelThree;
}
-(UILabel *)awesomeLabelFour {
    if (!_awesomeLabelFour) {
        _awesomeLabelFour = [self creatLabelWithStyle];
        _awesomeLabelFour.text = @"一二三四";
    }
    return _awesomeLabelFour;
}

-(SegmentedControlView *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[SegmentedControlView alloc] initWithFrame:CGRectMake(0, 0, 240, 20) item:[NSArray arrayWithObjects:@"牛人简介",@"交易分析",@"牛人评价", nil]];
        _segmentControl.defultTitleColor = RGB(151, 150, 150);
        _segmentControl.selectedTitleColor = [UIColor whiteColor];
        _segmentControl.defultBackgroundColor = [UIColor whiteColor];
        _segmentControl.selectedBackgroundColor = RGB(239, 92, 1);
        _segmentControl.layer.masksToBounds = YES;
        _segmentControl.layer.cornerRadius = 10;
        _segmentControl.layer.borderWidth = 0.5f;
        _segmentControl.layer.borderColor = RGB(150, 150, 150).CGColor;
        @weakify(self)
        _segmentControl.itemClick = ^(int index) {
          @strongify(self)
            [self.viewModel.switchSegmentedSubject sendNext:[NSString stringWithFormat:@"%d",index]];
        };
    }
    return _segmentControl;
}

-(UILabel *)creatLabelWithStyle {
    UILabel *title = [[UILabel alloc] init];
    title.layer.borderWidth = 0.5f;
    title.layer.borderColor = RGB(239, 92, 1).CGColor;
    title.layer.masksToBounds = YES;
    title.layer.cornerRadius = 3;
    title.font = [UIFont systemFontOfSize:12];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = RGB(239, 92, 1);
    return title;
}
@end
