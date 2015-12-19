//
//  BBGEditAddressCardIDViewController_iPhone.m
//  YHInternational
//
//  Created by yangjie on 15/5/5.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGEditAddressCardIDViewController_iPhone.h"
#import "BBGEditAddressContentCell_iPhone.h"
#import "BBGSelectAddressViewController_iPhone.h"
#import "BBGEditIDPhotoTableViewCell.h"
#import "TOCropViewController.h"
#import "BBGGSAddressSelectViewController_iPhone.h"

@class BBGSelectAddressViewController_iPhone;
@interface BBGEditAddressCardIDViewController_iPhone ()<UITableViewDataSource,UITableViewDelegate,BBGEditAddressContentCellDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TOCropViewControllerDelegate>

/**
 *  是否存在身份证号码
 */
@property (nonatomic,assign) BOOL isHasIDCard;

@end

@implementation BBGEditAddressCardIDViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"身份证编辑" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    
    [self createView];
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    __weak BBGEditAddressCardIDViewController_iPhone *weakSelf = self;
    [self getAddrByName:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        if (sucessful) {
            BBGGetAddrByNameResponse *tempResponse = (BBGGetAddrByNameResponse*)response;
            weakSelf.editedAddress.idCard = tempResponse.IDCard;
            weakSelf.editedAddress.frontImgUrl = tempResponse.IDCardPhotoFrontUrl;
            weakSelf.editedAddress.reverseImgUrl = tempResponse.IDCardPhotoBackUrl;
            weakSelf.editedAddress.reverseImgUrlHD = tempResponse.IDCardPhotoBackUrlHD;
            weakSelf.editedAddress.frontImgUrlHD = tempResponse.IDCardPhotoFrontUrlHD;
            weakSelf.editedAddress.frontImg = tempResponse.IDCardPhotoFrontImageId;
            weakSelf.editedAddress.reverseImg = tempResponse.IDCardPhotoBackImageId;
            
            if (![BBGTools checkStringIsBlank:weakSelf.editedAddress.idCard]) {
                weakSelf.isHasIDCard = YES;
            }
            [weakSelf.tableView reloadData];
            [weakSelf reloadTableHeaderFooterView];
        }
        
    }];
}

- (void)createView{
    [self createRightBarButtonItemWithTarget:self action:@selector(saveAddress:) title:@"保存" titleColor:UICOLOR_FONT_IMPORTANT_RED];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
    
    [self reloadTableHeaderFooterView];
}

- (void)reloadTableHeaderFooterView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 25)];
    
    //[footerView setBackgroundColor:[UIColor redColor]];
    
    UILabel *IDCardtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, IPHONE_WIDTH-20, 0)];
    [IDCardtitleLabel setNumberOfLines:0];
    [IDCardtitleLabel setFont:APP_FONT(12)];
    [IDCardtitleLabel setTextColor:[UIColor grayColor]];
    [IDCardtitleLabel sizeToFit];
    
    if (_isHasIDCard) {
        [IDCardtitleLabel setText:@"系统检查你已填写身份证号码，如果有误，请修改!"];
        [IDCardtitleLabel sizeToFit];
    }else{
        [headerView setFrame:CGRectMake(0, 0, IPHONE_WIDTH, 10)];
    }
    [headerView addSubview:IDCardtitleLabel];
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 60)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, IPHONE_WIDTH-30, 25)];
    [titleLabel setText:@"身份证信息用于商品入境申报，请填写收货人的真实身份证信息。"];
    //    if (_mustNeedIdCardPhoto) {
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(15, titleLabel.frame.origin.y+titleLabel.frame.size.height, IPHONE_WIDTH-30, 25)];
    UIImageView *dotSecondImg = [[UIImageView alloc]init];
    dotSecondImg.image = [UIImage imageNamed:@"IDCard_dot"];
    dotSecondImg.frame = CGRectMake(10, titleLabel.frame.origin.y+titleLabel.frame.size.height+4, 4, 4);
    [footerView addSubview:dotSecondImg];
    [titleLabel2 setText:@"若购买海外直邮类商品，还需要上传收货人的身份证照片。"];
    [titleLabel2 setNumberOfLines:0];
    [titleLabel2 setFont:APP_FONT(11)];
    [titleLabel2 setTextColor:UICOLOR_FONT_IMPORTANT_RED];
    [titleLabel2 sizeToFit];
    [footerView addSubview:titleLabel2];
    //        [titleLabel setText:@"身份证信息用于商品入境申报，请填写收货人的真实身份证信息;"];
    //    }
    UIImageView *dotFirstImg = [[UIImageView alloc]init];
    dotFirstImg.image = [UIImage imageNamed:@"IDCard_dot"];
    dotFirstImg.frame = CGRectMake(10, titleLabel.frame.origin.y+4, 4, 4);
    [footerView addSubview:dotFirstImg];
    
    [titleLabel setFont:APP_FONT(11)];
    [titleLabel setTextColor:UICOLOR_FONT_IMPORTANT_RED];
    [titleLabel setNumberOfLines:0];
    [titleLabel sizeToFit];
    [footerView addSubview:titleLabel];
    _tableView.tableHeaderView = headerView;
    _tableView.tableFooterView = footerView;
}

- (void)saveAddress:(id)sender{
    [self.view endEditing:YES];
    if (![self checkData]) {
        return;
    }
    
    //判断身份证正面或背面是否都传了或都没传
    BOOL bool1 = [BBGTools checkStringIsBlank:self.editedAddress.frontImgUrl] && ![BBGTools checkStringIsBlank:self.editedAddress.reverseImgUrl];
    BOOL bool2 = ![BBGTools checkStringIsBlank:self.editedAddress.frontImgUrl] && [BBGTools checkStringIsBlank:self.editedAddress.reverseImgUrl];
    
    if (bool1) {
        [[BBGLoadingTips sharedInstance] showTips:@"请上传身份证正面照片"];
    }
    if (bool2) {
        [[BBGLoadingTips sharedInstance] showTips:@"请上传身份证背面照片"];
    }
    
    if (!(bool1 || bool2)) {
        __weak BBGEditAddressCardIDViewController_iPhone *weakSelf = self;
        if (_isEdit) {
            [[BBGLoadingTips sharedInstance] showLoading:@""];
            [self updateData:^(BOOL sucessful, BBGResponse *response) {
                [[BBGLoadingTips sharedInstance] hideTips];
                if (sucessful) {
                    NSArray *vcS = weakSelf.navigationController.viewControllers;
                    BBGEditAddressResponse *res = (BBGEditAddressResponse *)response;
                    for (UIViewController *vc in vcS) {
                        //若从结算更改地址页过来，则跳会更改地址列表页
                        if ([vc isKindOfClass:[BBGSelectAddressViewController_iPhone class]]) {
                            BBGSelectAddressViewController_iPhone *selectAddressVC = (BBGSelectAddressViewController_iPhone *)vc;
                            [selectAddressVC selectAddressWithAddressId:res.address.addrId];
                            [weakSelf.navigationController popToViewController:selectAddressVC animated:YES];
                            return ;
                        }
                        
                        if ([vc isKindOfClass:[BBGGSAddressSelectViewController_iPhone class]]) {
                            [weakSelf.navigationController popToViewController:vc animated:YES];
                        }
                    }
                    
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }
            }];
        }else{
            self.addAddressReqeust.areaInfo = self.editedAddress.areaInfo;
            self.addAddressReqeust.addr = self.editedAddress.addr;
            self.addAddressReqeust.name = self.editedAddress.name;
            self.addAddressReqeust.mobile = self.editedAddress.mobile;
            self.addAddressReqeust.realName = self.editedAddress.realName;
            self.addAddressReqeust.idCard = self.editedAddress.idCard;
            self.addAddressReqeust.frontImg = self.editedAddress.frontImg;
            self.addAddressReqeust.reverseImg = self.editedAddress.reverseImg;
            
            [[BBGLoadingTips sharedInstance] showLoading:@""];
            [self addAddress:^(BOOL sucessful, BBGResponse *response) {
                [[BBGLoadingTips sharedInstance] hideTips];
                BBGAddAdressResponse *res = (BBGAddAdressResponse *)response;
                if (sucessful) {
                    NSArray *vcS = weakSelf.navigationController.viewControllers;
                    for (UIViewController *vc in vcS) {
                        //若从结算更改地址页过来，则跳会更改地址列表页
                        if ([vc isKindOfClass:[BBGSelectAddressViewController_iPhone class]]) {
                            BBGSelectAddressViewController_iPhone *selectAddressVC = (BBGSelectAddressViewController_iPhone *)vc;
                            [selectAddressVC selectAddressWithAddressId:res.address.addrId];
                            [weakSelf.navigationController popToViewController:selectAddressVC animated:YES];
                            return ;
                        }
                        
                        if ([vc isKindOfClass:[BBGGSAddressSelectViewController_iPhone class]]) {
                            [weakSelf.navigationController popToViewController:vc animated:YES];
                        }
                    }
                    
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }
            }];
        }
    }
}

- (BOOL)checkData{
    BOOL checkSuccess = YES;
    if ([BBGTools checkStringIsBlank:self.editedAddress.idCard]) {
        checkSuccess = NO;
        [[BBGLoadingTips sharedInstance] showTips:@"请输入身份证号码"];
        return checkSuccess;
    }
    
    return checkSuccess;
}


#pragma mark - UITableViewDataSource And UITableViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 10;
    if (_isHasIDCard) {
        sectionHeaderHeight = 30.0;
    }
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0){
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else if (scrollView.contentOffset.y >= sectionHeaderHeight){
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) {
        //       40 + 15+33+20+(IPHONE_WIDTH - 90)/2 * 9/14
        //        return 190;
        return 108+(IPHONE_WIDTH - 90)/2 * 9/14;
    }else{
        return 43;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    float headerHeight = 10;
//    return headerHeight;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    float fotterHeihgt = 40.0;
//    if (_isHasIDCard) {
//        fotterHeihgt += 30.0;
//    }
//    return fotterHeihgt;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 40)];
//    //[footerView setBackgroundColor:[UIColor redColor]];
//
//    UILabel *IDCardtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, IPHONE_WIDTH-20, 0)];
//    [IDCardtitleLabel setNumberOfLines:0];
//    [IDCardtitleLabel setFont:[UIFont systemFontOfSize:12]];
//    [IDCardtitleLabel setTextColor:[UIColor grayColor]];
//    [IDCardtitleLabel sizeToFit];
//
//    if (_isHasIDCard) {
//        [IDCardtitleLabel setText:@"系统检查你已填写身份证号码,如果有误，请修改"];
//        [IDCardtitleLabel sizeToFit];
//    }
//    [footerView addSubview:IDCardtitleLabel];
//
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, YBOTTOM(IDCardtitleLabel)+5, IPHONE_WIDTH-20, 20)];
//    [titleLabel setText:@"重要：身份证信息用于商品入境申报，请填写收货人的真实身份证信息。"];
//    [titleLabel setFont:[UIFont systemFontOfSize:12]];
//    [titleLabel setTextColor:[UIColor redColor]];
//    [titleLabel setNumberOfLines:0];
//    [titleLabel sizeToFit];
//
//    [footerView addSubview:titleLabel];
//    return footerView;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row != 2) {
        static NSString *cellIndex = @"BBGEditAddressCardIDTableViewCellIndex";
        BBGEditAddressContentCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:cellIndex];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGEditAddressContentCell_iPhone" owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        switch (indexPath.row) {
            case 0:
                cell.titleName.text = @"身份证姓名";
                cell.textField.text = self.editedAddress.realName;
                [cell.titleName setTextColor:UICOLOR_FONT_GENERAL_GRAYLIGHT];
                [cell.textField setTextColor:UICOLOR_FONT_GENERAL_GRAYLIGHT];
                cell.textField.enabled = NO;
                cell.separateLine.hidden = YES;
                cell.type = EDITIDCARDNAME;
                break;
            case 1:
                [cell.titleName setTextColor:UICOLOR_FONT_GENERAL_GRAYLIGHT];
                [cell.textField setTextColor:UICOLOR_FONT_IMPORTANT_BLACK];
                cell.titleName.text = @"身份证号码";
                cell.textField.text = self.editedAddress.idCard;
                cell.textField.enabled = YES;
                cell.separateLine.hidden = YES;
                cell.type = EDITIDCARD;
                cell.textField.placeholder = [NSString stringWithFormat:@"请输入%@的身份证号",self.editedAddress.realName];
                break;
            default:
                break;
        }
        return cell;
    }else{
        
        static NSString *cellIDPhoto = @"BBGEditIDPhotoTableViewCell";
        BBGEditIDPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDPhoto];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGEditIDPhotoTableViewCell" owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        //身份证照片是否必要
        if (_mustNeedIdCardPhoto) {
            cell.MustNeedIdCardPhoto.hidden = YES;
        }else{
            cell.MustNeedIdCardPhoto.hidden = NO;
        }
        
        //编辑正面事件
        __weak BBGEditAddressCardIDViewController_iPhone *weakself = self;
        
        cell.IDFrontblock = ^(){
            
            weakself.isChooseIDPhotoBack = NO;
            if (![BBGSession sharedInstance].isLogin) {
                [[BBGLoadingTips sharedInstance] showTips:@"请先登录"];
                return;
            }
            
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:weakself cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
            [sheet showInView:[UIApplication sharedApplication].keyWindow];
            
        };
        
        //编辑反面事件
        cell.IDBackblock = ^(){
            
            weakself.isChooseIDPhotoBack = YES;
            
            if (![BBGSession sharedInstance].isLogin) {
                [[BBGLoadingTips sharedInstance] showTips:@"请先登录"];
                return;
            }
            
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:weakself cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
            [sheet showInView:[UIApplication sharedApplication].keyWindow];
        };
        [cell.IDFrontImageView sd_setImageWithURL:[NSURL URLWithString:self.editedAddress.frontImgUrl] placeholderImage:[UIImage imageNamed:@"IDCard_positive"]];
        if (self.editedAddress.frontImgUrl.length) {
            [cell.frontButton setTitle:@"编辑正面" forState:UIControlStateNormal];
        }else{
            [cell.frontButton setTitle:@"上传正面" forState:UIControlStateNormal];
        }
        [cell.IDBackImageView sd_setImageWithURL:[NSURL URLWithString:self.editedAddress.reverseImgUrl] placeholderImage:[UIImage imageNamed:@"IDCard_opposite"]];
        if (self.editedAddress.reverseImgUrl.length) {
            [cell.backButton setTitle:@"编辑反面" forState:UIControlStateNormal];
        }else{
            [cell.backButton setTitle:@"上传反面" forState:UIControlStateNormal];
        }
        
        //点击查看正反面大图
        NSMutableArray *bigPicArray = [NSMutableArray array];
        if (self.editedAddress.frontImgUrlHD.length) {
            [bigPicArray addObject:[BBGPhotoModel photoWithURL:[NSURL URLWithString:self.editedAddress.frontImgUrlHD]]];
        }
        if (self.editedAddress.reverseImgUrlHD.length) {
            [bigPicArray addObject:[BBGPhotoModel photoWithURL:[NSURL URLWithString:self.editedAddress.reverseImgUrlHD]]];
        }
        cell.BtnIDFrontblock = ^(){
            if (weakself.editedAddress.frontImgUrlHD.length > 0) {
                BBGPhotoBrowserViewController *con = [[BBGPhotoBrowserViewController alloc] init];
                con.imgArray = bigPicArray;
                //            con.currentImgIndex = (int)indexPath.row;
                [weakself.navigationController presentViewController:con animated:YES completion:nil];
            }
        };
        cell.BtnIDBackblock = ^(){
            if (weakself.editedAddress.reverseImgUrlHD.length > 0) {
                BBGPhotoBrowserViewController *con = [[BBGPhotoBrowserViewController alloc] init];
                con.imgArray = bigPicArray;
                if (bigPicArray.count == 2) {
                    con.currentImgIndex = 1;
                }
                [weakself.navigationController presentViewController:con animated:YES completion:nil];
            }
        };
        
        return cell;
    }
    
}


#pragma mark BBGEditAddressContentCellDelegate
-(void)editAddressWithType:(BBGEditAddressType)typ value:(NSString *)value {
    if (typ == EDITIDCARDNAME) {
        self.editedAddress.realName = value;
    }else if (typ == EDITIDCARD){
        self.editedAddress.idCard = value;
    }
}

#pragma mark UIActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = NO;
            [self.navigationController presentViewController:picker animated:YES completion:nil];
        }else{
            [BBGAlertView showWithTitle:@"" message:@"抱歉！该手机没有摄像头" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
                
            } buttonTitles: nil];
            return;
        }
    }else if (buttonIndex == 1){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = NO;
        [self.navigationController presentViewController:picker animated:YES completion:nil];
    }
}


#pragma mark  UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    WS(ws)
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        TOCropViewController *cropController = [[TOCropViewController alloc] initWithImage:originImage];
        cropController.delegate = ws;
        [ws presentViewController:cropController animated:YES completion:^{
            [cropController.cropView setAspectLockEnabledWithAspectRatio:CGSizeMake(54.0f,86.0f) animated:YES];
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated: YES completion:^{
        
    }];
}

#pragma mark - Cropper Delegate -
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle{
    
    image = [image reSizeImage:CGSizeMake(600, 600)];
    WS(ws)
    [cropViewController dismissViewControllerAnimated:YES completion:^{
        [[BBGLoadingTips sharedInstance] showLoading:@"正在上传"];
        [ws AFNetworkUploadIDPhoto:image callBack:^(BOOL sucessful, BBGResponse *response){
            [[BBGLoadingTips sharedInstance] hideTips];
            if (sucessful) {
                BBGUploadUserHeadResponse *tempResponse = (BBGUploadUserHeadResponse*)response;
                
                if (ws.isChooseIDPhotoBack) {
                    
                    ws.editedAddress.reverseImg = tempResponse.userHeader.imageId;
                    ws.editedAddress.reverseImgUrl = tempResponse.userHeader.imageUrl;
                    ws.editedAddress.reverseImgUrlHD = tempResponse.userHeader.imageUrl;
                }else{
                    
                    ws.editedAddress.frontImg = tempResponse.userHeader.imageId;
                    ws.editedAddress.frontImgUrl = tempResponse.userHeader.imageUrl;
                    ws.editedAddress.frontImgUrlHD = tempResponse.userHeader.imageUrl;
                }
                
                [ws.tableView reloadData];
            }
        }];
    }];
}

@end
