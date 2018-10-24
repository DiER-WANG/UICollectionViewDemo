//
//  WCYCollectionViewFlowLayout.h
//  Dimension
//
//  Created by 王昌阳 on 2018/10/24.
//  Copyright © 2018年 王昌阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCYCollectionViewLayoutAttributes.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WCYCollectionViewFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

@optional
- (WCYCollectionViewFlowLayoutMode)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)layout layoutModeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface WCYCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) WCYCollectionViewFlowLayoutMode layoutMode;

@end

NS_ASSUME_NONNULL_END
