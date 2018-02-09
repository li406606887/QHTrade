//
//  PersonalFirstCell.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kPersonalFirstCell = @"PersonalFirstCell";
@interface PersonalFirstCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *scoresLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@end
