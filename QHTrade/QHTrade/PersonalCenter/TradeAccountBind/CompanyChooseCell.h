//
//  CompanyChooseCell.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/12.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ChooseCompanyModel.h"

@interface CompanyChooseCell : BaseTableViewCell
@property (nonatomic,strong) UILabel *companyLabel;
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *letter;
@property (nonatomic,strong) NSString *sort;


@property (nonatomic,strong) ChooseCompanyModel *model;
@end
