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

@interface ViewController ()<UICollectionViewDataSource,MGWaterflowLayoutDelegate>
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
    
    [self setupRefresh];
    
    // 第一次刷新手动调用
    [self.collectionView.header beginRefreshing];
}

/// 初始化collectionView
- (void)setUpLayout{
    // 创建布局
    MGWaterflowLayout *flowLayout = [[MGWaterflowLayout alloc] init];
    flowLayout.delegate = self;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];

    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MGShopCell class]) bundle:nil] forCellWithReuseIdentifier:ShopCellIdentifier];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

/// 刷新加载数据
- (void)setupRefresh{
    // 上拉刷新
    self.collectionView.header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSArray *shops = [MGShopModel objectArrayWithFilename:@"1.plist"];
            [self.shops removeAllObjects];
            [self.shops addObjectsFromArray:shops];
            
            // 刷新数据
            [self.collectionView reloadData];
            
            [self.collectionView.header endRefreshing];
        });
    }];
     
    // 下拉刷新
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSArray *shops = [MGShopModel objectArrayWithFilename:@"1.plist"];
            [self.shops addObjectsFromArray:shops];
            
            // 刷新数据
            [self.collectionView reloadData];
            
            [self.collectionView.footer endRefreshing];
        });
    }];
    
    self.collectionView.footer.hidden = YES;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return 39;
    self.collectionView.footer.hidden = self.shops.count == 0;
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     MGShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShopCellIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
     cell.shop = self.shops[indexPath.item];
    
    return cell;
}

#pragma mark - <MGWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(MGWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth
{
    MGShopModel *shop = self.shops[indexPath.item];
    
    return itemWidth * shop.h / shop.w;
}

- (CGFloat)rowMarginInWaterflowLayout:(MGWaterflowLayout *)waterflowLayout
{
    return 20;
}

- (CGFloat)columnCountInWaterflowLayout:(MGWaterflowLayout *)waterflowLayout
{
    if (self.shops.count <= 50) return 2;
    return 3;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(MGWaterflowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(10, 20, 30, 100);
}

@end
