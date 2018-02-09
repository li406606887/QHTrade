//
//  NSString+Extension.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/27.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString {
    
    NSRange startRange = [self rangeOfString:startString];
    NSRange endRange = [self rangeOfString:endString];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    return [self substringWithRange:range];
    
}
@end
