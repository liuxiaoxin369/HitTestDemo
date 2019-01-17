//
//  SelectSectionView.h
//  HitTestDemo
//
//  Created by qzwh on 2018/10/24.
//  Copyright © 2018年 qianjinjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectSectionViewDelegate <NSObject>

//当前位于的下标
- (void)currentLocationWithIndex:(NSInteger)index;

@end


@interface SelectSectionView : UIView

- (instancetype)initSectionTitleArr:(NSArray *)sectionTitleArr;

@property (nonatomic, weak) id<SelectSectionViewDelegate> delegate;

@end

