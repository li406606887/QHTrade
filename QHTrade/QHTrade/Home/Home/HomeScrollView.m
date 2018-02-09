//
//  HomeScrollView.m
//  RDFuturesApp
//
//  Created by user on 17/3/3.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "HomeScrollView.h"
#import "HomeViewModel.h"
#import "ScrollCollectionViewCell.h"
#import "HomeScrollModel.h"

#define kCount self.modelArray.count


@interface HomeScrollView()<UICollectionViewDelegate,UICollectionViewDataSource>
/***/
@property (nonatomic, strong) HomeViewModel *viewModel;
/***/
@property (nonatomic, strong) UIPageControl *pageControl;
/**计时器*/
@property (nonatomic, strong) NSTimer *timer;
/**当前滚动的位置*/
@property (nonatomic, assign) NSInteger currentIndex;
/**上次滚动的位置*/
@property (nonatomic, assign) NSInteger lastIndex;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIImageView *backimage;


@property (nonatomic, strong) NSMutableArray *modelArray;
@end

@implementation HomeScrollView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (HomeViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews{
    [self addSubview:self.backimage];
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

# pragma mark 跟新约束
-(void)updateConstraints {
    [super updateConstraints];
    [self.backimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_offset(CGSizeMake(120, 50));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-16);
        make.bottom.equalTo(self.mas_bottom);
        make.size.mas_offset(CGSizeMake(60, 20));
    }];
}

-(void)bindViewModel{
    @weakify(self)
    [self.viewModel.refreshScrollUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSArray *array = self.viewModel.awesomeScrollArray;
        if (array.count>0) {
            self.pageControl.numberOfPages = array.count;
            if (self.modelArray.count>0) {
                [self.modelArray removeAllObjects];
            }
            self.modelArray = [NSMutableArray arrayWithArray:array];
            [self.modelArray addObject:array.firstObject];
            [self.modelArray insertObject:array.lastObject atIndex:0];
            [self removeNSTimer];
            [self.collectionView reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
            [self scrollToIndexPath:indexPath animated:YES];
            [self addNSTimer];
        }else{
            self.modelArray = nil;
        }
        [self.collectionView reloadData];
    }];
}

# pragma mark collectionView代理事件
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ScrollCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ScrollCollectionViewCell class])] forIndexPath:indexPath];
    HomeScrollModel *model = self.modelArray[indexPath.row];
    cell.image_url = [NSString stringWithFormat:@"%@%@",imageLink,model.imgUrl];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeScrollModel *model = self.modelArray[indexPath.row];
    [self.viewModel.awesomeScrollClickSubject sendNext:model];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH-32, (SCREEN_WIDTH-32)*0.44);
}

# pragma mark scrollView代理事件
- (void)removeNSTimer {
    [self.timer invalidate];
    self.timer =nil;
}

- (void)addNSTimer {
    if (self.timer == nil) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
        self.timer = timer;
    }
}

- (void)nextPage {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
    [self scrollToIndexPath:indexPath animated:YES];
}

- (void)scrollToIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    if (self.modelArray.count > indexPath.row) {
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:animated];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeNSTimer];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView.dragging != YES) self.userInteractionEnabled = YES;
    if (velocity.x!=0)  self.userInteractionEnabled = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.dragging==NO) {
        [self addNSTimer];
        self.userInteractionEnabled = YES;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = self.frame.size.width;
    self.currentIndex = scrollView.contentOffset.x/width+1;
    
    //当滚动到最后一张图片时，继续滚向后动跳到第一张
    if (scrollView.contentOffset.x == (kCount-1)*width) {
        self.currentIndex = 1;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
        [self scrollToIndexPath:indexPath animated:NO];
        return;
    }
    
    //当滚动到第一张图片时，继续向前滚动跳到最后一张
    if (scrollView.contentOffset.x == 0) {
        self.currentIndex = kCount-2;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
        [self scrollToIndexPath:indexPath animated:NO];
        return;
    }
    self.pageControl.currentPage = self.currentIndex-2;
    
}
# pragma mark 懒加载
-(UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        //设置滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[ScrollCollectionViewCell class] forCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ScrollCollectionViewCell class])]];
    }
    return _collectionView;
}

-(UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        [_pageControl setValue:[UIImage imageNamed:@"kongxin"] forKeyPath:@"pageImage"];
        [_pageControl setValue:[UIImage imageNamed:@"shixin"] forKeyPath:@"currentPageImage"];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.numberOfPages = self.modelArray.count>0 ? self.modelArray.count:1;
    }
    return _pageControl;
}

-(NSInteger)currentIndex {
    if (!_currentIndex) {
        _currentIndex = 1;
    }
    return _currentIndex;
}

-(UIImageView *)backimage {
    if (!_backimage) {
        _backimage = [[UIImageView alloc] init];
        _backimage.image = [UIImage imageNamed:@"Loading_Image"];
        _backimage.contentMode = UIViewContentModeScaleToFill;
    }
    return _backimage;
}
@end
