//
//  WWCollectionReusableView.m
//  UICollectionViewDemoFlowLayout
//
//  Created by wangchangyang on 2018/10/23.
//  Copyright © 2018年 wangchangyang. All rights reserved.
//

#import "WWCollectionReusableView.h"

@interface WWCollectionReusableView ()
{
    UIView *_redView;
}
@end

@implementation WWCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews {
    _redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [self addSubview:_redView];
    _redView.backgroundColor = [UIColor blackColor];
}

@end
