//
//  ViewController.m
//  CoverFlow
//
//  Created by wangchangyang on 2018/10/25.
//  Copyright © 2018年 wangchangyang. All rights reserved.
//

#import "ViewController.h"
#import "WCYCollectionViewCoverFlowLayout.h"
#import "WCYImageModel.h"
#import "WCYImageCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *imagesArr;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) UICollectionViewFlowLayout *normalFlowLayout;
@property (nonatomic, strong) WCYCollectionViewCoverFlowLayout *coverFlowLayout;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Normal", @"CoverFlow"]];
    self.navigationItem.titleView = _segmentedControl;
    [_segmentedControl addTarget:self
                          action:@selector(segmentedValueChanged:)
                forControlEvents:UIControlEventValueChanged];
    _segmentedControl.selectedSegmentIndex = 0;
    
    _imagesArr = [NSMutableArray new];
    for (NSUInteger i = 0; i < 99; i++) {
        WCYImageModel *image = [WCYImageModel new];
        image.imageName = [self imageNameForIndex:i];
        [_imagesArr addObject:image];
    }
    CGFloat width = 150;
    CGFloat insets = (CGRectGetWidth(self.view.bounds) - width * 2)/3.f;
    _normalFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    _normalFlowLayout.itemSize = CGSizeMake(width, width);
    _normalFlowLayout.minimumLineSpacing = insets;
    _normalFlowLayout.minimumInteritemSpacing = insets;
    
    _coverFlowLayout = [[WCYCollectionViewCoverFlowLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_normalFlowLayout];
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[WCYImageCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass(WCYImageCollectionViewCell.class)];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imagesArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WCYImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(WCYImageCollectionViewCell.class) forIndexPath:indexPath];
    [self configCell:cell atIndexPath:indexPath];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (collectionViewLayout == _normalFlowLayout) {
        return UIEdgeInsetsMake(10, 20, 10, 20);
    } else {
        if (UIDeviceOrientationIsPortrait(self.interfaceOrientation)) {
            return UIEdgeInsetsMake(0, 70, 0, 70);
        } else {
            if (CGRectGetHeight([[UIScreen mainScreen] bounds]) > 480) {
                return UIEdgeInsetsMake(0, 190, 0, 190);
            } else {
                return UIEdgeInsetsMake(0, 150, 0, 150);
            }
        }
    }
    
    return UIEdgeInsetsZero;
}

- (void)configCell:(WCYImageCollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    cell.imageModel = _imagesArr[indexPath.row];
}

- (NSString *)imageNameForIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"img%@", @(index%3)];
}

- (void)segmentedValueChanged:(UISegmentedControl *)segment {
    [_collectionView.collectionViewLayout invalidateLayout];
    if (segment.selectedSegmentIndex == 0) {
        [_collectionView setCollectionViewLayout:_normalFlowLayout
                                        animated:NO];
    } else {
        [_collectionView setCollectionViewLayout:_coverFlowLayout
                                        animated:NO];
    }
}

@end
