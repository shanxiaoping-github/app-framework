//
//  BBGIDCardListViewController_iPhone.m
//  BuBuGao
//
//  Created by holyjoy on 15/3/4.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGIDCardListViewController_iPhone.h"
#import "BBGIDCardListCell_iPhone.h"
#import "BBGIDCardEditViewController_iPhone.h"

@interface BBGIDCardListViewController_iPhone ()<UITableViewDataSource,UITableViewDelegate,BBGIDCardEditViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) BBGIDCard *deleteIDCard;

@end

@implementation BBGIDCardListViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"身份证管理" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    
    CGRect rect = self.view.bounds;
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
    [self.view addSubview:_tableView];

    [self registerCallBack];
    [self loadUserIDCard];
    [self initTableFooterView];
}

/**
 *  注册请求数据回调方法
 */
-(void)registerCallBack{
    
    [[BBGLoadingTips sharedInstance] showLoadingOnView:_tableView];
    __weak BBGIDCardListViewController_iPhone *weakSelf = self;
    self.dataCallback = ^(BBGIDCardListRequestType requestType,BBGResponseResult resultType){
        
        if (requestType == GETALLIDCard) {
            [[BBGLoadingTips sharedInstance] hideTips];
            
            if (resultType == BBGResponseSuccess) {
                
                [weakSelf.tableView reloadData];
                if ([weakSelf.userIDCardList count] == 0) {
                    [weakSelf showDefaultView:BBGResponseNotData];
                }else{
                    [weakSelf.defaultView dismiss];
                }
                
            }else{
                //TODO:处理异常
                [[BBGLoadingTips sharedInstance] showTips:@"获取身份证信息列表错误，请重试"];
            }
        }else if (requestType == DELETEIDCard) {
            if (resultType == BBGResponseSuccess) {
                
                if(weakSelf.deleteSuccessful){
                    [[BBGLoadingTips sharedInstance] showTips:@"删除成功！"];
                    [[BBGLoadingTips sharedInstance] showLoadingOnView:weakSelf.tableView];
                    [weakSelf loadUserIDCard];
                }else{
                    [[BBGLoadingTips sharedInstance] hideTips];
                    [[BBGLoadingTips sharedInstance] showTips:@"删除失败！"];
                }
                
            }else{
                //TODO:处理异常
                [[BBGLoadingTips sharedInstance] hideTips];
                [[BBGLoadingTips sharedInstance] showTips:@"删除失败！"];
            }
        }
    };
}

/**
 *  设置默认页
 *
 *  @param resultType 返回结果
 */
-(void)showDefaultView:(BBGResponseResult)resultType{
    
    if (resultType == BBGResponseNotData) {
        
        NSString *tips = @"还没有添加身份证信息";
        
        self.defaultView = [[BBGDefaultView alloc] initWithStampImage:[UIImage imageNamed:@"IDCardNull"] tips:tips target:nil action:nil actionTitle:nil];
        [self.defaultView showOnView:self.tableView];
    }
    
}


#pragma mark - UITableViewDataSource And UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = [self.userIDCardList COUNT];
    
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [BBGIDCardListCell_iPhone cellHeight];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    
//    return 30.0;
//}
//
- (void)initTableFooterView{
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 60)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, IPHONE_WIDTH-25, 25)];
    [titleLabel setText:@"身份证信息用于商品入境申报，请填写收货人的真实身份证信息。"];
    
    //    if (_mustNeedIdCardPhoto) {
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(15, titleLabel.frame.origin.y+titleLabel.frame.size.height, IPHONE_WIDTH-25, 25)];
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
    _tableView.tableFooterView = footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"BBGIDCardListCell_iPhone";
    BBGIDCardListCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGIDCardListCell_iPhone" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    BBGIDCard *IDCard = [self.userIDCardList ARRAY_OBJ_AT(indexPath.row)];
    [cell updateCellData:IDCard];
    
    __weak BBGIDCardListViewController_iPhone *weakSelf = self;
    //删除身份证
    cell.deleteActionBlock = ^(){
        weakSelf.deleteIDCard = IDCard;
        [BBGAlertView showWithTitle:@"" message:@"确定删除？" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                //删除身份证
                [[BBGLoadingTips sharedInstance] showLoadingOnView:_tableView];
                [weakSelf deleteIDCard:weakSelf.deleteIDCard.IDCardId];
            }
        } buttonTitles:@"确定", nil];
    };
    
    //编辑身份证
    cell.editActionBlock = ^(){
        
        BBGIDCardEditViewController_iPhone *editViewController = [[BBGIDCardEditViewController_iPhone alloc] init];
        editViewController.editIDCard = IDCard;
        editViewController.delegate = weakSelf;
        editViewController.isEdit = YES;
        [weakSelf.navigationController pushViewController:editViewController animated:YES];
    };
    
    //点击查看正反面大图
    NSMutableArray *bigPicArray = [NSMutableArray array];
    if (IDCard.frontImgUrlHD.length) {
        [bigPicArray addObject:[BBGPhotoModel photoWithURL:[NSURL URLWithString:IDCard.frontImgUrlHD]]];
    }
    if (IDCard.reverseImgUrlHD.length) {
        [bigPicArray addObject:[BBGPhotoModel photoWithURL:[NSURL URLWithString:IDCard.reverseImgUrlHD]]];
    }
    cell.BtnIDFrontblock = ^(){
        if (IDCard.frontImgUrlHD.length > 0) {
            BBGPhotoBrowserViewController *con = [[BBGPhotoBrowserViewController alloc] init];
            con.imgArray = bigPicArray;
            //            con.currentImgIndex = (int)indexPath.row;
            [weakSelf.navigationController presentViewController:con animated:YES completion:nil];
        }
    };
    cell.BtnIDBackblock = ^(){
        if (IDCard.reverseImgUrlHD.length > 0) {
            BBGPhotoBrowserViewController *con = [[BBGPhotoBrowserViewController alloc] init];
            con.imgArray = bigPicArray;
            if (bigPicArray.count == 2) {
                con.currentImgIndex = 1;
            }
            [weakSelf.navigationController presentViewController:con animated:YES completion:nil];
        }
    };

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

//uitableview处理section的不悬浮，禁止section停留的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 50;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

#pragma mark BBGIDCardEditViewDelegate
- (void)editIDCardSuccess{
    
    [[BBGLoadingTips sharedInstance] showLoadingOnView:_tableView];
    [self loadUserIDCard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
}

@end
