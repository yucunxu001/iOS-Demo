//
//  CardView.m
//  LunBoDemo
//
//  Created by mkrq-yh on 2019/4/17.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "CardView.h"
#import "CardLayOut.h"
#import "LunBoCollectionViewCell.h"

@interface CardView()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) CardLayOut *layout;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *modelArray;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, assign) CGFloat cellWidth;

@end

@implementation CardView

static NSString *cellId = @"cellId";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.layout = [CardLayOut new];
        self.layout.scale = 1.1;
        self.layout.itemSize = CGSizeMake(frame.size.width/3, frame.size.height*0.9);
        self.layout.spacing = 0;
        self.layout.edgeInset = UIEdgeInsetsMake(0, 0, 0, 0);;
        self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        self.cellWidth = frame.size.width/3;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:self.layout];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.backgroundColor = [UIColor redColor];
        [self.collectionView registerClass:[LunBoCollectionViewCell class] forCellWithReuseIdentifier:cellId];
        [self addSubview:self.collectionView];
    }
    return self;
}


- (void)setData:(NSMutableArray *)data {
    [self.modelArray removeAllObjects];
    [self.dataArray removeAllObjects];

    if (data.count<=0) {
        return;
    }
    [self.modelArray addObjectsFromArray:data];
    [self.dataArray addObjectsFromArray:data];
    
    NSInteger index = 10;
    for (int i = 0; i<index; i++) {
        if (self.modelArray.count > 1000) {
            return;
        }
        [self.modelArray addObjectsFromArray:self.modelArray];
    }
    [self.collectionView reloadData];
    CGPoint point = CGPointMake(0+(self.modelArray.count/2*_cellWidth),self.collectionView.contentOffset.y);
    [self.collectionView setContentOffset:point animated:NO];
    
}

-(NSMutableArray *)modelArray
{
    if (!_modelArray) {
        _modelArray = [[NSMutableArray alloc]init];
    }
    return _modelArray;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LunBoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[LunBoCollectionViewCell alloc] init];
    }
    NSInteger tag = indexPath.row%self.dataArray.count;
    NSDictionary *dict = self.dataArray[tag];
    [cell setUpAllChildView:dict ForRowAtIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger tag = indexPath.row%self.dataArray.count;
    NSLog(@"indexPath.row==%ld",indexPath.row);
    NSLog(@"_dataArray.count==%ld",self.dataArray.count);
    NSLog(@"_modelArray.count==%ld",self.modelArray.count);
    NSLog(@"tag==%ld",tag);
    NSLog(@"itemSize.width==%f",self.layout.itemSize.width);

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView.contentOffset.x<300) {
//        CGPoint point = CGPointMake(0+(self.modelArray.count/2*self.frame.size.height*itemHeight),self.collectionView.contentOffset.y);
//        [self.collectionView setContentOffset:point animated:NO];
//
//    }else if (scrollView.contentOffset.x>(self.modelArray.count*self.frame.size.height*itemHeight)-500){
//        CGPoint point = CGPointMake(0+(self.modelArray.count/2*self.frame.size.height*itemHeight),self.collectionView.contentOffset.y);
//        [self.collectionView setContentOffset:point animated:NO];
//    }
    
//    NSLog(@"scrollView.contentOffset.x==%f",scrollView.contentOffset.x);
//    NSLog(@"offsetX==%f",self.cellWidth*self.modelArray.count*0.9);
    
    if (scrollView.contentOffset.x < self.collectionView.frame.size.width) {
        NSLog(@"到头了");
        CGPoint point = CGPointMake(0+(self.modelArray.count/2*_cellWidth),self.collectionView.contentOffset.y);
        [self.collectionView setContentOffset:point animated:NO];
    } else if (scrollView.contentOffset.x > (self.cellWidth*self.modelArray.count*0.9-self.collectionView.frame.size.width)) {
        NSLog(@"到尾了");
        CGPoint point = CGPointMake(0+(self.modelArray.count/2*_cellWidth),self.collectionView.contentOffset.y);
        [self.collectionView setContentOffset:point animated:NO];
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
