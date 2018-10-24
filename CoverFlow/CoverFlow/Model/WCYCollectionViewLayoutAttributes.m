//
//  WCYCollectionViewLayoutAttributes.m
//  CoverFlow
//
//  Created by wangchangyang on 2018/10/25.
//  Copyright © 2018年 wangchangyang. All rights reserved.
//

#import "WCYCollectionViewLayoutAttributes.h"

@implementation WCYCollectionViewLayoutAttributes

-(id)copyWithZone:(NSZone *)zone {
    WCYCollectionViewLayoutAttributes *attributes = [super copyWithZone:zone];
    attributes.shouldRasterize = self.shouldRasterize;
    attributes.maskingValue = self.maskingValue;
    return attributes;
    
}
-(BOOL)isEqual:(WCYCollectionViewLayoutAttributes *)other {
    return [super isEqual:other]
    && (self.shouldRasterize == other.shouldRasterize
        && self.maskingValue == other.maskingValue);
}

@end
