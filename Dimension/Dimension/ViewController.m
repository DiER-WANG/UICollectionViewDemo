//
//  ViewController.m
//  Dimension
//
//  Created by 王昌阳 on 2018/10/24.
//  Copyright © 2018年 王昌阳. All rights reserved.
//

#import "ViewController.h"
#import "WCYImageModel.h"
#import "WCYCollectionViewFlowLayout.h"
#import "WCYImageCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource, WCYCollectionViewFlowLayoutDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) WCYCollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *photoCollectionView;
@property (nonatomic, strong) NSMutableArray *imagesArr;

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Aspect Fit", @"Square"]];
    _segmentedControl.selectedSegmentIndex = 0;
    [_segmentedControl addTarget:self action:@selector(segmentValueChange:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segmentedControl;
    
    _imagesArr = [NSMutableArray array];
    for (NSUInteger i = 0; i < 3; i++) {
        WCYImageModel *image = [WCYImageModel new];
        image.imageName = [self imageNameForIndex:i];
        image.imageBgColor = [self imageBgColor];
        [_imagesArr addObject:image];
    }

    _flowLayout = [[WCYCollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_flowLayout];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[WCYImageCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass(WCYImageCollectionViewCell.class)];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.allowsSelection = NO;
    
    [_collectionView reloadData];
}

- (void)segmentValueChange:(UISegmentedControl *)seg {
    _flowLayout.layoutMode = (seg.selectedSegmentIndex == 0 ? WCYCollectionViewFlowLayoutModeAspectFit:WCYCollectionViewFlowLayoutModeAspectFill);
}

- (WCYImageModel *)imageModelForIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item >= [_imagesArr count]) {
        return nil;
    }
    return _imagesArr[indexPath.row];
}

- (void)configCell:(WCYImageCollectionViewCell *)cell ForIndexPath:(NSIndexPath *)indexPath {
    [cell setImageModel:[self imageModelForIndexPath:indexPath]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imagesArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WCYImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(WCYImageCollectionViewCell.class) forIndexPath:indexPath];
    [self configCell:cell ForIndexPath:indexPath];
    return cell;
}
- (WCYCollectionViewFlowLayoutMode)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)layout layoutModeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _flowLayout.layoutMode;
}


- (UIColor *)imageBgColor {
    return [UIColor colorWithRed:arc4random_uniform(255)/255.f green:arc4random_uniform(255)/255.f blue:arc4random_uniform(255)/255.f alpha:1];
}

- (NSString *)imageNameForIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"img%@", @(index)];
}

@end
