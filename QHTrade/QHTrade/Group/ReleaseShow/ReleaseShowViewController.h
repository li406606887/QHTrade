//
//  ReleaseShowViewController.h
//  QHTrade
//
//  Created by user on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ViewBaseController.h"

typedef void(^RefreshBlock) (void);

@interface ReleaseShowViewController : ViewBaseController
@property (nonatomic,copy) RefreshBlock refreshBlock;

@end
