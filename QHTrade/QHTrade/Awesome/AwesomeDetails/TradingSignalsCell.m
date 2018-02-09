//
//  TradingSignalsCell.m
//  QHTrade
//
//  Created by user on 2017/7/5.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "TradingSignalsCell.h"


@interface TradingSignalsCell()
@property(nonatomic,strong) UIImageView *signalsImage;
@property(nonatomic,strong) UILabel *name;//物品名称
@property(nonatomic,strong) UILabel *price;//价格
@property(nonatomic,strong) UILabel *moreEmpty;//开多开空
@property(nonatomic,strong) UILabel *volume;//成交量 列如 100手
@property(nonatomic,strong) UILabel *tradedatetime;//交易时间
@end

@implementation TradingSignalsCell

-(void)setupViews {
    [self.contentView addSubview:self.signalsImage];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.price];
    [self.contentView addSubview:self.moreEmpty];
    [self.contentView addSubview:self.volume];
    [self.contentView addSubview:self.tradedatetime];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    @weakify(self)
    [self.signalsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView).with.offset(8);
        make.left.equalTo(self.contentView).with.offset(16);
        make.size.mas_offset(CGSizeMake(10, 10));
    }];
    
    [self.tradedatetime mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView).with.offset(4);
        make.left.equalTo(self.signalsImage.mas_right).with.offset(10);
        make.size.mas_offset(CGSizeMake(150, 20));
    }];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.tradedatetime.mas_bottom).with.offset(5);
        make.left.equalTo(self.signalsImage.mas_right).with.offset(10);
        make.size.mas_offset(CGSizeMake(86, 15));
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.tradedatetime.mas_bottom).with.offset(5);
        make.left.equalTo(self.contentView).with.offset(SCREEN_WIDTH*0.4);
        make.size.mas_offset(CGSizeMake(85, 15));
    }];
    
    [self.moreEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.tradedatetime.mas_bottom).with.offset(5);
        make.left.equalTo(self.contentView).with.offset(SCREEN_WIDTH*0.6);
        make.size.mas_offset(CGSizeMake(80, 15));
    }];
    
    [self.volume mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.tradedatetime.mas_bottom).with.offset(5);
        make.left.equalTo(self.contentView).with.offset(SCREEN_WIDTH*0.8);
        make.size.mas_offset(CGSizeMake(60, 15));
    }];
}

-(void)setMyModel:(TradeRecordModel *)myModel {
    if (myModel) {
        self.name.text = myModel.instrumentidCh;
        self.price.text = myModel.price;
        self.moreEmpty.text = [NSString stringWithFormat:@"%@%@",[self getmoreEmptyDirectionText:[myModel.direction intValue]],[self getmoreEmptyOffsetflagText:[myModel.offsetflag intValue]]];
        self.tradedatetime.text = [UserInformation formatTimeStampString:myModel.tradedatetime];
        self.volume.text = [NSString stringWithFormat:@"%@手",myModel.volume]; //成交量
    }
}

-(UIImageView *)signalsImage {
    if (!_signalsImage) {
        _signalsImage = [[UIImageView alloc] init];
        [_signalsImage setImage:[UIImage imageNamed:@"Awesome_TradingSignals"]];
    }
    return _signalsImage;
}

-(UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
        _name.text = @"****";
        _name.numberOfLines = 2;
        _name.textAlignment = NSTextAlignmentLeft;
    }
    return _name;
}

-(UILabel *)price {
    if (!_price) {
        _price = [[UILabel alloc] init];
        _price.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
        _price.text = @"0.00";
    }
    return _price;
}

-(UILabel *)moreEmpty {
    if (!_moreEmpty) {
        _moreEmpty = [[UILabel alloc] init];
        _moreEmpty.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
        _moreEmpty.textAlignment = NSTextAlignmentCenter;
        _moreEmpty.text = @"开空";
        
    }
    return _moreEmpty;
}

-(UILabel *)volume {
    if (!_volume) {
        _volume = [[UILabel alloc] init];
        _volume.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
        _volume.textAlignment = NSTextAlignmentRight;
        _volume.text = @"0手";
        
    }
    return _volume;
}
-(UILabel *)tradedatetime {
    if (!_tradedatetime) {
        _tradedatetime = [[UILabel alloc] init];
        _tradedatetime.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        _tradedatetime.textColor = RGB(68, 68, 68);
        _tradedatetime.text = @"88:88:88";
    }
    return _tradedatetime;
}
-(void)drawRect:(CGRect)rect {
    int startY = 0;
    int endY = self.frame.size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 2);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 251 / 255.0, 189 / 255.0, 59 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 21, startY);  //起点坐标
    CGContextAddLineToPoint(context, 21, endY);   //终点坐标
    
    CGContextStrokePath(context);
}
-(NSString *)getmoreEmptyOffsetflagText:(int)index{
    NSString *text;
    switch (index) {
        case 0:
            text = @"开仓";
            break;
        case 1:
            text = @"平仓";
            break;
        case 2:
            text = @"强平";
            break;
        case 3:
            text = @"平今";
            break;
        case 4:
            text = @"平昨";
            break;
        case 5:
            text = @"强减";
            break;
        case 6:
            text = @"本地强平";
            break;
        default:
            break;
    }
    return text;
}
-(NSString *)getmoreEmptyDirectionText:(int)index{
    NSString *text;
    switch (index) {
        case 0:
            text = @"买入";
            break;
        case 1:
            text = @"卖出";
            break;
        
        default:
            break;
    }
    return text;
}
@end
