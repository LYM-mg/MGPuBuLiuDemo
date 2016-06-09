//
//  ViewController.m
//  MGPuBuLiuDemo
//
//  Created by ming on 16/6/9.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ViewController.h"
#import "MGWaterflowLayout.h"
#import "MGShopCell.h"
#import "MGShopModel.h"
#import "MJRefresh.h"
#import "MJExtension.h"

static NSString *const ShopCellIdentifier = @"ShopCellIdentifier";

@interface ViewController ()<UICollectionViewDataSource>
/** 所有的商品数据 */
@property (nonatomic, strong) NSMutableArray *shops;

@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation ViewController

- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpLayout];
}

- (void)setUpLayout{
    // 创建布局
    MGWaterflowLayout *flowLayout = [[MGWaterflowLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.frame = self.view.frame;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MGShopCell class]) bundle:nil] forCellWithReuseIdentifier:ShopCellIdentifier];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 39;
//    self.collectionView.footer.hidden = self.shops.count == 0;
//    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     MGShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShopCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    
    return cell;
}

@end
