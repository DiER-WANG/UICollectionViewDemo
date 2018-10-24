;//
//  WCYCollectionViewFlowLayout.m
//  Dimension
//
//  Created by 王昌阳 on 2018/10/24.
//  Copyright © 2018年 王昌阳. All rights reserved.
//

#import "WCYCollectionViewFlowLayout.h"

@implementation WCYCollectionViewFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        CGFloat inset = 15;
        CGFloat width = (CGRectGetWidth([UIApplication sharedApplication].keyWindow.bounds) - inset * 4) / 3.f;
        self.itemSize = CGSizeMake(width, width);
        self.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
        self.minimumLineSpacing = inset;
        self.minimumInteritemSpacing  = inset;
    }
    return self;
}

- (void)applyLayoutAttributes:(WCYCollectionViewLayoutAttributes *)attributes {
    // cell
    if (attributes.representedElementKind == nil) {
        attributes.layoutMode = self.layoutMode;
        if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:layoutModeForItemAtIndexPath:)]) {
            attributes.layoutMode = [(id<WCYCollectionViewFlowLayoutDelegate>)self.collectionView.delegate collectionView:self.collectionView layout:self layoutModeForItemAtIndexPath:attributes.indexPath];
        }
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attrArr = [super layoutAttributesForElementsInRect:rect];
    for (WCYCollectionViewLayoutAttributes *attr in attrArr) {
        [self applyLayoutAttributes:attr];
    }
    return attrArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    WCYCollectionViewLayoutAttributes *attr = (WCYCollectionViewLayoutAttributes *)[super layoutAttributesForItemAtIndexPath:indexPath];
    [self applyLayoutAttributes:attr];
    return attr;
}

+ (Class)layoutAttributesClass {
    return WCYCollectionViewLayoutAttributes.class;
}

- (void)setLayoutMode:(WCYCollectionViewFlowLayoutMode)layoutMode {
    _layoutMode = layoutMode;
    [self invalidateLayout];
}

@end
