//
//  WCYImageCollectionViewCell.m
//  CoverFlow
//
//  Created by wangchangyang on 2018/10/25.
//  Copyright © 2018年 wangchangyang. All rights reserved.
//

#import "WCYImageCollectionViewCell.h"
#import "WCYCollectionViewLayoutAttributes.h"

@interface WCYImageCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *maskView;

@end

@implementation WCYImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    [self.contentView addSubview:_imageView];
    
    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    [self.contentView addSubview:_maskView];
    //_maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = 0;
}

- (void)setImageModel:(WCYImageModel *)imageModel {
    _imageModel = imageModel;
    [self setImage:_imageModel.imageName];
}

- (void)setImage:(NSString *)imageName {
    _imageView.image = [UIImage imageNamed:imageName];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    _maskView.alpha = 0;
    self.layer.shouldRasterize = NO;
    if (![layoutAttributes isKindOfClass:[WCYCollectionViewLayoutAttributes class]]) {
        return;
    }
    WCYCollectionViewLayoutAttributes *attr = (WCYCollectionViewLayoutAttributes *)layoutAttributes;
    self.layer.shouldRasterize = attr.shouldRasterize;
    _maskView.alpha = attr.alpha;
}

@end
