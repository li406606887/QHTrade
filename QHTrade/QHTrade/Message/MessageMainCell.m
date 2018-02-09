//
//  MessageMainCell.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "MessageMainCell.h"

@implementation MessageMainCell

-(void)setupViews {
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.whiteBGView];
    [self.whiteBGView addSubview:self.titleLabel];
    [self.whiteBGView addSubview:self.contentLabel];
    [self.whiteBGView addSubview:self.detailLabel];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints {
    [super updateConstraints];
    @weakify(self)
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    [self.whiteBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView).with.offset(28);
        make.left.equalTo(self.contentView).with.offset(16);
        make.right.equalTo(self.contentView).with.offset(-16);
        make.height.mas_equalTo(96);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.whiteBGView).with.offset(5);
        make.left.equalTo(self.whiteBGView).with.offset(8);
        make.right.equalTo(self.whiteBGView).with.offset(-8);
        make.height.mas_equalTo(20);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(3);
        make.left.equalTo(self.whiteBGView).with.offset(8);
        make.right.equalTo(self.whiteBGView).with.offset(-8);
        make.height.mas_equalTo(45);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentLabel.mas_bottom).with.offset(0);
        make.left.right.equalTo(self.whiteBGView).with.offset(8);
        make.height.mas_equalTo(20);
    }];
    
}

-(void)setModel:(MessageModel *)model {
    if (model) {
        self.timeLabel.text = model.timeString;
        self.titleLabel.text = model.titleString;
        self.contentLabel.text = model.contentString;
    }
}

-(UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel =[[UILabel alloc]init];
        _detailLabel.textColor = RGB(255, 98, 1);
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.font = [UIFont systemFontOfSize:14.0f];
        _detailLabel.numberOfLines = 0;
        _detailLabel.text = @"查看详情 》";
    }
    return _detailLabel;
}

-(UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel =[[UILabel alloc]init];
        _contentLabel.textColor = RGB(51, 51, 51);
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:14.0f];
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent";
    }
    return _contentLabel;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel =[[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _titleLabel.text = @"titletitletitletitletitletitletitletitletitle";
    }
    return _titleLabel;
}

-(UIView *)whiteBGView {
    if (!_whiteBGView) {
        _whiteBGView = [[UIView alloc]init];
        _whiteBGView.backgroundColor = [UIColor whiteColor];
        _whiteBGView.layer.masksToBounds = YES;
        _whiteBGView.layer.cornerRadius = 3;
        _whiteBGView.layer.borderWidth = 0.8f;
        _whiteBGView.layer.borderColor = RGB(207, 203, 203).CGColor;
    }
    return _whiteBGView;
}

-(UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = RGB(102, 102, 102);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:12.0f];
        _timeLabel.text = @"00-00 12:00";
    }
    return _timeLabel;
}


@end
