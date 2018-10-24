//
//  WCYCollectionViewCoverFlowLayout.m
//  CoverFlow
//
//  Created by wangchangyang on 2018/10/25.
//  Copyright © 2018年 wangchangyang. All rights reserved.
//

#import "WCYCollectionViewCoverFlowLayout.h"
#import "WCYCollectionViewLayoutAttributes.h"

@implementation WCYCollectionViewCoverFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.itemSize = CGSizeMake(180, 180);
        self.minimumInteritemSpacing = 200;
    }
    return self;
}

+ (Class)layoutAttributesClass {
    return WCYCollectionViewLayoutAttributes.class;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attr = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x,
                                    self.collectionView.contentOffset.y,
                                    CGRectGetWidth(self.collectionView.bounds),
                                    CGRectGetHeight(self.collectionView.bounds));
    for (UICollectionViewLayoutAttributes *tmpAttr in attr) {
        [self applyLayoutAttributes:tmpAttr forVisibleRect:visibleRect];
    }
    return attr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x,
                                    self.collectionView.contentOffset.y,
                                    CGRectGetWidth(self.collectionView.bounds),
                                    CGRectGetHeight(self.collectionView.bounds));
    [self applyLayoutAttributes:attributes forVisibleRect:visibleRect];
    return attributes;
}


- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes forVisibleRect:(CGRect)visibleRect {
    if (attributes.representedElementKind) return;
    CGFloat distanceFromVisibleRectToItem = CGRectGetMidX(visibleRect) - attributes.center.x;
    CGFloat normalizedDistance = distanceFromVisibleRectToItem / ACTIVE_DISTANCE;
    BOOL isLeft = distanceFromVisibleRectToItem > 0;
    CATransform3D transform = CATransform3DIdentity;
    CGFloat maskAlpha = 0.0f;
    
    if (fabs(distanceFromVisibleRectToItem) < ACTIVE_DISTANCE) {
        
        transform = CATransform3DTranslate( CATransform3DIdentity,
                                           (isLeft? - FLOW_OFFSET : FLOW_OFFSET)*
                                           ABS(distanceFromVisibleRectToItem/TRANSLATE_DISTANCE), 0,
                                           (1 - fabs(normalizedDistance)) * 40000 + (isLeft? 200 : 0));
        // Set the perspective of the transform.
        transform.m34 = -1/(4.6777f * self.itemSize.width);
        // Set the zoom factor.
        CGFloat zoom = 1 + ZOOM_FACTOR*(1 - ABS(normalizedDistance));
        transform = CATransform3DRotate(transform,
                                        (isLeft? 1 : -1) * fabs(normalizedDistance) * 45 * M_PI / 180,
                                        0,
                                        1,
                                        0);
        transform = CATransform3DScale(transform, zoom, zoom, 1);
        attributes.zIndex = 1;
        CGFloat ratioToCenter = (ACTIVE_DISTANCE - fabs(distanceFromVisibleRectToItem)) / ACTIVE_DISTANCE;
        // Interpolate between 0.0f and INACTIVE_GREY_VALUE
        maskAlpha = INACTIVE_GREY_VALUE + ratioToCenter * (-INACTIVE_GREY_VALUE);
    } else {
        transform.m34 = -1/(4.6777 * self.itemSize.width);
        transform = CATransform3DTranslate(transform,
                                           isLeft? -FLOW_OFFSET : FLOW_OFFSET, 0, 0);
        transform = CATransform3DRotate(transform, (isLeft? 1 : -1) * 45 * M_PI / 180, 0, 1, 0);
        attributes.zIndex = 0;
        maskAlpha = INACTIVE_GREY_VALUE;
    }
    
    attributes.transform3D = transform;
    // Rasterize the cells for smoother edges.
    [(WCYCollectionViewLayoutAttributes *)attributes setShouldRasterize:YES];
    [(WCYCollectionViewLayoutAttributes *)attributes setMaskingValue:maskAlpha];
}

@end
