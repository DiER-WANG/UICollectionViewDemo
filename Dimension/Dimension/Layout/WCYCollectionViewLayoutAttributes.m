//
//  WCYCollectionViewLayoutAttributes.m
//  Dimension
//
//  Created by 王昌阳 on 2018/10/24.
//  Copyright © 2018年 王昌阳. All rights reserved.
//

#import "WCYCollectionViewLayoutAttributes.h"

@implementation WCYCollectionViewLayoutAttributes

- (id)copyWithZone:(NSZone *)zone {
    WCYCollectionViewLayoutAttributes *atr = [super copyWithZone:zone];
    atr.layoutMode = self.layoutMode;
    return atr;
}

- (BOOL)isEqual:(id)object {
    return [super isEqual:object] && (self.layoutMode == [object layoutMode]);
}

@end
