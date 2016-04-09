//
//  ShopModel.h
//  WaterFlowLayout
//
//  Created by 焦星星 on 16/4/8.
//  Copyright © 2016年 jxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShopModel : NSObject
@property (nonatomic ,copy) NSString *img;
@property (nonatomic , copy) NSString *price;
@property (nonatomic ,assign) CGFloat h;
@property (nonatomic ,assign) CGFloat w;
@end
