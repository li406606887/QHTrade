//
//  PersonalCollectionCell.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kPersonalCollectionCell = @"PersonalCollectionCell";
@interface PersonalCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UIImageView *upOrDownImgView;

@end
