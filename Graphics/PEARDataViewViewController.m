//
//  PEARDataViewViewController.m
//  Graphics
//
//  Created by hirokiumatani on 2015/11/23.
//  Copyright © 2015年 hirokiumatani. All rights reserved.
//

#import "PEARDataViewViewController.h"
#import "PEARCanvas.h"
@interface PEARDataViewViewController ()
@property (weak   ,nonatomic) IBOutlet UITableView *tableView;
@property (strong ,nonatomic) NSMutableArray *cellLists;
@end

@implementation PEARDataViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initCellLists];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _cellLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView
                        loadCellAtIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PEARCanvas *canvas = [PEARCanvas new];
    UIImage *image = [canvas fetchSaveDataAtIndex:indexPath.row];
    [_delegate didSelectLoadImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 169;
    
}

#pragma private
- (UITableViewCell *)tableView:(UITableView *)tableView loadCellAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    
    cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clearBackGround"]];

    UIImage * image = _cellLists[indexPath.row];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(130, 18, 280, 144)];
    

    imageView.image = image;
    [cell.contentView addSubview:imageView];
    
    
    return cell;
}
- (void)initCellLists
{
    PEARCanvas *canvas = [PEARCanvas new];
    _cellLists = @[].mutableCopy;
    _cellLists = [canvas fetchSaveData].mutableCopy;
}
@end
