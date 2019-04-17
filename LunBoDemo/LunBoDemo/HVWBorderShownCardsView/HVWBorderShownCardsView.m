//
//  HVWBorderShownCardsView.m
//  LunBoDemo
//
//  Created by mkrq-yh on 2019/4/15.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "HVWBorderShownCardsView.h"
#import "HVWBorderShownCardCell.h"

NSString *const CellIdentifier = @"CellIdentifier";

CGFloat const HorizontalMargin = 15.0;
CGFloat const ItemMargin = 7.0;

@interface HVWBorderShownCardsView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UIScrollView *panScrollView;

@property(nonatomic, assign, getter=isMultiplePages) BOOL multiplePage;
@property(nonatomic, strong) NSTimer *timer;

@end


@implementation HVWBorderShownCardsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    CGFloat collectionViewWidth = self.frame.size.width;
    CGFloat collectionViewHeight = self.frame.size.height;
    CGFloat itemWidth = collectionViewWidth - HorizontalMargin * 2;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemWidth, collectionViewHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = ItemMargin;
    layout.sectionInset = UIEdgeInsetsMake(0, HorizontalMargin, 0, HorizontalMargin);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, collectionViewWidth, collectionViewHeight) collectionViewLayout:layout];
    [self addSubview:collectionView];
    _collectionView = collectionView;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.alwaysBounceHorizontal = YES;
    collectionView.clipsToBounds = NO;
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerClass:[HVWBorderShownCardCell class] forCellWithReuseIdentifier:CellIdentifier];
    
    CGFloat pageScrollWidth = itemWidth + ItemMargin;
    _panScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((collectionView.frame.size.width - pageScrollWidth)/2, 0, pageScrollWidth, collectionViewHeight)];
    
    [self addSubview:_panScrollView];
    _panScrollView.hidden = YES;
    _panScrollView.showsHorizontalScrollIndicator = NO;
    _panScrollView.alwaysBounceHorizontal = YES;
    _panScrollView.pagingEnabled = YES;
    _panScrollView.delegate = self;
    
    [_collectionView addGestureRecognizer:_panScrollView.panGestureRecognizer];
    _collectionView.panGestureRecognizer.enabled = NO;
}

- (void)setImages:(NSArray *)images {
    _images = [images copy];
    [self updateView];
}

- (void)updateView {
    [_collectionView reloadData];
    [self addTimer];
}

- (void)addTimer {
    if (self.timer.isValid) {
        [self.timer invalidate];
    }
    
    self.timer = [NSTimer timerWithTimeInterval:2.0f target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)autoScroll {
    if (_images.count <= 1) {
        return;
    }
    
    // 滚到最后一页的时候，回到第一页
    if (_panScrollView.contentOffset.x >= _panScrollView.frame.size.width * (_images.count - 1)) {
        [_panScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else {
        [_panScrollView setContentOffset:CGPointMake(_panScrollView.contentOffset.x + _panScrollView.frame.size.width, 0) animated:YES];
    }
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    _panScrollView.contentSize = CGSizeMake(_panScrollView.frame.size.width * _images.count, 0);
    return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HVWBorderShownCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (indexPath.item < _images.count) {
        UIImage *image = _images[indexPath.item];
        cell.image = image;
    }
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _panScrollView) {
        _collectionView.contentOffset = _panScrollView.contentOffset;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
