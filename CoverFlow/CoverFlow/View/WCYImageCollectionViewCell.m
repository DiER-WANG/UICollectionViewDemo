//
//  WCYImageCollectionViewCell.m
//  CoverFlow
//
//  Created by wangchangyang on 2018/10/25.
//  Copyright © 2018年 wangchangyang. All rights reserved.
//

#import "WCYImageCollectionViewCell.h"

@interface WCYImageCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

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
}

- (void)setImageModel:(WCYImageModel *)imageModel {
    _imageModel = imageModel;
    [self setImage:_imageModel.imageName];
}

- (void)setImage:(NSString *)imageName {
    _imageView.image = [UIImage imageNamed:imageName];
}


@end
