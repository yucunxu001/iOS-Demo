//
//  PictureView.m
//  ZhaiTu
//
//  Created by mkrq-yh on 2019/2/18.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "PictureView.h"
#import "XLImageView.h"

@interface PictureView ()<UIScrollViewDelegate>
{
    NSInteger cuttentIndex;
    NSInteger firstIndex;
    NSArray *imgArr;
    UIView *bgView;
    //自定义
    UIScrollView *_scrollView;
    
}
@end

@implementation PictureView


- (instancetype)initWithFrame:(CGRect)frame withImg:(NSArray *)array currentIndex:(NSInteger)index from:(UIView *)fview;
{
    self = [super initWithFrame:frame];
    if (self) {
        cuttentIndex = index;
        firstIndex = index;
        imgArr = array;
        bgView = fview;
        [self setupSubViews];
    }
    return self;
}

#pragma mark --setup
- (void)setupSubViews
{
    self.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self];

    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.pagingEnabled = true;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = false;
    _scrollView.showsVerticalScrollIndicator = false;
    _scrollView.backgroundColor = kColorBlack;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    UITapGestureRecognizer *disTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [_scrollView addGestureRecognizer:disTap];
    
    //图片
    if (imgArr.count > 0) {
        for (NSInteger i = 0; i < imgArr.count; i++) {
            XLImageView *_imgView = [[XLImageView alloc] initWithFrame:CGRectMake(i * _scrollView.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
            _imgView.imageUrl = imgArr[i];
            [_scrollView addSubview:_imgView];
        }
        _scrollView.contentSize = CGSizeMake(imgArr.count * _scrollView.bounds.size.width , self.bounds.size.height);
        _scrollView.contentOffset = CGPointMake(cuttentIndex * _scrollView.bounds.size.width, 0);
    }

}

#pragma mark ScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    cuttentIndex = scrollView.contentOffset.x/scrollView.bounds.size.width;
//    _pageLabel.text = [NSString stringWithFormat:@"%zd/%zd",_currentIndex + 1,_containers.count];
}

#pragma mark -消失-
- (void)dismiss
{
    [self removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
