//
//  WCYImageCollectionViewCell.m
//  Dimension
//
//  Created by 王昌阳 on 2018/10/24.
//  Copyright © 2018年 王昌阳. All rights reserved.
//

#import "WCYImageCollectionViewCell.h"
#import "WCYCollectionViewFlowLayout.h"

@interface WCYImageCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) WCYCollectionViewFlowLayoutMode layoutMode;

@end

@implementation WCYImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [self.contentView addSubview:_imageView];
        _imageView.backgroundColor = [UIColor redColor];
        self.contentView.backgroundColor = [UIColor blackColor];
        _imageView.clipsToBounds = YES;
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self setImage:nil];
}

- (void)setImage:(UIImage *)image {
    _imageView.image = image;
    [self setImageViewFrame];
}

- (void)setImageViewFrame {
    CGSize imageViewSize = self.bounds.size;
    if (_layoutMode == WCYCollectionViewFlowLayoutModeAspectFit) {
        CGSize photoSize = _imageView.image.size;
        CGFloat aspectRatio = photoSize.width / photoSize.height;
        if (aspectRatio < 1) {
             imageViewSize = CGSizeMake(CGRectGetWidth(self.bounds) *
            aspectRatio, CGRectGetHeight(self.bounds));
        } else if (aspectRatio > 1) {
            imageViewSize = CGSizeMake(CGRectGetWidth(self.bounds),
                                       CGRectGetHeight(self.bounds) / aspectRatio);
        }
    }
    _imageView.bounds = CGRectMake(0, 0,
                                  imageViewSize.width, imageViewSize.height);
    _imageView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                   CGRectGetMidY(self.bounds));
}

- (void)setImageModel:(WCYImageModel *)imageModel {
    _imageModel = imageModel;
    [self setImage:[UIImage imageNamed:imageModel.imageName]];
    _imageView.backgroundColor = imageModel.imageBgColor;
}
// -applyLayoutAttributes: is then called after the view is added to the collection view and just before the view is returned from the reuse queue.
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    
    if (![layoutAttributes isKindOfClass:[WCYCollectionViewLayoutAttributes class]]) {
        return;
    }
    WCYCollectionViewLayoutAttributes *castedLayoutAttributes = (WCYCollectionViewLayoutAttributes *)layoutAttributes;
    _layoutMode = castedLayoutAttributes.layoutMode;
    [self setImageViewFrame];
}

@end
