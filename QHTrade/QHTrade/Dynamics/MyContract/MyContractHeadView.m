//
//  MyContractHeadView.m
//  QHTrade
//
//  Created by user on 2017/6/21.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "MyContractHeadView.h"
#import "MycontractSegmentcontrolView.h"
#import "MyContractViewModel.h"



@interface MyContractHeadView()
@property(nonatomic,strong)UIView *searchView;
@property(nonatomic,strong)UIView *leftFieldView;//左边输入框view
@property(nonatomic,strong)UIView *rightLabelView;//右边labelView
@property(nonatomic,strong)UIView *operationView;//中间操作按钮view
@property(nonatomic,strong)UITabBar *tabbar;
@property(nonatomic,strong)MycontractSegmentcontrolView *typeSementedControl;//操作类别
@property(nonatomic,strong)MyContractViewModel *viewModel;
@end


@implementation MyContractHeadView


-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{

    self.viewModel = (MyContractViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews{
    [self addSubview:self.searchView];
    [self addSubview:self.leftFieldView];
    [self addSubview:self.rightLabelView];
    [self addSubview:self.operationView];
    [self addSubview:self.typeSementedControl];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints{
    [super updateConstraints];
    @weakify(self)
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(10);
        make.size.mas_offset(CGSizeMake(175, 30));
    }];
    [self.leftFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self);
        make.top.equalTo(self.searchView.mas_bottom);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.5, 90));
    }];
    [self.rightLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self);
        make.top.equalTo(self.searchView.mas_bottom);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.5, 90));
    }];
    
    [self.operationView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self);
        make.top.equalTo(self.rightLabelView.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 110));
    }];
    [self.typeSementedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self);
        make.top.equalTo(self.operationView.mas_bottom);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 30));
    }];
}

-(void)segmentedChanged:(UISegmentedControl*)segmentedControl{
    
//    [self.dynamicsScrollView setContentOffset:CGPointMake(segmentedControl.selectedSegmentIndex * SCREEN_WIDTH, 0.1) animated:YES];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(MycontractSegmentcontrolView *)typeSementedControl{
    if (!_typeSementedControl) {
        _typeSementedControl = [[MycontractSegmentcontrolView alloc] initWithViewModel:self.viewModel];
    }
    return _typeSementedControl;
}
//
-(UIView *)operationView{
    if (!_operationView) {
        _operationView = [[UIView alloc] init];
        
        UIButton *buy = [self buttonWithTitle:@"6458.90" withImage:@"Dynamics_MyContract_Buy" withTag:0];
        [_operationView addSubview:buy];
        
        UIButton *sell = [self buttonWithTitle:@"64563" withImage:@"Dynamics_MyContract_Sell" withTag:1];
        [_operationView addSubview:sell];
        
        UIButton *flat = [self buttonWithTitle:@"6456" withImage:@"Dynamics_MyContract_flat" withTag:2];
        [_operationView addSubview:flat];
        
        [buy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_operationView);
            make.left.equalTo(_operationView).with.offset(SCREEN_WIDTH*0.25-75);
            make.size.mas_offset(CGSizeMake(100, 100));
        }];
        [sell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(_operationView);
            make.size.mas_offset(CGSizeMake(100, 100));
        }];
        
        [flat mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_operationView);
            make.right.equalTo(_operationView.mas_right).with.offset(-SCREEN_WIDTH*0.25+75);
            make.size.mas_offset(CGSizeMake(100, 100));
        }];
    }
    return _operationView;
}
-(UIView *)searchView{
    if (!_searchView) {
        _searchView = [[UIView alloc] init];
        _searchView.layer.borderColor = [RGB(179, 140, 78) CGColor];
        _searchView.layer.borderWidth = 1;
        _searchView.layer.masksToBounds = YES;
        _searchView.layer.cornerRadius = 15;
        UITextField *searchField = [[UITextField alloc] init];
        searchField.placeholder = @"选择合约";
        searchField.textAlignment = NSTextAlignmentCenter;
        [_searchView addSubview:searchField];
        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [searchBtn setImage:[UIImage imageNamed:@"Dynamics_MyContract_search_image"] forState:UIControlStateNormal];
        [_searchView addSubview:searchBtn];
        [searchField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.equalTo(_searchView);
            make.size.mas_offset(CGSizeMake(145, 30));
        }];
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.centerY.equalTo(_searchView);
            make.left.equalTo(searchField.mas_right);
        }];
        
    }
    return _searchView;
}
-(UIView *)leftFieldView{
    if (!_leftFieldView) {
        _leftFieldView = [[UIView alloc] init];
        UILabel *numberOfHandLabel = [[UILabel alloc] init];//手数
        [numberOfHandLabel setFont:[UIFont systemFontOfSize:15]];
        numberOfHandLabel.textColor = RGB(126, 127, 128);
        numberOfHandLabel.text = @"手数";
        [_leftFieldView addSubview:numberOfHandLabel];
        UITextField *numberOfHandField = [self textFieldWithText:@"1" withPlaceholder:@"手数"];
        [_leftFieldView addSubview:numberOfHandField];
        [numberOfHandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftFieldView).with.offset(15);
            make.top.equalTo(_leftFieldView).with.offset(15);
            make.size.mas_offset(CGSizeMake(40, 20));
        }];
        [numberOfHandField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(numberOfHandLabel.mas_right).with.offset(20);
            make.top.equalTo(_leftFieldView).with.offset(10);
            make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.5-95, 30));
        }];
        
        UILabel *priceLabel = [[UILabel alloc] init];//手数
        [priceLabel setFont:[UIFont systemFontOfSize:15]];
        priceLabel.textColor = RGB(126, 127, 128);
        priceLabel.text = @"价格";
        [_leftFieldView addSubview:priceLabel];

        UITextField *priceField = [self textFieldWithText:@"对手价" withPlaceholder:@"价格"];
        [_leftFieldView addSubview:priceField];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftFieldView).with.offset(15);
            make.top.equalTo(numberOfHandField.mas_bottom).with.offset(15);
            make.size.mas_offset(CGSizeMake(40, 20));
        }];
        [priceField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(priceLabel.mas_right).with.offset(20);
            make.top.equalTo(numberOfHandField.mas_bottom).with.offset(10);
            make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.5-95, 30));
        }];
        
        
    }
    return _leftFieldView;
}

-(UIView *)rightLabelView{
    if (!_rightLabelView) {
        _rightLabelView = [[UIView alloc] init];
        UILabel *newLabel = [self labelWithText:@"新  6528" withTextColor:RGB(192, 155, 95) withFont:15];
        [_rightLabelView addSubview:newLabel];
        [newLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_rightLabelView).with.offset(10);
            make.left.equalTo(_rightLabelView);
            make.size.mas_offset(CGSizeMake(80, 20));
        }];
        UILabel *newLabelEnd = [self labelWithText:@"1238569373" withTextColor:RGB(142, 143, 144) withFont:15];
        newLabelEnd.textAlignment = NSTextAlignmentRight;
        [_rightLabelView addSubview:newLabelEnd];
        [newLabelEnd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_rightLabelView).with.offset(10);
            make.right.equalTo(_rightLabelView).with.offset(-10);
            make.size.mas_offset(CGSizeMake(100, 20));
        }];
        
        UILabel *sellLabel = [self labelWithText:@"卖  12345678" withTextColor:RGB(54, 202, 108) withFont:15];
        [_rightLabelView addSubview:sellLabel];
        [sellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_rightLabelView);
            make.top.equalTo(newLabel.mas_bottom).with.offset(10);
            make.size.mas_offset(CGSizeMake(100, 20));
        }];
        UILabel *sellLabelEnd = [self labelWithText:@"12385678" withTextColor:RGB(142, 143, 144) withFont:15];
        sellLabelEnd.textAlignment = NSTextAlignmentRight;
        [_rightLabelView addSubview:sellLabelEnd];
        [sellLabelEnd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_rightLabelView).with.offset(-10);
            make.top.equalTo(newLabelEnd.mas_bottom).with.offset(10);
            make.size.mas_offset(CGSizeMake(100, 20));

        }];
        
        UILabel *buyLabel = [self labelWithText:@"买  6528" withTextColor:RGB(244, 57, 96) withFont:15];
        [_rightLabelView addSubview:buyLabel];
        [buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_rightLabelView);
            make.top.equalTo(sellLabel.mas_bottom).with.offset(7);
            make.size.mas_offset(CGSizeMake(80, 20));
        }];
        UILabel *buyLabelEnd = [self labelWithText:@"1238569373" withTextColor:RGB(142, 143, 144) withFont:15];
        buyLabelEnd.textAlignment = NSTextAlignmentRight;
        [_rightLabelView addSubview:buyLabelEnd];
        [buyLabelEnd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_rightLabelView).with.offset(-10);
            make.top.equalTo(sellLabelEnd.mas_bottom).with.offset(7);
            make.size.mas_offset(CGSizeMake(100, 20));
        }];
        
        
        
    }
    return _rightLabelView;
}
-(UITextField*)textFieldWithText:(NSString *)text withPlaceholder:(NSString*)placeholder{
    UITextField *textfield = [[UITextField alloc] init];
    textfield.text = text;
    textfield.font = [UIFont systemFontOfSize:15];
    textfield.textAlignment = NSTextAlignmentCenter;
    textfield.textColor = RGB(144, 144, 145);
    textfield.font = [UIFont systemFontOfSize:14];
    textfield.placeholder = placeholder;
    textfield.layer.borderWidth = 1;
    textfield.layer.borderColor = [RGB(179, 140, 78) CGColor];
    textfield.layer.masksToBounds = YES;
    textfield.layer.cornerRadius = 3;
    return textfield;
}
-(UILabel *)labelWithText:(NSString *)text withTextColor:(UIColor*)color withFont:(CGFloat)font{
    UILabel *label = [[UILabel alloc] init];
    
    NSDictionary *dictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:font],NSForegroundColorAttributeName:RGB(142, 143, 144)};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:dictionary];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, 1)];
    label.attributedText = attributedString;
    return label;
}

-(UIButton *)buttonWithTitle:(NSString *)text withImage:(NSString*)image withTag:(int)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:text forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    button.titleLabel.numberOfLines =0;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.tag = tag;
    button.titleEdgeInsets = UIEdgeInsetsMake(20, 0, 40, 0);
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    UILabel *title = [[UILabel alloc] init];
    switch (tag) {
        case 0:
            title.text = @"买";
            break;
        case 1:
            title.text = @"卖";
            break;
        case 2:
            title.text = @"平";
            break;
        default:
            break;
    }
    
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:24];
    [button addSubview: title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.top.equalTo(button.titleLabel.mas_bottom);
        make.size.mas_offset(CGSizeMake(100, 20));
    }];
    return button;
}
@end
