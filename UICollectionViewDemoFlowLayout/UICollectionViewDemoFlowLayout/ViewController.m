//
//  ViewController.m
//  UICollectionViewDemoFlowLayout
//
//  Created by wangchangyang on 2018/10/22.
//  Copyright © 2018年 wangchangyang. All rights reserved.
//

#import "ViewController.h"
#import "WWImageInfoModel.h"
#import "WWCollectionViewCell.h"
#import "WWCollectionViewFlowLayout.h"

@interface ViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
{
    NSMutableArray *_dataSource;
    UICollectionView *_collectionView;
    NSUInteger _numberOrSections;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _numberOrSections = 3;
    _dataSource = [NSMutableArray array];
    for (NSUInteger i = 0; i < 3; i++) {
        WWImageInfoModel *imageInfo = [[WWImageInfoModel alloc] init];
        imageInfo.imageSize = CGSizeMake(arc4random_uniform(99)+1, arc4random_uniform(99)+1);
        imageInfo.imageName = [NSString stringWithFormat:@"%@", @(i)];
        imageInfo.bgColor = [UIColor colorWithRed:arc4random_uniform(255)/255.f green:arc4random_uniform(255)/255.f blue:arc4random_uniform(255)/255.f alpha:1];
        [_dataSource addObject:imageInfo];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
    WWCollectionViewFlowLayout *flowLayout = [[WWCollectionViewFlowLayout alloc] init];
//    flowLayout.minimumInteritemSpacing = 10;
//    flowLayout.minimumLineSpacing = 10;
//    flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
//    flowLayout.itemSize = kMaxItemSize;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
    [collectionView registerClass:[WWCollectionViewCell class]
       forCellWithReuseIdentifier:NSStringFromClass(WWCollectionViewCell.class)];
    [collectionView registerClass:[UICollectionViewCell class]
       forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
              withReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor magentaColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self
            action:@selector(addBtnClicked:)
  forControlEvents:UIControlEventTouchUpInside];
}

- (void)addBtnClicked:(UIButton *)btn {
    [_collectionView performBatchUpdates:^{
        self->_numberOrSections++;
        [self->_collectionView insertSections:[NSIndexSet indexSetWithIndex:0]];
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - delegate and data source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _numberOrSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(WWCollectionViewCell.class) forIndexPath:indexPath];
    WWImageInfoModel *imageInfo = [_dataSource objectAtIndex:indexPath.row];
    cell.imageInfo = imageInfo;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionViewCell *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                          withReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)
                                                                                 forIndexPath:indexPath];
        header.backgroundColor = [UIColor whiteColor];
        return header;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = kMaxItemSize;
    WWImageInfoModel *imageInfo = [_dataSource objectAtIndex:indexPath.row];
    CGFloat aspectRatio = imageInfo.imageSize.width/imageInfo.imageSize.height;
    if (aspectRatio < 1) {
        itemSize = CGSizeMake(kMaxItemSize.width*aspectRatio, kMaxItemSize.height);
    } else if (aspectRatio > 1){
        itemSize = CGSizeMake(kMaxItemSize.width, kMaxItemSize.height/aspectRatio);
    }
    return itemSize;
}

@end
