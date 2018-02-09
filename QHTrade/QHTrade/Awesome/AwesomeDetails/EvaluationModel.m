//
//  EvaluationModel.m
//  QHTrade
//
//  Created by user on 2017/11/29.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "EvaluationModel.h"

@implementation EvaluationModel

-(CGFloat)height {
    if (!_height) {
        CGSize size = [NSAttributedString getTextSizeWithText:self.evaluate withMaxSize:CGSizeMake(SCREEN_WIDTH-40, MAXFLOAT) font:14];
        _height = size.height+10;
    }
    return _height;
}
@end
