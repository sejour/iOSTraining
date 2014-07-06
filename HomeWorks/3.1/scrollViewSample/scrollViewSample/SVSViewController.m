//
//  SVSViewController.m
//  scrollViewSample
//
//  Created by 武田 祐一 on 2013/04/19.
//  Copyright (c) 2013年 武田 祐一. All rights reserved.
//

#import "SVSViewController.h"

@interface SVSViewController ()

@end

@implementation SVSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // スクロールビューの生成
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:scrollView];
    
    // スクロール対象のイメージビューを生成
    UIImage *image = [UIImage imageNamed:@"big_image.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
    imageView.image = image;
    [scrollView addSubview:imageView];
    
    // スクロールコンテントのサイズを設定
    scrollView.contentSize = imageView.frame.size;
    
    // 画面下端のスクロールが中途半端なところで止まっていたので、インセットを調整
    scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 88.0, 0.0);
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, 88.0, 0.0);
    
    
    // 最小倍率と最大倍率を設定
    scrollView.minimumZoomScale = 0.5;
    scrollView.maximumZoomScale = 3.0;
    
    scrollView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ズーム対象のスクロールビューのサブビューを取得する
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    for (UIView* view in scrollView.subviews) {
        // イメージビューを返す
        if ([view isKindOfClass:[UIImageView class]]) {
            return  view;
        }
    }
    
    return nil;
}

// スクロール中に呼び出される
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 現在のコンテンツの位置を出力
    NSLog(@"(%f, %f)", scrollView.contentOffset.x, scrollView.contentOffset.y);
}

@end
