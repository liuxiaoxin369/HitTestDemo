//
//  SelectSectionView.m
//  HitTestDemo
//
//  Created by qzwh on 2018/10/24.
//  Copyright © 2018年 qianjinjia. All rights reserved.
//

#import "SelectSectionView.h"

#define kWidthAndHeight      50
#define kSCREEN_WIDTH           [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT          [UIScreen mainScreen].bounds.size.height

@interface SelectSectionView ()
@property (nonatomic, strong) NSArray *sectionTitleArr;
@property (nonatomic, strong) UILabel *suspendLabel;
@end

@implementation SelectSectionView

- (instancetype)initSectionTitleArr:(NSArray *)sectionTitleArr; {
    self = [super init];
    if (self) {
        self.sectionTitleArr = sectionTitleArr;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    CGFloat height = self.sectionTitleArr.count*kWidthAndHeight;
    self.frame = CGRectMake(kSCREEN_WIDTH-kWidthAndHeight, (kSCREEN_HEIGHT-height)/2, kWidthAndHeight, height);
    
    CGFloat y = 0;
    for (int i = 0; i < self.sectionTitleArr.count; i++) {
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 50, 50)];
        label.userInteractionEnabled = YES;
        label.tag = 200 + i;
        label.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
        label.text = [NSString stringWithFormat:@"%d", i];
        [self addSubview:label];
        
        y += 50;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.allObjects.firstObject;
    [self appearSuspend:touch];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.allObjects.firstObject;
    [self appearSuspend:touch];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hiddenSuspend];
}

- (void)appearSuspend:(UITouch *)touch {
    CGPoint point = [touch locationInView:self];
    NSLog(@"--------%@", NSStringFromCGPoint(point));
    //如果点击的位置超出当前视图范围   就隐藏悬浮视图
    if (!CGRectContainsPoint(self.bounds, point)) {
        [self hiddenSuspend];
        return;
    }
    
    for (int i = 0; i < self.sectionTitleArr.count; i++) {
        UILabel *label = (UILabel *)[self viewWithTag:200 + i];
        
        if (CGRectContainsPoint(label.frame, point)) {
            if ([self.delegate respondsToSelector:@selector(currentLocationWithIndex:)]) {
                self.suspendLabel.alpha = 1;
                self.suspendLabel.text = label.text;
                [self.delegate currentLocationWithIndex:label.tag - 200];
            }
        }
    }
}

- (void)hiddenSuspend {
    [UIView animateWithDuration:1 animations:^{
        self.suspendLabel.alpha = 0;
    }];
}

- (UILabel *)suspendLabel {
    if (!_suspendLabel) {
        _suspendLabel = [[UILabel alloc] initWithFrame:CGRectMake((kSCREEN_WIDTH-100)/2, (kSCREEN_HEIGHT-100)/2, 100, 100)];
        _suspendLabel.backgroundColor = [UIColor lightGrayColor];
        _suspendLabel.font = [UIFont systemFontOfSize:20];
        _suspendLabel.alpha = 0;
        [self.superview addSubview:_suspendLabel];
    }
    return _suspendLabel;
}

@end
