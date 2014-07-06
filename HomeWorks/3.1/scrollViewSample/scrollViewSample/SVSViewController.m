//
//  SVSViewController.m
//  scrollViewSample
//
//  Created by 武田 祐一 on 2013/04/19.
//  Copyright (c) 2013年 武田 祐一. All rights reserved.
//

#import "SVSViewController.h"

@interface SVSViewController ()

// スクロールビュー
@property (nonatomic) UIScrollView *scrollView;
// コンテンツのイメージビュー
@property (nonatomic) UIImageView *imageView;

@end

@implementation SVSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // スクロールビューの生成
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_scrollView];
    
    // スクロール対象のイメージビューを生成
    UIImage *image = [UIImage imageNamed:@"big_image.jpg"];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
    _imageView.image = image;
    [_scrollView addSubview:_imageView];
    
    // スクロールコンテントのサイズを設定
    _scrollView.contentSize = _imageView.frame.size;
    
    // 画面下端のスクロールが中途半端なところで止まっていたので、インセットを調整
    _scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 88.0, 0.0);
    _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, 88.0, 0.0);
    
    
    // 最小倍率と最大倍率を設定
    _scrollView.minimumZoomScale = 0.5;
    _scrollView.maximumZoomScale = 3.0;
    
    _scrollView.delegate = self;
    
    
    // ステータスバータップで一番上にスクロールする
    _scrollView.scrollsToTop = YES;
}

// viewDidLoadの最終行で setContentOffset を呼び出すと、アニメーションされずに位置が設定されたので、viewDidAppear内で setContentOffset を呼び出しました。
- (void)viewDidAppear:(BOOL)animated
{
    // 自動的に右下へ移動
    // CGPoint pos = {_imageView.frame.size.width - _scrollView.frame.size.width, _imageView.frame.size.height - _scrollView.frame.size.height}; とするとY軸方向が最後までスクロールされません...？
    CGPoint pos = {_imageView.frame.size.width - self.view.frame.size.width, _imageView.frame.size.height - self.view.frame.size.height};
    [_scrollView setContentOffset:pos animated:YES];
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
