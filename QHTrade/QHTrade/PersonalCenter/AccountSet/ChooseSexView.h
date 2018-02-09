//
//  ChooseSexView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/28.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountSetSexCell.h"
#define MyEditorWidth 280.0f
#define MyEditorHeight 140.0f
typedef void(^CallBackBlock) (NSString * str);

@interface ChooseSexView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    
}
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSArray *sexArray;
@property (nonatomic,strong) UILabel *subTitle;
@property (nonatomic,strong) UIView *backImageView;
@property (nonatomic,copy) CallBackBlock  callBackBlock;

@property (nonatomic,strong) void (^goonBlock)(void);

-(id)initWithDataArray:(NSArray *)dataArray;
-(void)show;
@end

