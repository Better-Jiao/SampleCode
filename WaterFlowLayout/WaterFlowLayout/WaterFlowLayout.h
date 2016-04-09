//
//  WaterFlowLayout.h
//  WaterFlowLayout
//
//  Created by 焦星星 on 16/4/8.
//  Copyright © 2016年 jxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopModel.h"
@class WaterFlowLayout;

@protocol WaterFlowLayoutDelegate <NSObject>

@required
- (CGFloat)WaterFlowLayout:(WaterFlowLayout *)waterFlowLayout heightForItemAtIndexpath:(NSIndexPath *)indexPath itemWidth:(CGFloat)width;
@optional


/** 指定多少列 */
- (NSInteger)numberOfColunmForWaterFlowLayout:(WaterFlowLayout *)waterFlowLayout;
/** 指定列间隙 */
- (CGFloat)colunmMarginForWaterFlowLayout:(WaterFlowLayout *)waterFlowLayout;
/** 指定行间隙 */
- (CGFloat)rowMarginForWaterFlowLayout:(WaterFlowLayout *)waterFlowLayout;
/** 指定边缘间隙 */
- (UIEdgeInsets)edgeInsetsForWaterFlowLayout:(WaterFlowLayout *)waterFlowLayout;
/** 这些数据也可以通过属性来设置，但属性设置的会，可以随时去更改其值，这样的话就不可控，不太好。 */
@end


@interface WaterFlowLayout : UICollectionViewLayout
@property (nonatomic ,strong) NSMutableArray *shops;
@property (nonatomic ,weak) id<WaterFlowLayoutDelegate> delegate;
@end
