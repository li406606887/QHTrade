//
//  DiamondHeadView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "DiamondViewModel.h"

@interface DiamondHeadView : BaseView

@property (nonatomic,strong) DiamondViewModel* viewModel;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UITextField *moneyTextfield;
@property (nonatomic,strong) NSString *money;
@end
