
//
//  DemoView.m
//  LunBoDemo
//
//  Created by mkrq-yh on 2019/4/17.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "DemoView.h"
#import "DemoFlowLayout.h"
#import "LunBoCollectionViewCell.h"

@interface DemoView()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) DemoFlowLayout *layout;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *modelArray;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, assign) CGFloat cellWidth;

@end


@implementation DemoView

static NSString *cellId = @"cellId";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.cellWidth = frame.size.width/3;

        self.layout = [DemoFlowLayout new];
        self.layout.scale = 0.8;
        self.layout.itemSize = CGSizeMake(frame.size.width/3, frame.size.height);
        self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.layout.minimumLineSpacing = 0;//cell 设置最小行间距
        self.layout.minimumInteritemSpacing = 0;//设置同一列中间隔的cell最小间距。
        self.layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
