//
//  NSAttributedString+Extension.m
//  QHTrade
//
//  Created by user on 2017/7/6.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)
+(CGSize)getTextSizeWithText:(NSString *)text withMaxSize:(CGSize)size withLineSpacing:(int)LineSpacing{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if (LineSpacing!=0) {
        [paragraphStyle setLineSpacing:LineSpacing];
    }
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGRect rect = [text boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    return rect.size;
}

+(CGSize)getTextSizeWithText:(NSString *)text withMaxSize:(CGSize)size dic:(NSDictionary *)dic{
    CGRect rect = [text boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                  attributes:dic
                                     context:nil];
    return rect.size;
}

+(CGSize)getTextSizeWithText:(NSString *)text withMaxSize:(CGSize)size font:(int)font {
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGRect rect = [text boundingRectWithSize:size
                                     options:NSStringDrawingTruncatesLastVisibleLine |
 NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    return rect.size;
}
+(NSMutableAttributedString*)getAttributedStringWithString:(NSString*)string  littlefont:(CGFloat)little bigFont:(CGFloat)big defultTextColor:(UIColor*)defult specialColor:(UIColor*)special range:(NSRange)range {
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 2; // 行距
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributedDic = @{NSFontAttributeName:[UIFont systemFontOfSize:big],NSForegroundColorAttributeName:defult,NSParagraphStyleAttributeName:paragraph};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:attributedDic];
    [attributedString addAttribute:NSForegroundColorAttributeName value:special range:range];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:little] range:range];
    return attributedString;
}
@end
