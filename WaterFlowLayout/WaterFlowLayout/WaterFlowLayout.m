//
//  WaterFlowLayout.m
//  WaterFlowLayout
//
//  Created by 焦星星 on 16/4/8.
//  Copyright © 2016年 jxx. All rights reserved.
//
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height
#import "WaterFlowLayout.h"

static const NSInteger defaultColumnCount = 3;
static const CGFloat defaultColumnMargin = 10;
static const CGFloat defaultRowMargin = 10;
static const UIEdgeInsets defaultCollectionEdge = {10,10,10,10};
@interface WaterFlowLayout ()
@property (nonatomic ,strong) NSMutableArray *itemsArray;
@property (nonatomic ,strong) NSMutableArray *columsHeights;
@end

@implementation WaterFlowLayout

-(NSMutableArray *)itemsArray
{
    if (_itemsArray == nil) {
        _itemsArray = [NSMutableArray array];
    }
    return _itemsArray;
}

-(NSMutableArray *)columsHeights
{
    if (_columsHeights == nil) {
        _columsHeights = [NSMutableArray arrayWithArray:@[@0.0,@0.0,@0.0]];
    }
    return _columsHeights;
}



/*
 *初次布局会调用，后布局改变会调用。
 *
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    [self.itemsArray removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i ++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
        // 每个cell的布局属性。
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexpath];
        [self.itemsArray addObject:attr];
    }

}



/*
 *返回包含属性的数组
 */
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{

    return self.itemsArray;
    
}
/** 测试 */


/*
 * 返回item对应的attr
 */

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 为cell新建一个layout属性
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // 判断代理是否帮忙实现数据的方法，没有则用默认的。
    NSInteger colunmCount = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfColunmForWaterFlowLayout:)]) {
        colunmCount = [self.delegate numberOfColunmForWaterFlowLayout:self];
    }else{
        colunmCount = defaultColumnCount;
    }
    
    UIEdgeInsets collectionEdge = {0,0,0,0};
    if ([self.delegate respondsToSelector:@selector(edgeInsetsForWaterFlowLayout:)]) {
        collectionEdge = [self.delegate edgeInsetsForWaterFlowLayout:self];
    }else{
        collectionEdge = defaultCollectionEdge;
    }
    
    CGFloat rowMargin = 0;
    if ([self.delegate respondsToSelector:@selector(rowMarginForWaterFlowLayout:)]) {
        rowMargin = [self.delegate rowMarginForWaterFlowLayout:self];
    }else{
        rowMargin = defaultRowMargin;
    }
    
    CGFloat columnMargin = 0;
    if ([self.delegate respondsToSelector:@selector(colunmMarginForWaterFlowLayout:)]) {
        columnMargin = [self.delegate colunmMarginForWaterFlowLayout:self];
    }else{
        columnMargin = defaultColumnMargin;
    }
    
    //核心代码
    CGFloat w = (SCREENW - collectionEdge.left - collectionEdge.right - (colunmCount - 1)*columnMargin) / colunmCount;
    
    CGFloat h = [self.delegate WaterFlowLayout:self heightForItemAtIndexpath:indexPath itemWidth:w];
//  错误做法，已经不是根据row的值来计算了，而是根据哪条短数据就添加到哪条。
//  CGFloat x = indexPath.row % columnCount * (w + columnMargin) + collectionEdge.left;
    NSInteger minColunm = 0;
    CGFloat minY = MAXFLOAT;
    for (int i = 0; i < self.columsHeights.count; i++) {
        if (minY > [self.columsHeights[i] doubleValue]) {
            minY = [self.columsHeights[i] doubleValue];
            minColunm = i;
        }
    }

    CGFloat x = minColunm * (w + columnMargin) + collectionEdge.left;
    CGFloat y = minY + rowMargin;
    attr.frame = CGRectMake(x, y, w, h);
    self.columsHeights[minColunm] = [NSNumber numberWithDouble: CGRectGetMaxY(attr.frame)];
    
    attr.frame = CGRectMake(x, y, w, h);
    self.columsHeights[minColunm] = [NSNumber numberWithDouble: CGRectGetMaxY(attr.frame)];
    return attr;
}


- (CGSize)collectionViewContentSize
{
    
    CGFloat manY = 0;
    for (int i = 0; i < self.columsHeights.count; i++) {
        if (manY < [self.columsHeights[i] doubleValue]) {
            manY = [self.columsHeights[i] doubleValue];
        }
    }
    
    return CGSizeMake(0,manY);
}
@end
