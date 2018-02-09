//
//  QHNewsViewController.m
//  QHTrade
//
//  Created by user on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "QHNewsViewController.h"
#import "QHNewsView.h"
#import "ContentWebView.h"
#import "QHNewsViewModel.h"

@interface QHNewsViewController ()
@property(nonatomic,strong) QHNewsView *newsView;
@property(nonatomic,strong) ContentWebView *contentView;
@property(nonatomic,strong) QHNewsViewModel *viewModel;
@end

@implementation QHNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.titleStr.length<1) {
        self.titleStr = @"新闻详情";
    }
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationItem setTitle:self.titleStr];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addChildView {
}

-(void)setNewsModel:(HomeNewsModel *)newsModel {
    if (newsModel) {
        self.viewModel.newsModel = newsModel;
        [self.view addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}
-(void)setUrl:(NSString *)url {
    if (url) {
        self.viewModel.url = url;
        [self.view addSubview:self.newsView];
        [self.newsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}

-(void)updateViewConstraints {
    [super updateViewConstraints];    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(QHNewsView *)newsView {
    if (!_newsView) {
        _newsView = [[QHNewsView alloc] initWithViewModel:self.viewModel];
    }
    return _newsView;
}

-(ContentWebView *)contentView {
    if (!_contentView) {
        _contentView = [[ContentWebView alloc] initWithViewModel:self.viewModel];
    }
    return _contentView;
}

-(QHNewsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[QHNewsViewModel alloc] init];

    }
    return _viewModel;
}
@end
