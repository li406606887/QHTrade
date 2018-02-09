//
//  PersonalSecondCell.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kPersonalSecondCell = @"PersonalSecondCell";
@interface PersonalSecondCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,copy) void (^tapBlock)(void);//
@property (nonatomic,strong) NSArray *dataArray;
@end
