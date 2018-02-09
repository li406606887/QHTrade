//
//  HomeTableViewCell.m
//  QHTrade
//
//  Created by user on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "HomeTableViewCell.h"


@interface HomeTableViewCell()
@property(nonatomic,strong) UIImageView *icon;
@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) UILabel *timeLable;
@end

@implementation HomeTableViewCell

-(void)setupViews {
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.timeLable];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    @weakify(self)
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView).with.offset(16);
        make.top.equalTo(self.contentView).with.offset(10);
        make.size.mas_offset(CGSizeMake(75, 65));
    }];
   
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView).with.offset(10);
        make.left.equalTo(self.icon.mas_right).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-16);
        make.height.equalTo(@36);
    }];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.contentView).with.offset(-10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-16);
        make.size.mas_offset(CGSizeMake(200, 20));
    }];
}

-(void)setModel:(HomeNewsModel *)model {
    if (model) {
        self.titleLable.text = model.title;
        NSString *url = [NSString stringWithFormat:@"%@%@",imageLink,model.imgUrl];
        [self.icon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"Loading_Image"]];
        self.timeLable.text = model.createDate.length > 0 ? [NSDate getReleaseDate:model.createDate format:@"yyyy-MM-dd HH:mm"]:@"时间";
    }
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
        _icon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _icon;
}
-(UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.numberOfLines = 2;
        _titleLable.font = [UIFont systemFontOfSize:15];
        _titleLable.textColor = RGB(51, 51, 51);
    }
    return _titleLable;
}

-(UILabel *)timeLable {
    if (!_timeLable) {
        _timeLable = [[UILabel alloc] init];
        _timeLable.textAlignment = NSTextAlignmentRight;
        _timeLable.font = [UIFont systemFontOfSize:12];
        _timeLable.textColor = RGB(136, 136, 136);
    }
    return _timeLable;
}
@end
