//
//  ChooseCompanyView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/11/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountSetSexCell.h"
#import "ChooseCompanyModel.h"
#define MyEditorWidth 280.0f
#define MyEditorHeight 140.0f
@interface ChooseCompanyView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSArray *titleArray;

@property (nonatomic,strong) NSArray *pointArray;
@property (nonatomic,strong) UILabel *subTitle;
@property (nonatomic,strong) UIView *backImageView;

@property (nonatomic,copy) void (^goonBlock)(ChooseCompanyModel * model);

-(id)initWithTitleArray:(NSArray *)titleArray ModelArray:(NSArray *)modelArray;
-(void)show;

@end
