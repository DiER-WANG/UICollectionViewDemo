//
//  WWImageInfoModel.h
//  UICollectionViewDemoFlowLayout
//
//  Created by wangchangyang on 2018/10/22.
//  Copyright © 2018年 wangchangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WWImageInfoModel : NSObject

@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, strong) UIColor *bgColor;

@end

NS_ASSUME_NONNULL_END
