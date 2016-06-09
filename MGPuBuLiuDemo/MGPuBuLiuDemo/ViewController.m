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
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MGShopCell class]) bundle:nil] forCellWithReuseIdentifier:ShopCellIdentifier];
    self.collectionView = collectionView;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    self.collectionView.footer.hidden = self.shops.count == 0;
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     XMGShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XMGShopId forIndexPath:indexPath];
    
    
    return cell;
}

@end
