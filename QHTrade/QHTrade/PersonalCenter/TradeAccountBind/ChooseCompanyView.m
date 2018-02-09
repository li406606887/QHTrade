//
//  ChooseCompanyView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/11/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ChooseCompanyView.h"

static CGFloat kTransitionDuration = 0.15;
@interface ChooseCompanyView ()

@end
@implementation ChooseCompanyView
-(instancetype)init{
    
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChooseCompanyModel * model = [ChooseCompanyModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    if (self.goonBlock) {
        self.goonBlock(model);
    }
    [self dismissAlert];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AccountSetSexCell * cell = [tableView dequeueReusableCellWithIdentifier:kAccountSetSexCell];
//    ChooseCompanyModel * model = [ChooseCompanyModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    
    cell.sexLabel.text = self.titleArray[indexPath.row];
    
    if ([self.pointArray[indexPath.row] isEqualToString:@"1"]) {
        cell.imgView.image = [UIImage imageNamed:@"xingbiedianji"];
    }else cell.imgView.image = [UIImage imageNamed:@"xingbieweidianji"];
    
    return cell;
}

-(id)initWithTitleArray:(NSArray *)titleArray ModelArray:(NSArray *)modelArray{
    self = [super init];
    if (self) {
        self.titleArray = titleArray;
        self.dataArray = modelArray;
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MyEditorWidth, MyEditorHeight) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:kAccountSetSexCell bundle:nil] forCellReuseIdentifier:kAccountSetSexCell];
    }
    return self;
}
#pragma mark - 继续按钮
-(void)goonAction:(id)sender
{
    //代码筷回掉
    [self dismissAlert];
   
}

/*
 * 展示自定义AlertView
 */
- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake(SCREEN_WIDTH/2-MyEditorWidth/2, SCREEN_HEIGHT/2- MyEditorHeight*0.5, MyEditorWidth, MyEditorHeight);
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    [topVC.view addSubview:self];
}


- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    
    // 一系列动画效果,达到反弹效果
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.05, 0.05);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounceAnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    [UIView commitAnimations];
    
    [super willMoveToSuperview:newSuperview];
}

#pragma mark - 缩放
- (void)bounceAnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    [UIView commitAnimations];
}

#pragma mark - 缩放
- (void)bounce2AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView commitAnimations];
}


- (void)dismissAlert
{
    [self remove];
}


- (void)remove
{
    [self.backImageView removeFromSuperview];
    
    [self removeFromSuperview];
    
}

@end
