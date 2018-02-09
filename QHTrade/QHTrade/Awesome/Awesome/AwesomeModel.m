//
//  AwesomeModel.m
//  QHTrade
//
//  Created by user on 2017/6/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "AwesomeModel.h"

@implementation AwesomeModel
-(CGFloat)nameWidth {
    if (!_nameWidth) {
        NSDictionary *dictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        CGRect rect = [self.userName boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-32, MAXFLOAT)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:dictionary
                                                   context:nil];
        _nameWidth = rect.size.width;
    }
    return _nameWidth;
}

@end
