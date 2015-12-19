//
//  AlbumGroupViewController.m
//  Common
//
//  Created by yangjie on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//


#import "AlbumGroupViewController.h"
#import "Common.h"
#import "OnePhotoAlbumViewController.h"

@interface AlbumGroupViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation AlbumGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton* cancelBtn = [[UIButton alloc] initWithFrame:CCR(0, 0, 16*2, 35)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:APP_FONT(16)];
    [cancelBtn setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:cancelBtn]];

    
    
    self.assetGroups = [NSMutableArray arrayWithCapacity:10];
    
    self.albumGroupTable = [[UITableView alloc] initWithFrame:CCR(0, 0, IPHONE_WIDTH, FRAMEH(self.view)) style:UITableViewStylePlain];
    self.albumGroupTable.delegate = self;
    self.albumGroupTable.dataSource = self;
    [self.albumGroupTable setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:self.albumGroupTable];
    
    
    self.assetLibrary = [[ALAssetsLibrary alloc] init];
    
    __weak typeof(self) weakSelf = self;
    
    // Load Albums into assetGroups
    dispatch_async(dispatch_get_main_queue(), ^{

       // Group enumerator Block
       void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
       {
           if (group == nil) {
               return;
           }
           
           // added fix for camera albums order
           NSString *sGroupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
           NSUInteger nType = [[group valueForProperty:ALAssetsGroupPropertyType] intValue];
           
           if ([[sGroupPropertyName lowercaseString] isEqualToString:@"camera roll"] && nType == ALAssetsGroupSavedPhotos) {
               [weakSelf.assetGroups insertObject:group atIndex:0];
           }
           else {
               [weakSelf.assetGroups addObject:group];
           }
           
           // Reload albums
           [self performSelectorOnMainThread:@selector(reloadTableData) withObject:nil waitUntilDone:YES];
       };
       
       // Group Enumerator Failure Block
       void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error) {
           
           UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Album Error: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
           [alert show];
           
           
           NSLog(@"A problem occured %@", [error description]);	                                 
       };	
       
       // Enumerate Albums
       [weakSelf.assetLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos|ALAssetsGroupLibrary|ALAssetsGroupAlbum
                                   usingBlock:assetGroupEnumerator 
                                 failureBlock:assetGroupEnumberatorFailure];
       

   });
    
}

- (void)reloadTableData{
    [self.albumGroupTable reloadData];
}

- (void)cancelBtnPressed:(UIButton*)btn{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.assetGroups count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"photoAlbumGroupCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UIImageView* postImgView = [[UIImageView alloc] initWithFrame:CCR(15, 5, 55, 55)];
        postImgView.tag = 2000;
        [cell.contentView addSubview:postImgView];
        
        UILabel* albumNameLabel = [[UILabel alloc] initWithFrame:CCR(0, 20, 250, 25)];
        [albumNameLabel setTextColor:[UIColor blackColor]];
        [albumNameLabel setFont:APP_FONT(16)];
        albumNameLabel.tag = 2001;
        [cell.contentView addSubview:albumNameLabel];
        
    }
    
    UIImageView* postImgView = (UIImageView*)[cell.contentView viewWithTag:2000];
    UILabel* albumNameLabel = (UILabel*)[cell.contentView viewWithTag:2001];
    
    // Get count
    ALAssetsGroup *g = (ALAssetsGroup*)[self.assetGroups objectAtIndex:indexPath.row];
    [g setAssetsFilter:[ALAssetsFilter allPhotos]];
    NSInteger gCount = [g numberOfAssets];
    
    UIImage* postImg = [UIImage imageWithCGImage:[(ALAssetsGroup*)[self.assetGroups objectAtIndex:indexPath.row] posterImage]];
    NSString* titleName = [NSString stringWithFormat:@"%@ (%ld)",[g valueForProperty:ALAssetsGroupPropertyName], (long)gCount];
    CGRect labelRect = albumNameLabel.frame;
    if (postImg != nil) {
        labelRect.origin.x = XRIGHT(postImgView) + 15;
        [postImgView setHidden:NO];
    }else{
        [postImgView setHidden:YES];
        labelRect.origin.x = 15;
    }
    [albumNameLabel setFrame:labelRect];
    [albumNameLabel setText:titleName];
    [postImgView setImage:postImg];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    //UIImageView* albumIconView = (UIImageView*)[cell viewWithTag:100];
    //albumIconView
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ALAssetsGroup *assetGroup = [self.assetGroups objectAtIndex:indexPath.row];
    OnePhotoAlbumViewController* photoVC = [[OnePhotoAlbumViewController alloc] init];
    photoVC.assetGroup = assetGroup;
    photoVC.albumGroupVC = self;
    photoVC.maxSelectCount = self.maxSelectCount;
    [self.navigationController pushViewController:photoVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65;
}

@end
