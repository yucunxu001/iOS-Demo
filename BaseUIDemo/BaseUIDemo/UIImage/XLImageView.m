//
//  XLImageView.m
//  ZhaiTu
//
//  Created by mkrq-yh on 2019/2/18.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "XLImageView.h"
#import "UIImageView+WebCache.h"

static CGFloat maxZoomScale = 3.0f;
static CGFloat minZoomScale = 1.0f;

@interface XLImageView()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_imageView;
}
@end

@implementation XLImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubViews];
    }
    return self;
}

#pragma mark --setup
- (void)setupSubViews
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = self.bounds;
    _scrollView.delegate = self;
    _scrollView.maximumZoomScale = maxZoomScale;
    _scrollView.minimumZoomScale = minZoomScale;
    _scrollView.showsHorizontalScrollIndicator = false;
    _scrollView.showsVerticalScrollIndicator = false;
    _scrollView.decelerationRate = 0.1f;
//    [_scrollView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    [self addSubview:_scrollView];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.layer.masksToBounds = true;
    [_scrollView addSubview:_imageView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.contentMode = _imageContentMode;
}

#pragma mark -设置图片1-
- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            _loading.progress = (CGFloat)receivedSize/(CGFloat)expectedSize;
        });
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self setImageViewFrame];
        //隐藏加载
//        [_loading hide];
    }];
}
#pragma mark -设置图片2-
- (void)setImageViewFrame
{
    //是否加载出来图片
    if (!_imageView.image) {return;}
    //这只imageview的图片和范围
    _imageView.frame = [self imageViewFrame];
    //设置ScrollView的滚动范围
    CGFloat height = [self imageViewFrame].size.height > _scrollView.bounds.size.height ? [self imageViewFrame].size.height : _scrollView.bounds.size.height + 1;
    _scrollView.contentSize = CGSizeMake(_imageView.bounds.size.width, height);
}
#pragma mark -计算图片frame-
-(CGRect)imageViewFrame
{
    UIImage *image = _imageView.image;
    CGFloat width = self.bounds.size.width;
    CGFloat height = width * image.size.height/image.size.width;
    CGFloat y = height < self.bounds.size.height ? (self.bounds.size.height - height)/2.0f : 0;
    return CGRectMake(0, y, width, height);
}

#pragma mark ScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self updateImageFrame];
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    if (scale != 1) {return;}
    CGFloat height = [self imageViewFrame].size.height > _scrollView.bounds.size.height ? [self imageViewFrame].size.height : _scrollView.bounds.size.height + 1;
    _scrollView.contentSize = CGSizeMake(_imageView.bounds.size.width, height);
}

-(void)updateImageFrame
{
    CGRect imageFrame = _imageView.frame;
    
    if (imageFrame.size.width < self.bounds.size.width) {
        imageFrame.origin.x = (self.bounds.size.width - imageFrame.size.width)/2.0f;
    }else{
        imageFrame.origin.x = 0;
    }
    
    if (imageFrame.size.height < self.bounds.size.height) {
        imageFrame.origin.y = (self.bounds.size.height - imageFrame.size.height)/2.0f;
    }else{
        imageFrame.origin.y = 0;
    }
    
    if (!CGRectEqualToRect(_imageView.frame, imageFrame)){
        _imageView.frame = imageFrame;
    }
}

#pragma mark ScrollView拖拽方法

//-(void)addPanBackBlockPaning:(VoidBlock)paning back:(BoolBlock)back
//{
//    _paningBlock = paning;
//    _panBackBlock = back;
//}
//
//-(void)scrollHandlePan:(UIPanGestureRecognizer*)pan
//{
//    if (_scrollView.zoomScale != 1.0f) {return;}
//    if (_scrollView.contentOffset.y > 0) {return;}
//
//    if (pan.state == UIGestureRecognizerStateEnded) {
//        if (ABS(_scrollView.contentOffset.y) < minPanLength) {
//            _panBackBlock(false);
//            [UIView animateWithDuration:0.35 animations:^{
//                _scrollView.contentInset = UIEdgeInsetsZero;
//            }];
//        }else{
//            [UIView animateWithDuration:0.35 animations:^{
//                CGRect frame = _imageView.frame;
//                frame.origin.y = _scrollView.bounds.size.height;
//                _imageView.frame = frame;
//                self.superview.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
//            }completion:^(BOOL finished) {
//                _panBackBlock(true);
//            }];
//        }
//    }else{
//        _paningBlock();
//        _scrollView.contentInset = UIEdgeInsetsMake(-_scrollView.contentOffset.y, 0, 0, 0);
//        CGFloat alpha = 1 - ABS(_scrollView.contentOffset.y/(_scrollView.bounds.size.height));
//        self.superview.backgroundColor = [UIColor colorWithWhite:0 alpha:alpha];
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
