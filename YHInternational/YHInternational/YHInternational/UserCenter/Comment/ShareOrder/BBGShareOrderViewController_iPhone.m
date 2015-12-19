//
//  BBGShareOrderViewController_iPhone.m
//  YHInternational
//
//  Created by bbgds on 15/10/21.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import "BBGShareOrderViewController_iPhone.h"
#import "BBGShareOrderEditCell_iPhone.h"
#import "BBGNavigationController.h"
#import "TOCropViewController.h"
#import "BBGPhotoBrowserEditViewController.h"
#import "BBGCommentDetailImageView_iPhone.h"
#import "BBGShareOrder.h"
#import "BBGTopicExplainView.h"
#import "BBGShareOrderTopicLayout.h"

@interface BBGShareOrderViewController_iPhone ()<UITableViewDataSource,UITableViewDelegate,BBGCommentDetailImageViewDelegate,ImageCollectionViewCellDelegate,AlbumPhotoSelectedDelage,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TOCropViewControllerDelegate,BBGShareOrderEditCellDelegate>

@property (nonatomic,strong) UITableView *shareOrderTableView;
@property (nonatomic,strong) UIImageView *addEvaluateView;
@property (nonatomic,strong) UIButton *addEvaluateBtn;

@property (nonatomic,strong) NSMutableArray *willUploadImgArray;
@property (nonatomic,strong) NSMutableArray *picDataArray;

@property (nonatomic,strong) AlbumGroupViewController* albums;

@property (nonatomic,strong) NSMutableArray *shareOrderArray;

//选中的选项
@property (nonatomic,strong) NSIndexPath *selectIndexPath;


@end

@implementation BBGShareOrderViewController_iPhone

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}

-(void)initData
{
//    _picDataArray = [[NSMutableArray alloc] init];
    self.willUploadImgArray = [[NSMutableArray alloc] init];
    
    _shareOrderArray = [NSMutableArray array];
    BBGShareOrder *order;
    for(int i=0;i<10;i++)
    {
        order = [[BBGShareOrder alloc] init];
        order.goodsName = _goodsName;
        order.goodsImageUrl = _goodsImageUrl;
        order.goodsPrice = _goodsPrice;
        [_shareOrderArray addObject:order];
        order.topicArray = @[@"真漂亮",@"美美的",@"萌萌哒萌萌哒萌萌哒萌萌",@"卡哇伊",@"色彩缤纷",@"人生"];
        
        for (NSString *temp in order.topicArray)
        {
            [order.topicIsSelectArray addObject:@"0"];
        }
        [order mathOpenTopicHeight:IPHONE_WIDTH];
        
        NSLog(@"%f",order.openTopicHeight);
    }
    [_shareOrderTableView reloadData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.title = @"评价晒单";
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"评论晒单" ;
    
    [self initData];
    
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    
    self.imgArray = [[NSMutableArray alloc] init];
//    [self initData];

    
    [self createRightBarButtonItemWithTarget:self action:@selector(addEvaluateAction) title:@"提交" titleColor:UICOLOR_FONT_IMPORTANT_RED];
    
    CGRect tableViewFrame = self.view.bounds;
    tableViewFrame.size.height -= 60;
    _shareOrderTableView = [[BBGPullTable alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    _shareOrderTableView.delegate = self;
    _shareOrderTableView.dataSource = self;
    _shareOrderTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
//    _shareOrderTableView.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
    _shareOrderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _shareOrderTableView.sectionHeaderHeight = 10;
//    BBGAllCommentSectionHeaderView_iPhone *headerView = [[[NSBundle mainBundle] loadNibNamed:@"BBGAllCommentSectionHeaderView_iPhone" owner:nil options:nil] firstObject];
//    headerView.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
    
//    headerView.goodsDescLabel.text = _goodsName;
//    [headerView.goodsImageView sd_setImageWithURL:[NSURL URLWithString:_goodsImageUrl]];
//    headerView.goodsPriceLabel.text = _goodsPrice;
//    [headerView.goodsPriceLabel setTextColor:UICOLOR_FONT_GENERAL_GRAY];
//    _shareOrderTableView.tableHeaderView = headerView;
    UIView *heardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 10)];
    heardView.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;
    _shareOrderTableView.tableHeaderView = heardView;
    [self.view addSubview:_shareOrderTableView];
    
    _shareOrderTableView.hidden = YES;
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    [self JudgeUserIsBuyGoods:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        if (self.hasOrder) {
            //            self.title = @"评价晒单";
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
            label.text = @"晒单" ;
            label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
            label.textColor = [UIColor blackColor] ;
            label.textAlignment = NSTextAlignmentCenter ;
            self.navigationItem.titleView = label ;
//            headerView.goodsPriceLabel.text = [NSString stringWithFormat:@"购买时间: %@",self.orderTime];
            [_shareOrderTableView reloadData];
        }else{
            //            self.title = @"评论";
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
            label.text = @"评论" ;
            label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
            label.textColor = [UIColor blackColor] ;
            label.textAlignment = NSTextAlignmentCenter ;
            self.navigationItem.titleView = label ;
//            headerView.goodsPriceLabel.text = @" 你还没有购买此商品.";
        }
        
        _shareOrderTableView.hidden = NO;
        
    }];
    
    // 提交评论
    _addEvaluateView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addAddressBckg"]];
    [_addEvaluateView setUserInteractionEnabled:YES];
    _addEvaluateView.frame = CGRectMake(0, self.view.frame.size.height-124, self.view.frame.size.width, 60);
    
    _addEvaluateBtn = [UIButton buttonWithTitle:@"添加新地址" color:UICOLOR_FONT_IMPORTANT_RED rect:CGRectMake(40, (60-45)/2, IPHONE_WIDTH -80, 43)];
    [_addEvaluateBtn setTitle:@"提交" forState:UIControlStateNormal];
    _addEvaluateBtn.tintColor = [UIColor whiteColor];
    _addEvaluateBtn.titleLabel.font = APP_FONT(14.0);
    [_addEvaluateBtn addTarget:self action:@selector(addEvaluateAction) forControlEvents:UIControlEventTouchUpInside];
    [_addEvaluateView addSubview:_addEvaluateBtn];
    [self.view addSubview:_addEvaluateView];
    
    _shareOrderTableView.tableFooterView = [[UIView alloc] init];
    
    
    // Do any additional setup after loading the view.
}

//- (void)initData
//{
//    _picDataArray = [[NSMutableArray alloc] init];
//    self.willUploadImgArray = [[NSMutableArray alloc] init];
//}

- (void)addEvaluateAction{
    [self.view endEditing:YES];
    NSString *text = [self.comment stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (text.length > 0) {
        [[BBGLoadingTips sharedInstance] showLoading:@"正在发送..."];
        [self.imgArray removeAllObjects];
        for (int i=0; i<[self.picDataArray COUNT]; i++) {
            BBGImgModel *imgModel = [self.picDataArray ARRAY_OBJ_AT(i)];
            [self.imgArray addObject:imgModel.imgId];
        }
        __weak BBGShareOrderViewController_iPhone *weakself = self;
        [self updateData:^(BOOL sucessful, BBGResponse *response){
            [[BBGLoadingTips sharedInstance] hideTips];
            if (sucessful) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Text" object:text];
                [weakself dismissViewController];
            }
        }];
    }else{
        [[BBGLoadingTips sharedInstance] showTips:@"评论内容不能为空"];
    }
}


#pragma mark - BBGTableViewDataSource And BBGTableViewDelegate Methods

- (NSInteger)tableView:(BBGTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shareOrderArray.count;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return _shareOrderArray.count;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *heardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 10)];
//    heardView.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;
//    return heardView;
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 10;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBGShareOrder *shareOrder = [_shareOrderArray ARRAY_OBJ_AT(indexPath.row)];
    //默认高度
    float viewHeight = 222;
    viewHeight = viewHeight + [self imageCollectionViewHeight:[shareOrder.picDataArray COUNT]] + (shareOrder.isOpenTopic ? shareOrder.openTopicHeight :  shareOrder.defaultTopicHeight);
//    viewHeight = [(NSNumber *)[_arrayHeight objectAtIndex:indexPath.row] intValue] + viewHeight;
    return viewHeight;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifierShareOrderCell = @"BBGShareOrderEditCell_iPhone";
    
    BBGShareOrderEditCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifierShareOrderCell];
    BBGShareOrder *shareOrder = [_shareOrderArray ARRAY_OBJ_AT(indexPath.row)];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifierShareOrderCell owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        BBGCommentDetailImageView_iPhone *view = [[BBGCommentDetailImageView_iPhone alloc] initWithFrame:CGRectMake(10, 0, IPHONE_WIDTH - 20, 40)];
        view.tag = 2000;
        
        view.bigImageDelegate = self;
        [cell.contentView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.height.equalTo(@([self imageCollectionViewHeight:[shareOrder.picDataArray COUNT]]));
            make.width.equalTo(@(IPHONE_WIDTH - 20));
            make.top.equalTo(cell.viewText.mas_bottom);
        }];
    }
//    cell.tableIndexPath = indexPath;
//    cell.shareOrderArray = _shareOrderArray;
//    shareOrder.openTopicHeight = [(BBGShareOrderTopicLayout *)cell.collectionView collectionOpenTopicHeight];
    [cell setTopicData:_shareOrderArray indexPaht:indexPath];
    cell.tag = indexPath.row;
    cell.delegate = self;
    if(shareOrder.isOpenTopic)
    {
        cell.topicHeight.constant = shareOrder.openTopicHeight > 82 ? 82 : shareOrder.openTopicHeight;
    }else
    {
        cell.topicHeight.constant = shareOrder.defaultTopicHeight;
    }
    
    cell.goodsDescLabel.text = shareOrder.goodsName;
    [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:shareOrder.goodsImageUrl]];
    cell.goodsPriceLabel.text = shareOrder.goodsPrice;
    [cell.goodsPriceLabel setTextColor:UICOLOR_FONT_GENERAL_GRAY];
    cell.textView.text = shareOrder.comment;
    
    BBGCommentDetailImageView_iPhone *view = (BBGCommentDetailImageView_iPhone*)[cell viewWithTag:2000];
    view.indexPathInList = indexPath;
    view.delegate = self;
    CGRect rect = view.frame;
    rect = CGRectMake(view.frame.origin.x, 246, view.frame.size.width, view.frame.size.height);
    rect.size.height = [self imageCollectionViewHeight:[shareOrder.picDataArray COUNT]];
    [view setFrame:rect];
    view.picDataArray = shareOrder.picDataArray;
    [view reloadView];
    
    return cell;
}

-(int)imageCollectionViewHeight:(int)imageCount
{
    int row = 0;
    if (imageCount == MAX_PHOTO_COUNT) {
        row = ceilf(imageCount/(MAX_PHOTO_COUNT*1.0));
    }else{
        row = ceilf((imageCount+1)/(MAX_PHOTO_COUNT*1.0));
    }
    float viewHeight = row * (IPHONE_WIDTH/(MAX_PHOTO_COUNT*1.0));
    return viewHeight;
}

#pragma mark - BBGTableViewDataSource And BBGTableViewDelegate Methods
- (void)changeTable:(NSInteger)type str:(NSString *)str isAnonymous:(BOOL)isAnonymous
{
    ((BBGShareOrder*)[self getShareOrder:type]).comment = str;
    self.comment = str;
    self.isAnonymous = isAnonymous;
}

#pragma mark AlbumPhotoSelectedDelage
- (void)selectPhotos:(NSArray*)photoInfoArray{
    [self.willUploadImgArray removeAllObjects];
    
    
    for (int i=0; i<[photoInfoArray COUNT]; i++) {
        NSDictionary *photoInfo = [photoInfoArray ARRAY_OBJ_AT(i)];
        ALAssetRepresentation *assetRep = [photoInfo DICT_OBJ_FOR_K(@"assetRep")];
        UIImage *img = [UIImage imageWithCGImage:[assetRep fullScreenImage]];
        
        [self.willUploadImgArray addObject:img];
    }
    
    [self uploadAllPhoto];
    
    //多图编辑测试
    //    BBGPhotoBrowserEditViewController *con = [[BBGPhotoBrowserEditViewController alloc] init];
    //    con.imgArray = self.willUploadImgArray;
    //    [self.navigationController pushViewController:con animated:YES];
}


#pragma mark BBGCommentDetailImageViewDelegate
//- (void)commentImgCollectionViewAddPhoto:(BBGImgModel*)model{
//    [self.view endEditing:YES];
//    if (MAX_PHOTO_COUNT <= [self.picDataArray COUNT]) {
//        [[BBGLoadingTips sharedInstance] showTips:[NSString stringWithFormat:@"最多只能选择%d张",MAX_PHOTO_COUNT]];
//    }else{
//        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
//        [sheet showInView:[UIApplication sharedApplication].keyWindow];
//    }
//}

-(void)commentImgCollectionViewAddPhoto:(BBGImgModel *)model indexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"sdfsdfsd");
//    _animIndex = (int)indexPath.row;
//    [_arrayHeight addObject:indexPath];
//    [_arrayHeight setObject:indexPath atIndexedSubscript:indexPath.row];
//    [_arrayHeight setObject:[[NSNumber alloc] initWithInt:80] atIndexedSubscript:indexPath.row] ;
//    [_arrayHeight insertObject:[[NSNumber alloc] initWithInt:80] atIndex:indexPath.row] ;
//    NSIndexPath *te=[NSIndexPath indexPathForRow:_animIndex inSection:0];
//    [_shareOrderTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:te,nil]  withRowAnimation:UITableViewRowAnimationAutomatic];
    _selectIndexPath = indexPath;
    [self.view endEditing:YES];
    if (MAX_PHOTO_COUNT <= [[_shareOrderArray ARRAY_OBJ_AT(indexPath.row)] COUNT]) {
        [[BBGLoadingTips sharedInstance] showTips:[NSString stringWithFormat:@"最多只能选择%d张",MAX_PHOTO_COUNT]];
    }else{
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
        [sheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}

- (void)commentImgCollectionViewDelPhoto:(BBGImgModel *)model indexPath:(NSIndexPath *)indexPath
{
//    [self.picDataArray ARRAY_REMOVE_OBJ(model)];
    [[self getShareOrderImageArrayByIndexPath:indexPath] ARRAY_REMOVE_OBJ(model)];
//    [[(BBGShareOrder *)[_shareOrderArray ARRAY_OBJ_AT(_selectIndexPath.row)] picDataArray] ARRAY_REMOVE_OBJ(model)];
//    [[self getShareOrderImageArray:indexPath] ARRAY_REMOVEOBJ_AT(model.indexPathInCollection.row)];
    [self.shareOrderTableView reloadData];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.navigationController presentViewController:picker animated:YES completion:nil];
        }else{
            [BBGAlertView showWithTitle:@"" message:@"抱歉！您的设备没有摄像头" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
                
            } buttonTitles: nil];
            return;
        }
    }else if (buttonIndex == 1){
        if (self.albums == nil) {
            self.albums = [[AlbumGroupViewController alloc] init];
            self.albums.selectedDelegate = self;
        }
        
        self.albums.maxSelectCount = MAX_PHOTO_COUNT - [self.picDataArray COUNT];
        BBGNavigationController* navi = [[BBGNavigationController alloc] initWithRootViewController:self.albums];
        
        [self presentViewController:navi animated:YES completion:^{
            
        }];
    }
}

#pragma mark  UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //去除裁剪
    //    [self dismissViewControllerAnimated:YES completion:^{
    //        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    //        TOCropViewController *cropController = [[TOCropViewController alloc] initWithImage:originImage];
    //        cropController.delegate = self;
    //        [self presentViewController:cropController animated:YES completion:nil];
    //    }];
    
    WS(ws)
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        [ws.willUploadImgArray removeAllObjects];
        [ws.willUploadImgArray addObject:originImage];
        [ws uploadAllPhoto];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated: YES completion:^{
        
    }];
}

#pragma mark - Cropper Delegate -
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle{
    
    WS(ws)
    [cropViewController dismissViewControllerAnimated:YES completion:^{
        [ws.willUploadImgArray removeAllObjects];
        [ws.willUploadImgArray addObject:image];
        [ws uploadAllPhoto];
    }];
    
    
    
    
}

-(NSMutableArray *)getShareOrderImageArrayByIndexPath:(NSIndexPath*)indexPath
{
    return [(BBGShareOrder *)[_shareOrderArray ARRAY_OBJ_AT(indexPath.row)] picDataArray];
}

-(BBGShareOrder *)getShareOrder:(int)index
{
    return [_shareOrderArray ARRAY_OBJ_AT(index)];
}

- (void)uploadAllPhoto{
    __block int uploadCount = 0;
    __weak BBGShareOrderViewController_iPhone *weakSelf = self;
    if ([self.willUploadImgArray count] > 0) {
        [[BBGLoadingTips sharedInstance] showLoading:@"正在上传..."];
        [self uploadAllImg:self.willUploadImgArray callBack:^(BOOL sucessful, BBGResponse *response) {
            if (sucessful) {
                BBGUploadImgResponse *uploadImgResponse = (BBGUploadImgResponse*)response;
                [[weakSelf getShareOrderImageArrayByIndexPath:_selectIndexPath] addObject:uploadImgResponse.imgModel];
//                [weakSelf.picDataArray addObject:uploadImgResponse.imgModel];
                [weakSelf.shareOrderTableView reloadData];
            }else{
                [[BBGLoadingTips sharedInstance] showTips:@"上传图片失败"];
            }
            uploadCount ++;
            if (uploadCount >= [self.willUploadImgArray COUNT]) {
                [[BBGLoadingTips sharedInstance] showTips:@"上传图片完成"];
                [self.willUploadImgArray removeAllObjects];
            }
        }];
    }
    
}

- (void)uploadOnePhoto{
    if ([self.willUploadImgArray COUNT] >0) {
        UIImage* img = [self.willUploadImgArray firstObject];
        [self performSelectorInBackground:@selector(processImgHandler:) withObject:img];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"图片上传完毕！"];
    }
}

- (void)processImgHandler:(UIImage*)img{
    __weak BBGShareOrderViewController_iPhone *weakSelf = self;
    [SVProgressHUD showWithStatus:@"上传图片中"];
    [self uploadImg:img callBack:^(BOOL sucessful, BBGResponse *response) {
        [weakSelf.willUploadImgArray removeObject:img];
        [weakSelf uploadOnePhoto];
    }];
}

#pragma mark - ImageCollectionViewCellDelegate
- (void)didClickedImageViewCell:(NSIndexPath *)indexPath imageArray:(NSMutableArray *)imageArray{
    BBGPhotoBrowserViewController *con = [[BBGPhotoBrowserViewController alloc] init];
    con.imgArray = imageArray;
    con.currentImgIndex = (int)indexPath.row;
    [self.navigationController presentViewController:con animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
