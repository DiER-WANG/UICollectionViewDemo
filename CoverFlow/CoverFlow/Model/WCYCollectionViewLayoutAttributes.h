//
//  WCYCollectionViewLayoutAttributes.h
//  CoverFlow
//
//  Created by wangchangyang on 2018/10/25.
//  Copyright © 2018年 wangchangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCYCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic, assign) BOOL shouldRasterize;
@property (nonatomic, assign) CGFloat maskingValue;

@end

NS_ASSUME_NONNULL_END
