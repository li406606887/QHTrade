//
//  GroupTableViewCell.m
//  QHTrade
//
//  Created by user on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "GroupTableViewCell.h"
#import "GroupModel.h"

@interface GroupTableViewCell(){
    CGFloat height;
}
@property(nonatomic,strong) UIImageView *icon;//头像
@property(nonatomic,strong) UILabel *name;//名字
@property(nonatomic,strong) UILabel *time;//时间
@property(nonatomic,strong) UILabel *textBody;//文本内容
@property(nonatomic,strong) UILabel *lookAll;//查看全文
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UIButton *praise;//赞
@property(nonatomic,strong) UIButton *catcall;//踩
@end

@implementation GroupTableViewCell

-(void)setupViews {
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIColor whiteColor]];

    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.textBody];
    [self.contentView addSubview:self.lookAll];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.praise];
    [self.contentView addSubview:self.catcall];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(-1, -1, 10, -1));
    }];
    //头像
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(16);
        make.top.equalTo(self.contentView).with.offset(10);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    //名字
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).with.offset(10);
        make.top.equalTo(self.contentView).with.offset(10);
        make.size.mas_offset(CGSizeMake(100, 14));
    }];
    //时间
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).with.offset(10);
        make.top.equalTo(self.name.mas_bottom).with.offset(6);
        make.size.mas_offset(CGSizeMake(200, 9));
    }];
    //文本部分
    [self.textBody mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.time.mas_bottom).with.offset(10);
        make.width.offset(SCREEN_WIDTH-32);
    }];
    //查看详情
    [self.lookAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-16);
        make.top.equalTo(self.textBody.mas_bottom).with.offset(3);
        make.size.mas_offset(CGSizeMake(80, 14));
    }];
    //分割线
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.lookAll.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 0.5f));
    }];
    //点赞
    [self.praise mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.line.mas_bottom);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.5, 40));
    }];
    //踩
    [self.catcall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.line.mas_bottom);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.5, 40));
    }];
    [super updateConstraints];
}

-(void)setModel:(GroupModel *)model{
    if (model) {
        _model = model;
        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",imageLink,model.userImg];
        [self.icon sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"touxiang_icon"]];
        self.name.text = model.userName.length>0?model.userName:@"用户名";
        self.time.text = model.createTime.length>0?[NSDate getReleaseDate:model.createTime format:@"yyyy-MM-dd HH:mm"]:@"发布时间";
        self.textBody.text = model.content.length>0? model.content:@"加载内容。。。" ;
        NSString *priseCount = model.priseCount.length>0 ? model.priseCount:@"0";
        NSString *stepCount = model.stepCount.length>0 ? model.stepCount:@"0";
        switch ([model.state intValue]) {
            case 1:
                self.praise.selected = NO;
                self.catcall.selected = NO;
                break;
            case 2:
                self.praise.selected = YES;
                self.catcall.selected = NO;
                break;
            case 3:
                self.praise.selected = NO;
                self.catcall.selected = YES;
                break;
            default:
                break;
        }
        [self.praise setTitle:priseCount forState:UIControlStateNormal];
        [self.catcall setTitle:stepCount forState:UIControlStateNormal];
    }
}


-(void)setCellHeight:(CGFloat)cellHeight{
    [self.textBody mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(cellHeight);
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
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 15;
    }
    return _icon;
}

-(UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:15];
    }
    return _name;
}

-(UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.textColor = RGB(136, 136, 136);
        _time.font = [UIFont systemFontOfSize:12];
    }
    return _time;
}

-(UILabel *)textBody {
    if (!_textBody) {
        _textBody = [[UILabel alloc] init];
        _textBody.textColor = RGB(51, 51, 51);
        _textBody.numberOfLines = 6;
        _textBody.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        _textBody.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 32;
    }
    return _textBody;
}

-(UIButton *)praise {
    if (!_praise) {
        _praise = [UIButton buttonWithType:UIButtonTypeCustom];
        [_praise setAdjustsImageWhenHighlighted:NO];
        [_praise setTitle:@"0" forState:UIControlStateNormal];
        [_praise setTitleColor:RGB(255, 98, 1) forState:UIControlStateNormal];
        [_praise setImage:[UIImage imageNamed:@"Group_Icon_Praise_Normal"] forState:UIControlStateNormal];
        [_praise setImage:[UIImage imageNamed:@"Group_Icon_Praise_Selected"] forState:UIControlStateSelected];
        _praise.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 3);
        @weakify(self)
        [[[_praise rac_signalForControlEvents:UIControlEventTouchUpInside]
          takeUntil:self.rac_willDeallocSignal]
         subscribeNext:^(id x) {
             @strongify(self)
             int state = [self.model.state intValue];
             if ( state == 2 || state == 3) {
                 showMassage(@"不可重复点赞或踩")
                 return ;
             }
             NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
             [param setObject:@"2" forKey:@"state"];
             [param setObject:self.model.ID forKey:@"contentId"];
             self.praiseBlock((int)self.tag, param);
         }];
    }
    return _praise;
}

-(UIButton *)catcall {
    if (!_catcall) {
        _catcall = [UIButton buttonWithType:UIButtonTypeCustom];
        [_catcall setAdjustsImageWhenHighlighted:NO];
        [_catcall setTitle:@"0" forState:UIControlStateNormal];
        [_catcall setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
        _catcall.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 3);
        [_catcall setImage:[UIImage imageNamed:@"Group_Icon_catcall_Normal"] forState:UIControlStateNormal];
        [_catcall setImage:[UIImage imageNamed:@"Group_Icon_catcall_Selected"] forState:UIControlStateSelected];
        @weakify(self)
        [[[_catcall rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            int state = [self.model.state intValue];
            if ( state == 2 || state == 3) {
                showMassage(@"不可重复点赞或踩")
                return ;
            }
            NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
            [param setObject:@"3" forKey:@"state"];
            [param setObject:self.model.ID forKey:@"contentId"];
            self.praiseBlock((int)self.tag, param);
        }];
    }
    return _catcall;
}

-(UILabel *)lookAll {
    if (!_lookAll) {
        _lookAll = [[UILabel alloc] init];
        _lookAll.text = @"查看详情>>";
        _lookAll.textColor = RGB(255, 98, 1);
        _lookAll.font = [UIFont systemFontOfSize:14];
    }
    return _lookAll;
}

-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        [_line setBackgroundColor:RGB(215, 215, 215)];
    }
    return _line;
}
@end
