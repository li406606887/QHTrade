//
//  DiamondPayCell.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kDiamondPayCell = @"DiamondPayCell";
@interface DiamondPayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *payImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
