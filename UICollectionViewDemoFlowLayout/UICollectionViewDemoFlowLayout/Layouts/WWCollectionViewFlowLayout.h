//
//  WWCollectionViewFlowLayout.h
//  UICollectionViewDemoFlowLayout
//
//  Created by wangchangyang on 2018/10/22.
//  Copyright © 2018年 wangchangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMaxItemDimension 100.f
#define kMaxItemSize      CGSizeMake(kMaxItemDimension, kMaxItemDimension)

UIKIT_EXTERN NSString * const WWCollectionViewFlowLayoutBackgroundDecorationView;


NS_ASSUME_NONNULL_BEGIN

@interface WWCollectionViewFlowLayout : UICollectionViewFlowLayout

@end

NS_ASSUME_NONNULL_END
