//
//  QHTabBar.m
//  QHTrade
//
//  Created by user on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "QHTabBar.h"

@implementation QHTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    
    if (self=[super init]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setTintColor:[UIColor whiteColor]];
        self.translucent = NO;

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
@end
