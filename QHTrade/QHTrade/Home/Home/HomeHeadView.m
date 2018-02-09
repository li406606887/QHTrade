//
//  HomeHeadView.m
//  QHTrade
//
//  Created by user on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "HomeHeadView.h"
#import "HomeViewModel.h"
#import "HomeScrollView.h"
#import "HomeQuotationView.h"
#import "ContractModel.h"
#import "HomeSectionView.h"

#define kHostAddress 192.168.0.199
#define kPort 8081

@interface HomeHeadView()
@property(nonatomic,strong) HomeViewModel *viewModel;
@property(nonatomic,strong) HomeScrollView *awesomeScrollView;
@property(nonatomic,strong) UIView *homeQuotationView;
@property(nonatomic,strong) HomeQuotationView *leftQuotationView;
@property(nonatomic,strong) HomeQuotationView *middleQuotationView;
@property(nonatomic,strong) HomeQuotationView *rightQuotationView;
@property(nonatomic,copy) NSString* leftContractID;
@property(nonatomic,copy) NSString* middleContractID;
@property(nonatomic,copy) NSString* rightContractID;
@property(nonatomic,strong) HomeSectionView *recommendedTitle;
@property(nonatomic,strong) HomeSectionView *newsTitle;
@end


@implementation HomeHeadView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (HomeViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.homeQuotationView];    
    [self.homeQuotationView addSubview:self.leftQuotationView];
    [self.homeQuotationView addSubview:self.middleQuotationView];
    [self.homeQuotationView addSubview:self.rightQuotationView];
    [self addSubview:self.recommendedTitle];
    [self addSubview:self.newsTitle];
    [self addSubview:self.awesomeScrollView];

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.homeQuotationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(8);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, (SCREEN_WIDTH-32)/3));
    }];
    
    [self.leftQuotationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.homeQuotationView).with.offset(8);
        make.centerY.equalTo(self.middleQuotationView);
        make.size.mas_offset(CGSizeMake((SCREEN_WIDTH-32)/3, (SCREEN_WIDTH-32)/3));
    }];
    
    [self.middleQuotationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.homeQuotationView);
        make.size.mas_offset(CGSizeMake((SCREEN_WIDTH-32)/3, (SCREEN_WIDTH-32)/3));
    }];
    
    [self.rightQuotationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.homeQuotationView.mas_right).with.offset(-8);
        make.centerY.equalTo(self.middleQuotationView);
        make.size.mas_offset(CGSizeMake((SCREEN_WIDTH-32)/3, (SCREEN_WIDTH-32)/3));
    }];
    
    [self.recommendedTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.homeQuotationView.mas_bottom).with.offset(8);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 20));
    }];
    
    [self.awesomeScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.recommendedTitle.mas_bottom).with.offset(8);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-32, (SCREEN_WIDTH-32)*0.44));
    }];
    
    [self.newsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.awesomeScrollView.mas_bottom).with.offset(8);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 20));
    }];
}

-(void)bindViewModel{
    @weakify(self)
    [self.viewModel.quotationRefreshSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSLog(@"%@",x);
        HomeQuotationModel *model = [HomeQuotationModel mj_objectWithKeyValues:[x objectForKey:@"data"]];
        if ([model.ContractID isEqualToString:self.leftContractID]) {
            self.leftQuotationView.modelData = model;
        }else if([model.ContractID isEqualToString:self.middleContractID]){
            self.middleQuotationView.modelData = model;
        }else if([model.ContractID isEqualToString:self.rightContractID]){
            self.rightQuotationView.modelData = model;
        }
    }];
    [self.viewModel.refreshContractSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.leftContractID = self.viewModel.contractNameArray[0];
        self.leftQuotationView.model = [self.viewModel.modelDictionary objectForKey:self.leftContractID];
        self.middleContractID = self.viewModel.contractNameArray[1];
        self.middleQuotationView.model = [self.viewModel.modelDictionary objectForKey:self.middleContractID];
        self.rightContractID = self.viewModel.contractNameArray[2];
        self.rightQuotationView.model = [self.viewModel.modelDictionary objectForKey:self.rightContractID];
    }];
}
/*

*/
-(HomeScrollView *)awesomeScrollView {
    if (!_awesomeScrollView) {
        _awesomeScrollView = [[HomeScrollView alloc] initWithViewModel:self.viewModel];
        [_awesomeScrollView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.44+133)];
        _awesomeScrollView.layer.masksToBounds = YES;
        _awesomeScrollView.layer.cornerRadius = 6;
    }
    return _awesomeScrollView;
}

-(UIView *)homeQuotationView {
    if (!_homeQuotationView) {
        _homeQuotationView = [[UIView alloc] init];
        _homeQuotationView.backgroundColor = [UIColor whiteColor];
    }
    return _homeQuotationView;
}

-(HomeQuotationView *)leftQuotationView {
    if (!_leftQuotationView) {
        _leftQuotationView = [[HomeQuotationView alloc] initWithViewModel:self.viewModel];
    }
    return _leftQuotationView;
}

-(HomeQuotationView *)middleQuotationView {
    if (!_middleQuotationView) {
        _middleQuotationView = [[HomeQuotationView alloc] initWithViewModel:self.viewModel];
    }
    return _middleQuotationView;
}

-(HomeQuotationView *)rightQuotationView {
    if (!_rightQuotationView) {
        _rightQuotationView = [[HomeQuotationView alloc] initWithViewModel:self.viewModel];
    }
    return _rightQuotationView;
}

-(HomeSectionView *)recommendedTitle {
    if (!_recommendedTitle) {
        _recommendedTitle = [[HomeSectionView alloc] init];
        _recommendedTitle.sectionTitle.text = @"热门推荐";
    }
    return _recommendedTitle;
}

-(HomeSectionView *)newsTitle {
    if (!_newsTitle) {
        _newsTitle = [[HomeSectionView alloc]  init];
        _newsTitle.sectionTitle.text = @"奇获要闻";
    }
    return _newsTitle;
}

@end
