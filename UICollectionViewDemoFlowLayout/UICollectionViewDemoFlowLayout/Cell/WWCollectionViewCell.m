//
//  WWCollectionViewCell.m
//  UICollectionViewDemoFlowLayout
//
//  Created by wangchangyang on 2018/10/22.
//  Copyright © 2018年 wangchangyang. All rights reserved.
//

#import "WWCollectionViewCell.h"
#import "WWCollectionViewFlowLayout.h"

@interface WWCollectionViewCell ()
{
    UILabel *_titleLable;
}
@end

@implementation WWCollectionViewCell

- (void)prepareForReuse {
    _titleLable.text = @"";
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.backgroundColor = [UIColor whiteColor];
    _titleLable = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLable];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLable.center = self.contentView.center;
}

- (void)setImageInfo:(WWImageInfoModel *)imageInfo {
    _imageInfo = imageInfo;
    _titleLable.text = _imageInfo.imageName;
    
    CGSize itemSize = kMaxItemSize;
    CGFloat aspectRatio = _imageInfo.imageSize.width/imageInfo.imageSize.height;
    if (aspectRatio < 1) {
        itemSize = CGSizeMake(kMaxItemSize.width*aspectRatio, kMaxItemSize.height);
    } else if (aspectRatio > 1){
        itemSize = CGSizeMake(kMaxItemSize.width, kMaxItemSize.height/aspectRatio);
    }
    _titleLable.frame = CGRectMake(0, 0, itemSize.width, itemSize.height);
    _titleLable.backgroundColor = _imageInfo.bgColor;
}

@end
