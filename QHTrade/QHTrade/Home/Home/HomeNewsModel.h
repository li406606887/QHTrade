//
//  HomeNewsModel.h
//  QHTrade
//
//  Created by user on 2017/7/26.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeNewsModel : NSObject
@property(nonatomic,copy) NSString* ID;//				新闻ID
@property(nonatomic,copy) NSString* title;//			标题
@property(nonatomic,copy) NSString* content;//			内容
@property(nonatomic,copy) NSString* createDate;//		创建时间
@property(nonatomic,copy) NSString* imgUrl;//			小图标
@property(nonatomic,copy) NSString* url;//				详情页h5链接
@property(nonatomic,copy) NSString* author;//           作者
@end
