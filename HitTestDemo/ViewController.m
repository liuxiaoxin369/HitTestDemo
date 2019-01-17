//
//  ViewController.m
//  HitTestDemo
//
//  Created by qzwh on 2018/10/24.
//  Copyright © 2018年 qianjinjia. All rights reserved.
//

#import "ViewController.h"
#import "SelectSectionView.h"

@interface ViewController ()<SelectSectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SelectSectionView *sectionView = [[SelectSectionView alloc] initSectionTitleArr:@[@"1", @"2", @"3", @"4", @"5"]];
    sectionView.delegate = self;
    [self.view addSubview:sectionView];
}

- (void)currentLocationWithIndex:(NSInteger)index {
    NSLog(@"当前所在位置是:%ld", index);
}

@end
