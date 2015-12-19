//
//  BBGEvaluateViewController_iPhone.m
//  YHInternational
//
//  Created by Holyjoy on 15/5/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGEvaluateViewController_iPhone.h"
#import "BBGAllCommentSectionHeaderView_iPhone.h"
#import "BBGCommentDetailTextCell_iPhone.h"
#import "BBGCommentDetailImageCell_iPhone.h"
#import "BBGCommentDetailImageView_iPhone.h"
#import "BBGNavigationController.h"
#import "TOCropViewController.h"
#import "BBGPhotoBrowserEditViewController.h"

@interface BBGEvaluateViewController_iPhone ()<UITableViewDataSource,UITableViewDelegate,BBGCommentDetailTextCellDelegate,BBGCommentDetailImageViewDelegate,AlbumPhotoSelectedDelage,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TOCropViewControllerDelegate,ImageCollectionViewCellDelegate,BBGPhotoBrowserEditDelegate>

@property (nonatomic,strong) UITableView *evaluateTableView;
@property (nonatomic,strong) UIImageView *addEvaluateView;
@property (nonatomic,strong) UIButton *addEvaluateBtn;

@property (nonatomic,strong) NSMutableArray *willUploadImgArray;
@property (nonatomic,strong) NSMutableArray *picDataArray;

@property (nonatomic,strong) AlbumGroupViewController* albums;
@end

@implementation BBGEvaluateViewController_iPhone

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"评价晒单";
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"评论晒单" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    
    self.imgArray = [[NSMutableArray alloc] init];
    [self initData];
    
    [self createRightBarButtonItemWithTarget:self action:@selector(addEvaluateAction) title:@"提交" titleColor:UICOLOR_FONT_IMPORTANT_RED];

    CGRect tableViewFrame = self.view.bounds;
    tableViewFrame.size.height -= 60;
    _evaluateTableView = [[BBGPullTable alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    _evaluateTableView.delegate = self;
    _evaluateTableView.dataSource = self;
    _evaluateTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    _evaluateTableView.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
    _evaluateTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    BBGAllCommentSectionHeaderView_iPhone *headerView = [[[NSBundle mainBundle] loadNibNamed:@"BBGAllCommentSectionHeaderView_iPhone" owner:nil options:nil] firstObject];
    headerView.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
    
    headerView.goodsDescLabel.text = _goodsName;
    [headerView.goodsImageView sd_setImageWithURL:[NSURL URLWithString:_goodsImageUrl]];
    headerView.goodsPriceLabel.text = _goodsPrice;
    [headerView.goodsPriceLabel setTextColor:UICOLOR_FONT_GENERAL_GRAY];
    _evaluateTableView.tableHeaderView = headerView;
    [self.view addSubview:_evaluateTableView];
    
    _evaluateTableView.hidden = YES;
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
            headerView.goodsPriceLabel.text = [NSString stringWithFormat:@"购买时间: %@",self.orderTime];
            [_evaluateTableView reloadData];
        }else{
//            self.title = @"评论";
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
            label.text = @"评论" ;
            label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
            label.textColor = [UIColor blackColor] ;
            label.textAlignment = NSTextAlignmentCenter ;
            self.navigationItem.titleView = label ;
            headerView.goodsPriceLabel.text = @" 你还没有购买此商品.";
        }
        
        _evaluateTableView.hidden = NO;

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
    
    _evaluateTableView.tableFooterView = [[UIView alloc] init];
    
    
    // Do any additional setup after loading the view.
}

- (void)initData{
    _picDataArray = [[NSMutableArray alloc] init];
    self.willUploadImgArray = [[NSMutableArray alloc] init];
}

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
        __weak BBGEvaluateViewController_iPhone *weakself = self;
        [self updateData:^(BOOL sucessful, BBGResponse *response){
            [[BBGLoadingTips sharedInstance] hideTips];
            if (sucessful) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Text" object:text];
                [weakself dismissViewController];
            }
        }];
    }else{
        [[BBGLoadingTips sharedInstance] showTips:@"请输入评论内容"];
    }
}


#pragma mark - BBGTableViewDataSource And BBGTableViewDelegate Methods

- (NSInteger)tableView:(BBGTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //是否显示上传图片
    if (self.hasOrder) {
        return 2;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if (indexPath.row == 0) {
        return 140.0;
    }else{
        int row = 0;
        if ([_picDataArray COUNT] == MAX_PHOTO_COUNT) {
            row = ceilf([_picDataArray COUNT]/(MAX_PHOTO_COUNT*1.0));
        }else{
            row = ceilf(([_picDataArray COUNT]+1)/(MAX_PHOTO_COUNT*1.0));
        }
        float viewHeight = row * (IPHONE_WIDTH/(MAX_PHOTO_COUNT*1.0));
        return viewHeight;
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        static NSString *identifier1 = @"BBGCommentDetailTextCell_iPhone";
        BBGCommentDetailTextCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:identifier1 owner:nil options:nil] firstObject];
        }
        cell.delegate = self;
        [cell displayTextContent:self.comment isAnonymous:NO];
        return cell;
    }else{
        static NSString *identifier2 = @"BBGCommentDetailImageCell_iPhone";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
            BBGCommentDetailImageView_iPhone *view = [[BBGCommentDetailImageView_iPhone alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 40)];
            view.tag = 2000;
            view.delegate = self;
            view.bigImageDelegate = self;
            [cell.contentView addSubview:view];
        }

        int row = 0;
        if ([_picDataArray COUNT] == MAX_PHOTO_COUNT) {
            row = ceilf([_picDataArray COUNT]/(MAX_PHOTO_COUNT*1.0));
        }else{
            row = ceilf(([_picDataArray COUNT]+1)/(MAX_PHOTO_COUNT*1.0));
        }
        float viewHeight = row * (IPHONE_WIDTH/(MAX_PHOTO_COUNT*1.0));
        
        BBGCommentDetailImageView_iPhone *view = (BBGCommentDetailImageView_iPhone*)[cell viewWithTag:2000];
        CGRect rect = view.frame;
        rect.size.height = viewHeight;
        [view setFrame:rect];
        
        view.picDataArray = _picDataArray;
        [view reloadView];
        return cell;
    }
    
}

#pragma mark - BBGTableViewDataSource And BBGTableViewDelegate Methods
- (void)changeTable:(NSInteger)type str:(NSString *)str isAnonymous:(BOOL)isAnonymous{
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
    
//    [self uploadAllPhoto];
    
    //多图编辑测试
    BBGPhotoBrowserEditViewController *con = [[BBGPhotoBrowserEditViewController alloc] init];
    con.imgArray = [NSMutableArray arrayWithArray:self.willUploadImgArray];
    con.delegate = self;
    [self.navigationController pushViewController:con animated:YES];
}

#pragma mark BBGPhotoBrowserEditDelegate
- (void)finishEdit:(BBGPhotoBrowserEditViewController*)con imageArray:(NSMutableArray*)imgArray{
    [self.willUploadImgArray removeAllObjects];
    [self.willUploadImgArray ARRAY_ADD_OBJS_FROM_ARRAY(imgArray)];
    [self uploadAllPhoto];
    
//    [con dismissViewControllerAnimated:YES completion:^{
//        
//    }];
}


#pragma mark BBGCommentDetailImageViewDelegate
- (void)commentImgCollectionViewAddPhoto:(BBGImgModel*)model{
    [self.view endEditing:YES];
    if (MAX_PHOTO_COUNT <= [self.picDataArray COUNT]) {
        [[BBGLoadingTips sharedInstance] showTips:[NSString stringWithFormat:@"最多只能选择%d张",MAX_PHOTO_COUNT]];
    }else{
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
        [sheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}

- (void)commentImgCollectionViewDelPhoto:(BBGImgModel *)model{
    [self.picDataArray ARRAY_REMOVE_OBJ(model)];
    [self.evaluateTableView reloadData];
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
            [BBGAlertView showWithTitle:@"" message:@"抱歉！该手机没有摄像头" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
                
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

- (void)uploadAllPhoto{
    __block int uploadCount = 0;
    __weak BBGEvaluateViewController_iPhone *weakSelf = self;
    if ([self.willUploadImgArray count] > 0) {
        [[BBGLoadingTips sharedInstance] showLoading:@"正在上传..."];
        [self uploadAllImg:self.willUploadImgArray callBack:^(BOOL sucessful, BBGResponse *response) {
            if (sucessful) {
                BBGUploadImgResponse *uploadImgResponse = (BBGUploadImgResponse*)response;
                [weakSelf.picDataArray addObject:uploadImgResponse.imgModel];
                [weakSelf.evaluateTableView reloadData];
            }else{
                [[BBGLoadingTips sharedInstance] showTips:@"上传失败，请重试"];
            }
            uploadCount ++;
            if (uploadCount >= [self.willUploadImgArray COUNT]) {
                [[BBGLoadingTips sharedInstance] showTips:@"上传完成"];
                [weakSelf.willUploadImgArray removeAllObjects];
            }
        }];
    }
    
}

- (void)uploadOnePhoto{
    if ([self.willUploadImgArray COUNT] > 0) {
        UIImage* img = [self.willUploadImgArray firstObject];
        [self performSelectorInBackground:@selector(processImgHandler:) withObject:img];
    }else{
        [[BBGLoadingTips sharedInstance] showTips:@"图片上传完毕！"];
    }
}

- (void)processImgHandler:(UIImage*)img{
    __weak BBGEvaluateViewController_iPhone *weakSelf = self;
    [[BBGLoadingTips sharedInstance] showLoading:@""];
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
