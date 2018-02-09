//
//  PersonalSecondCell.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "PersonalSecondCell.h"
#import "PersonalCollectionCell.h"
#import "PersonalMainView.h"
#import "MyPositionsCell.h"

@interface PersonalSecondCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)PersonalViewModel * viewModel;
@property (nonatomic,strong)NSArray *titleArray;
@end


@implementation PersonalSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake((SCREEN_WIDTH-34)/3, 60)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.collectionView setCollectionViewLayout:flowLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:kPersonalCollectionCell bundle:nil] forCellWithReuseIdentifier:kPersonalCollectionCell];
    [self.collectionView registerNib:[UINib nibWithNibName:kMyPositionsCell bundle:nil] forCellWithReuseIdentifier:kMyPositionsCell];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if ([view isKindOfClass:[UICollectionView class]]) {
        return self;
    }
    return [super hitTest:point withEvent:event];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tapBlock) {
        self.tapBlock();
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, 1, 1, 1);
}
//layout协议
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.f;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PersonalCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPersonalCollectionCell forIndexPath:indexPath];
    MyPositionsCell * positionsCell = [collectionView dequeueReusableCellWithReuseIdentifier:kMyPositionsCell forIndexPath:indexPath];
    if (indexPath.row == 5) {
        return positionsCell;
    }
    if (indexPath.row <5) {
        cell.topLabel.text = self.titleArray[indexPath.row];
        cell.bottomLabel.text = self.dataArray[indexPath.row];
    }
    return cell;
}

-(void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

-(NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"收益率",@"总资产",@"总收益",@"仓位使用率",@"持仓手数",@""];
    }
    return _titleArray;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
