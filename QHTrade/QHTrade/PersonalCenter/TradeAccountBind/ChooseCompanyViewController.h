//
//  ChooseCompanyViewController.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/12.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ViewBaseController.h"
typedef void(^CallBackBlock) (NSString * str);
@interface ChooseCompanyViewController : ViewBaseController
@property (nonatomic,copy) CallBackBlock callBackBlock;
@end
