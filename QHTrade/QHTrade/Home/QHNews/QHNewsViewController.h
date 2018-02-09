//
//  QHNewsViewController.h
//  QHTrade
//
//  Created by user on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ViewBaseController.h"
#import "HomeNewsModel.h"

@interface QHNewsViewController : ViewBaseController
@property (nonatomic,copy) HomeNewsModel* newsModel;
@property (nonatomic,copy) NSString* url;
@property (nonatomic,strong) NSString *titleStr;
@end
