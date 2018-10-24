//
//  WCYCollectionViewLayoutAttributes.h
//  Dimension
//
//  Created by 王昌阳 on 2018/10/24.
//  Copyright © 2018年 王昌阳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WCYCollectionViewFlowLayoutMode) {
    WCYCollectionViewFlowLayoutModeAspectFit,
    WCYCollectionViewFlowLayoutModeAspectFill
};

NS_ASSUME_NONNULL_BEGIN

@interface WCYCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic, assign) WCYCollectionViewFlowLayoutMode layoutMode;

@end

NS_ASSUME_NONNULL_END
