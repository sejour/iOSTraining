//
//  MixiAssetsViewController.m
//  MixiAssetsLibrarySample
//
//  Created by 田村 航弥 on 2013/04/30.
//  Copyright (c) 2013年 mixi. All rights reserved.
//

#import "MixiAssetsViewController.h"

@interface MixiAssetsViewController ()

@property (strong, nonatomic) ALAssetsGroup *assetsGroup;
@property (strong, nonatomic) NSMutableArray *assets;
@property (strong, nonatomic) NSMutableArray *selectedIndices;
@property (strong, nonatomic) NSMutableArray *selectedAssets;

@property (weak, nonatomic) IBOutlet UITableView *assetsTableView;

@end

@implementation MixiAssetsViewController

- (id)initWithAssetsGroup:(ALAssetsGroup *)assetsGroup
{
    self = [super initWithNibName:@"MixiAssetsViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _assetsGroup = assetsGroup;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pressDoneButton)];

    _assets = [NSMutableArray array];
    _selectedIndices = [NSMutableArray array];
    [_assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        NSLog(@"asset %@", result);
        if(result) [_assets addObject:result];
        else [_assetsTableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_assets count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }

    ALAsset *asset = _assets[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [asset valueForProperty:ALAssetPropertyDate]];
    [cell.imageView setImage:[UIImage imageWithCGImage:[asset thumbnail]]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // TODO : accessoryType が UITableViewCellAccessoryNone だったら UITableViewCellAccessoryCheckmark を、逆なら None を設定する
    //TODO : 選択された場合 index を _selectedIndices に add する、選択解除された場合 _selectedIndices から index を削除する
    switch (cell.accessoryType) {
        // 選択時
        case UITableViewCellAccessoryNone:
            // チェックマークを表示
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            // 追加
            [_selectedIndices addObject:@(indexPath.row)];
            break;
        // 選択解除時
        case UITableViewCellAccessoryCheckmark:
            // チェックマークを消す
            cell.accessoryType = UITableViewCellAccessoryNone;
            // 削除
            [_selectedIndices removeObject:@(indexPath.row)];
            break;
        default:
            return;
    }
    
    //TODO : このままだと _selectedIndices は順番が cell がおかしいので、_selectedIndices をソートする必要がある。ここでソートする。
    _selectedIndices = [NSMutableArray arrayWithArray:[_selectedIndices sortedArrayUsingComparator:^(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }]];
}

#pragma mark - private methods
-(void)pressDoneButton
{
    //TODO : _selectedAssets初期化
    _selectedAssets = [NSMutableArray arrayWithCapacity:4];
    
    //TODO : _selectedIndices に入ってる index の　asset を _assets から取得して、_selectedAssets に add する。
    for (NSNumber *index in _selectedIndices) {
        [_selectedAssets addObject:_assets[[index integerValue]]];
    }
    
    //TODO : delegate methods コールして assets 渡す
    [_delegate assetsViewControllerDidSelectedPhotos:_selectedAssets];
}

@end