//
//  GroupDetailsView.m
//  QHTrade
//
//  Created by user on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "GroupDetailsView.h"
#import "GroupDetailsViewModel.h"
#import "GroupModel.h"

@interface GroupDetailsView()
@property(nonatomic,strong) GroupDetailsViewModel *viewModel;
@property(nonatomic,strong) UIScrollView *scroll;
@property(nonatomic,strong) UIView *backgroundView;
@property(nonatomic,strong) UIImageView *icon;
@property(nonatomic,strong) UILabel *name;
@property(nonatomic,strong) UILabel *time;
@property(nonatomic,strong) UILabel *textBody;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UIButton *praise;//赞
@property(nonatomic,strong) UIButton *catcall;//踩
@property(nonatomic,strong) UIImageView *lineImage;
@end

@implementation GroupDetailsView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (GroupDetailsViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.scroll];
    [self.scroll addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.icon];
    [self.backgroundView addSubview:self.name];
    [self.backgroundView addSubview:self.time];
    [self.backgroundView addSubview:self.textBody];
    [self addSubview:self.line];
    [self addSubview:self.praise];
    [self addSubview:self.catcall];
    [self addSubview:self.lineImage];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 40+NoSafeBarHeight, 0));
    }];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self.scroll);
        make.width.offset(SCREEN_WIDTH);
        make.height.offset(SCREEN_HEIGHT);
    }];
    //头像
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroundView).with.offset(16);
        make.top.equalTo(self.backgroundView).with.offset(10);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    //名字
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).with.offset(10);
        make.top.equalTo(self.backgroundView).with.offset(10);
        make.size.mas_offset(CGSizeMake(100, 14));
    }];
    //时间
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).with.offset(10);
        make.top.equalTo(self.name.mas_bottom).with.offset(6);
        make.size.mas_offset(CGSizeMake(200, 9));
    }];
    //文本内容
    [self.textBody mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroundView).with.offset(16);
        make.top.equalTo(self.icon.mas_bottom).with.offset(15);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-32, self.viewModel.textHeight));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.praise.mas_top);
        make.size.mas_offset(CGSizeMake(SCREEN_HEIGHT, 1));
    }];
    //点赞
    [self.praise mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).with.offset(-NoSafeBarHeight);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.5, 40));
    }];
    //分割线
    [self.lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.praise.mas_right);
        make.top.equalTo(self.praise).with.offset(8);
        make.size.mas_offset(CGSizeMake(1, 24));
    }];
    //踩
    [self.catcall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self); 
        make.bottom.equalTo(self.mas_bottom).with.offset(-NoSafeBarHeight);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.5, 40));
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.refreshPriseStateSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        GroupModel *model = [GroupModel mj_objectWithKeyValues:x];
        switch ([model.state intValue]) {
            case 2:
                self.praise.selected = YES;
                [self.praise setTitle:model.priseCount forState:UIControlStateNormal];
                showMassage(@"点赞成功");
                break;
            
            case 3:
                self.catcall.selected = YES;
                [self.catcall setTitle:model.stepCount forState:UIControlStateNormal];
                showMassage(@"踩成功");
                break;
                
            default:
                break;
        }
        [self.viewModel.backSubject sendNext:model];
        self.viewModel.model = model;
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] init];
    }
    return _scroll;
}

-(UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        [_icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageLink,self.viewModel.model.userImg]] placeholderImage:[UIImage imageNamed:@"touxiang_icon"]];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 15;
    }
    return _icon;
}

-(UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = [NSString stringWithFormat:@"%@",self.viewModel.model.userName];
        _name.font = [UIFont systemFontOfSize:15];
    }
    return _name;
}

-(UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = [NSString stringWithFormat:@"%@",[NSDate getReleaseDate:self.viewModel.model.createTime format:@"yyyy-MM-dd HH:mm"]];
        _time.textColor = RGB(136, 136, 136);
        _time.font = [UIFont systemFontOfSize:12];
    }
    return _time;
}

-(UILabel *)textBody {
    if (!_textBody) {
        _textBody = [[UILabel alloc] init];
        _textBody.font = [UIFont systemFontOfSize:14];
        _textBody.textColor = RGB(38, 38, 38);
        _textBody.numberOfLines = 0;
        _textBody.text = self.viewModel.model.content;
    }
    return _textBody;
}

-(UIButton *)praise {
    if (!_praise) {
        _praise = [UIButton buttonWithType:UIButtonTypeCustom];
        [_praise setAdjustsImageWhenHighlighted:NO];
        [_praise setTitle:[NSString stringWithFormat:@"%@",self.viewModel.model.priseCount] forState:UIControlStateNormal];
        [_praise setTitleColor:RGB(255, 98, 1) forState:UIControlStateNormal];
        [_praise setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_praise setImage:[UIImage imageNamed:@"Group_Icon_Praise_Normal"] forState:UIControlStateNormal];
        [_praise setImage:[UIImage imageNamed:@"Group_Icon_Praise_Selected"] forState:UIControlStateSelected];
        if ([self.viewModel.model.state intValue]==2) {
            _praise.selected = YES;
        }
        @weakify(self)
        [[_praise rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (![[UserInformation getInformation] getLoginState]) {
                [self.viewModel.gotoLoginSubject sendNext:nil];
                return ;
            }
            if ([self.viewModel.model.state intValue]==2||[self.viewModel.model.state intValue]==3) {
                showMassage(@"不可重复点赞或踩");
                return ;
            }
            NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
            [param setObject:self.viewModel.model.ID forKey:@"contentId"];
            [param setObject:@"2" forKey:@"state"];
            [self.viewModel.groupPriseCommand execute:param];
        }];
    }
    return _praise;
}

-(UIButton *)catcall {
    if (!_catcall) {
        _catcall = [UIButton buttonWithType:UIButtonTypeCustom];
        [_catcall setAdjustsImageWhenHighlighted:NO];
        [_catcall setTitle:[NSString stringWithFormat:@"%@",self.viewModel.model.stepCount] forState:UIControlStateNormal];
        [_catcall setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        [_catcall setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_catcall setImage:[UIImage imageNamed:@"Group_Icon_catcall_Normal"] forState:UIControlStateNormal];
        [_catcall setImage:[UIImage imageNamed:@"Group_Icon_catcall_Selected"] forState:UIControlStateSelected];
        if ([self.viewModel.model.state intValue]==3) {
            _catcall.selected = YES;
        }
        @weakify(self)
        [[_catcall rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (![[UserInformation getInformation] getLoginState]) {
                [self.viewModel.gotoLoginSubject sendNext:nil];
                return ;
            }
            if ([self.viewModel.model.state intValue]==2||[self.viewModel.model.state intValue]==3) {
                showMassage(@"不可重复点赞或踩");
                return ;
            }
            NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
            [param setObject:self.viewModel.model.ID forKey:@"contentId"];
            [param setObject:@"3" forKey:@"state"];
            [self.viewModel.groupPriseCommand execute:param];
        }];
    }
    return _catcall;
}

-(UIImageView *)lineImage {
    if (!_lineImage) {
        _lineImage = [[UIImageView alloc] init];
        [_lineImage setImage:[UIImage imageNamed:@"Group_Icon_Dividing_Line"]];
    }
    return _lineImage;
}

-(UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _backgroundView;
}
-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGB(222, 222, 222);
    }
    return _line;
}

@end
