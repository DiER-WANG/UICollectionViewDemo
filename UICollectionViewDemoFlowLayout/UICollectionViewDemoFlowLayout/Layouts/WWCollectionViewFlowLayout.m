//
//  WWCollectionViewFlowLayout.m
//  UICollectionViewDemoFlowLayout
//
//  Created by wangchangyang on 2018/10/22.
//  Copyright © 2018年 wangchangyang. All rights reserved.
//

#import "WWCollectionViewFlowLayout.h"
#import "WWCollectionReusableView.h"

NSString * const WWCollectionViewFlowLayoutBackgroundDecorationView = @"WWCollectionViewFlowLayoutBackgroundDecorationView";

@implementation WWCollectionViewFlowLayout
{
    NSMutableSet *_insertedSet;
}
- (instancetype)init {
    if (self = [super init]) {
        self.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
        self.minimumInteritemSpacing = 10;
        self.minimumLineSpacing = 10;
        self.headerReferenceSize = CGSizeMake(0, 44);
        [self registerClass:WWCollectionReusableView.class forDecorationViewOfKind:WWCollectionViewFlowLayoutBackgroundDecorationView];
        
        _insertedSet = [NSMutableSet set];
    }
    return self;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributesArr = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *newArr = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attributes in attributesArr) {
        [self applyLayoutAttributes:attributes];
        
        if (attributes.representedElementCategory == UICollectionElementCategorySupplementaryView) {
            UICollectionViewLayoutAttributes *newAttr = [self layoutAttributesForDecorationViewOfKind:WWCollectionViewFlowLayoutBackgroundDecorationView atIndexPath:attributes.indexPath];
            [newArr addObject:newAttr];
        }
    }
    attributesArr = [attributesArr arrayByAddingObjectsFromArray:newArr];
    return attributesArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    [self applyLayoutAttributes:attributes];
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
    if ([elementKind isEqualToString:WWCollectionViewFlowLayoutBackgroundDecorationView]) {
        UICollectionViewLayoutAttributes *tallestCellAttr = nil;
        NSInteger numberOfCellsInSection = [self.collectionView numberOfItemsInSection:indexPath.section];
        for (NSUInteger i = 0; i < numberOfCellsInSection; i++) {
            NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
            UICollectionViewLayoutAttributes *cellAttr = [self layoutAttributesForItemAtIndexPath:cellIndexPath];
            if (CGRectGetHeight(cellAttr.frame) > CGRectGetHeight(tallestCellAttr.frame)) {
                tallestCellAttr = cellAttr;
            }
        }
        CGFloat decorationHeight = CGRectGetHeight(tallestCellAttr.frame);
        attr.size = CGSizeMake([self collectionViewContentSize].width, decorationHeight);
        attr.center = CGPointMake([self collectionViewContentSize].width * 0.5, tallestCellAttr.center.y);
        
        attr.zIndex = -1;
    }
    return attr;
}

#pragma mark - Logic
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes {
    if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
        CGFloat width = [self collectionViewContentSize].width;
        CGFloat leftMargin = [self sectionInset].left;
        CGFloat rightMargin = [self sectionInset].right;
        
        NSUInteger itemsInSection = [[self collectionView] numberOfItemsInSection:attributes.indexPath.section];
        
        CGFloat firstXPosition = (width - leftMargin - rightMargin) / (2 * itemsInSection);
        CGFloat xPosition = firstXPosition + 2 * firstXPosition * attributes.indexPath.item;
        
        attributes.center = CGPointMake(leftMargin + xPosition, attributes.center.y);
        attributes.frame = CGRectIntegral(attributes.frame);
    }
}


#pragma mark - 更新
- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems {
    [super prepareForCollectionViewUpdates:updateItems];
    
    [updateItems enumerateObjectsUsingBlock:^(UICollectionViewUpdateItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.updateAction == UICollectionUpdateActionInsert) {
            [self->_insertedSet addObject:@(obj.indexPathAfterUpdate.section)];
        }
    }];
}

- (void)finalizeCollectionViewUpdates {
    [super finalizeCollectionViewUpdates];
    [_insertedSet removeAllObjects];
}

#pragma mark - 动画
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingDecorationElementOfKind:(NSString *)elementKind
                                                                                     atIndexPath:(NSIndexPath *)decorationIndexPath {
    UICollectionViewLayoutAttributes *attr = nil;
    if ([elementKind isEqualToString:WWCollectionViewFlowLayoutBackgroundDecorationView]) {
        if ([_insertedSet
             containsObject:@(decorationIndexPath.section)]) {
            attr = [self layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:decorationIndexPath];
            attr.alpha = 0.0f;
            attr.transform3D = CATransform3DMakeTranslation(-CGRectGetWidth(attr.frame), 0, 0);
        }
    }
    return attr;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes *layoutAttributes;
    if ([_insertedSet containsObject:@(itemIndexPath.section)]) {
        layoutAttributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        layoutAttributes.transform3D = CATransform3DMakeTranslation( [self collectionViewContentSize].width, 0, 0);
    }
    return layoutAttributes;
}

@end
