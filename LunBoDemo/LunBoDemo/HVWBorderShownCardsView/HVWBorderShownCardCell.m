//
//  HVWBorderShownCardCell.m
//  LunBoDemo
//
//  Created by mkrq-yh on 2019/4/15.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "HVWBorderShownCardCell.h"

@interface HVWBorderShownCardCell()

@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation HVWBorderShownCardCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.layer.cornerRadius = 4;
    _imageView.layer.masksToBounds = YES;
    [self addSubview:_imageView];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = image;
}

@end
