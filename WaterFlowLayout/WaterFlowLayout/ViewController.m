//
//  ViewController.m
//  WaterFlowLayout
//
//  Created by 焦星星 on 16/4/8.
//  Copyright © 2016年 jxx. All rights reserved.
//

#import "ViewController.h"
#import "WaterFlowLayout.h"
#import "MJExtension.h"
#import "ShopModel.h"
#import "ShopCell.h"
#import "UIImageView+WebCache.h"
static NSString * const cellID = @"cell";

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterFlowLayoutDelegate>
@property (nonatomic , weak) UICollectionView  *collectionView;
@property (nonatomic ,strong) NSMutableArray *shops;
@end

@implementation ViewController


-(NSMutableArray *)shops
{
    if (_shops == nil) {
        _shops = [ShopModel mj_objectArrayWithFile:[[NSBundle mainBundle] pathForResource:@"1.plist" ofType:nil]];
    }
    return _shops;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLayout];
}

- (void)setupLayout
{
    // 创建布局
    WaterFlowLayout *layout = [[WaterFlowLayout alloc] init];
    layout.delegate = self;
//    layout.delegate = self;
    //UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:@"ShopCell" bundle:nil] forCellWithReuseIdentifier:cellID];

    self.collectionView = collectionView;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    ShopModel *model = self.shops[indexPath.row];
    
    [cell.shopImage sd_setImageWithURL:[NSURL URLWithString:model.img]];
    cell.priceLabel.text = model.price;
    return cell;
}

- (CGFloat)WaterFlowLayout:(WaterFlowLayout *)waterFlowLayout heightForItemAtIndexpath:(NSIndexPath *)indexPath itemWidth:(CGFloat)width
{
    ShopModel *model = self.shops[indexPath.row];
    return model.h / model.w * width;
}

/*  实现代理，改变布局。
- (NSInteger)numberOfColunmForWaterFlowLayout:(WaterFlowLayout *)waterFlowLayout
{
    return 3;
}

- (CGFloat)colunmMarginForWaterFlowLayout:(WaterFlowLayout *)waterFlowLayout
{
    return 40;
}


- (CGFloat)rowMarginForWaterFlowLayout:(WaterFlowLayout *)waterFlowLayout
{
    return 60;
}
*/

@end
