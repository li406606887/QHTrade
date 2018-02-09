//
//  QHNewsViewModel.h
//  QHTrade
//
//  Created by user on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"
#import "HomeNewsModel.h"

@interface QHNewsViewModel : BaseViewModel
@property(nonatomic,copy) NSString* url;
@property(nonatomic,strong) HomeNewsModel *newsModel;
@end
