//
//  DiamondHeadView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "DiamondHeadView.h"
#import "DiamondCollectionCell.h"

@interface DiamondHeadView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong)UIView *line1;
@property (nonatomic,assign) int selectIndex;
@property (nonatomic,strong) NSArray * moneyArray;
@end

@implementation DiamondHeadView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (DiamondViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)bindViewModel {
}
-(void)layoutSubviews {
    
    WS(weakSelf)
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(5);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(@1);
    }];
    
    [self.moneyTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line).with.offset(8);
        make.left.equalTo(self).with.offset(16);
        make.right.equalTo(self).with.offset(-16);
        make.height.mas_equalTo(35);
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyTextfield.mas_bottom).with.offset(3);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(@1);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.moneyTextfield.mas_bottom).with.offset(15);
        make.left.equalTo(weakSelf).with.offset(16);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.height.mas_offset(210);
    }];

    [super layoutSubviews];
}
-(void)setupViews{
    
    
    //默认选择第一
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    //选择状态都为未选中
//    [self.collectionView selectItemAtIndexPath:nil animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    [self addSubview:self.line];
    [self addSubview:self.moneyTextfield];
    [self addSubview:self.line1];
    [self addSubview:self.collectionView];

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, 2, 1, 2);
}
//layout协议
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.f;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DiamondCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDiamondCollectionCell forIndexPath:indexPath];
    
    [cell setMoneyStr:self.moneyArray[indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"item%ld-row%ld",(long)indexPath.item,(long)indexPath.row);
    self.selectIndex = (int)indexPath.row;
    switch (self.selectIndex) {
        case 0:
        {
//            self.moneyTextfield.text = @"1000";
            self.money = @"1000";
            
        }
            break;
        case 1:
        {
//            self.moneyTextfield.text = @"500";
            self.money = @"500";
        }
            break;
        case 2:
        {
//            self.moneyTextfield.text = @"300";
            self.money = @"300";
        }
            break;
        case 3:
        {
//            self.moneyTextfield.text = @"100";
            self.money = @"100";
            
        }
            break;
            
            
        default:self.money = @"";
            break;
    }
    [self.viewModel.cellClickSubject sendNext:self.money];
}
-(NSArray *)moneyArray {

    if (!_moneyArray) {
        _moneyArray = @[@"1000",@"500",@"300",@"100"];
    }
    return _moneyArray;
}
-(UICollectionView *)collectionView {

    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setItemSize:CGSizeMake((SCREEN_WIDTH-40)/2, 102)];//36
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
//        [_collectionView setCollectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerNib:[UINib nibWithNibName:kDiamondCollectionCell bundle:nil] forCellWithReuseIdentifier:kDiamondCollectionCell];
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}
-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = RGB(207, 205, 205);
    }
    return _line;
}
-(UIView *)line1 {
    if (!_line1) {
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = RGB(207, 205, 205);
    }
    return _line1;
}
-(UITextField *)moneyTextfield {
    if (!_moneyTextfield) {
        _moneyTextfield = [[UITextField alloc]init];
        _moneyTextfield.placeholder = @"输入充值金额";
    }
    return _moneyTextfield;
}
-(DiamondViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[DiamondViewModel alloc]init];
    }
    return _viewModel;
}
@end
