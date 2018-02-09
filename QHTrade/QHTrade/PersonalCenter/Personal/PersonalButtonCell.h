//
//  PersonalButtonCell.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/4.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kPersonalButtonCell = @"PersonalButtonCell";
@interface PersonalButtonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *manageButton;
@property (weak, nonatomic) IBOutlet UIButton *signalButton;
@property (weak, nonatomic) IBOutlet UIButton *statisticButton;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;

@property (nonatomic,copy) void (^manageBlock)(void);
@property (nonatomic,copy) void (^signalBlock)(void);
@property (nonatomic,copy) void (^statisticBlock)(void);
@property (nonatomic,copy) void (^reportBlock)(void);

@end
