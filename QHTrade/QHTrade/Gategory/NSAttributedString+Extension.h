//
//  NSAttributedString+Extension.h
//  QHTrade
//
//  Created by user on 2017/7/6.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Extension)
+(CGSize)getTextSizeWithText:(NSString *)text withMaxSize:(CGSize)size withLineSpacing:(int)LineSpacing;
+(CGSize)getTextSizeWithText:(NSString *)text withMaxSize:(CGSize)size dic:(NSDictionary*)dic;
+(NSMutableAttributedString*)getAttributedStringWithString:(NSString*)string  littlefont:(CGFloat)little bigFont:(CGFloat)big defultTextColor:(UIColor*)defult specialColor:(UIColor*)special range:(NSRange)range;
+(CGSize)getTextSizeWithText:(NSString *)text withMaxSize:(CGSize)size font:(int)font;
@end
