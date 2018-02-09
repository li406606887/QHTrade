//
//  AccountSetSexCell.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/28.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kAccountSetSexCell  = @"AccountSetSexCell";
@interface AccountSetSexCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end
