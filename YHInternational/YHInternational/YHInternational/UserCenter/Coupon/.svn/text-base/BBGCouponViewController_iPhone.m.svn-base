//
//  BBGCouponViewController_iPhone.m
//  YHInternational
//
//  Created by Damon on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCouponViewController_iPhone.h"
#import "Common.h"
#import "BBGComponents.h"
#import "CouponCell.h"
#import "BBGUseCouponCell.h"
#import "BBGUseExpandCell.h"
#import "BBGUseEmptyCell.h"
@interface BBGCouponViewController_iPhone ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *array;
    NSMutableArray *dataArr;
    NSInteger isExpand;
}
@property (nonatomic, strong) BBGPullTable * tableView;
@property (nonatomic, strong) NSMutableArray * couponArray;

@end

@implementation BBGCouponViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    isExpand = 1;
    self.couponListArray = [NSMutableArray array];
    self.couponArray = [NSMutableArray array];
    //    array = [NSMutableArray array];
    dataArr = [NSMutableArray array];
    
    _tableView = [[BBGPullTable alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 103)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = UIColorFromRGB(240, 239, 237);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollsToTop = NO;
    
    [_tableView registerNib:[UINib nibWithNibName:@"BBGUseCouponCell" bundle:nil] forCellReuseIdentifier:@"BBGUseCoupon"];
    [_tableView registerNib:[UINib nibWithNibName:@"BBGUseExpandCell" bundle:nil] forCellReuseIdentifier:@"BBGUseExpand"];
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 10)];
    view.backgroundColor = _tableView.backgroundColor;
    _tableView.tableFooterView = view;
    
    [self.view addSubview:_tableView];
    
    __weak BBGCouponViewController_iPhone * weakSelf = self;
    
    [_tableView loadMore:^(id data) {
        array = [NSMutableArray array];
        weakSelf.pageNumber++;
        [[BBGLoadingTips sharedInstance] showLoading:nil];
        [weakSelf updateData:^(BOOL sucessful, BBGResponse *response) {
            [weakSelf.tableView stopAnimationWithCompletion:^{
                if (sucessful) {
                    [[BBGLoadingTips sharedInstance]hideTips];
                    BBGCouponListResponse * listResponse = (BBGCouponListResponse *)response;
                    if(weakSelf.couponListArray.count >= listResponse.count){
                        weakSelf.tableView.showsInfiniteScrolling = NO;
                    }
                    [[BBGLoadingTips sharedInstance] showTips:@"已经加载完成了..."];
                    if (weakSelf.couponListArray.count ==0 ) {
                        if (weakSelf.couponStatus == 1) {
                            [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"coupon_nil"] tips:@"没有可使用的优惠券" target:nil actionTitle:nil action:nil WithResponseResult:BBGResponseNotData];
                        }else if (weakSelf.couponStatus ==2){
                            [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"coupon_nil"] tips:@"没有已使用的优惠券" target:nil actionTitle:nil action:nil WithResponseResult:BBGResponseNotData];
                        }else if(weakSelf.couponStatus == 3){
                            [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"coupon_nil"] tips:@"没有已失效的优惠券" target:nil actionTitle:nil action:nil WithResponseResult:BBGResponseNotData];
                        }
                    } else {
                        weakSelf.couponArray = weakSelf.couponListArray;
                        for (NSInteger i=0; i < weakSelf.couponArray.count; i++) {
                            BBGCoupon *model = weakSelf.couponArray[i];
                            for (NSInteger j=i+1; j<weakSelf.couponArray.count; j++) {
                                BBGCoupon *model1 = weakSelf.couponArray[j];
                                if ([model.couponCode isEqualToString:model1.couponCode]) {
                                    //                                    [weakSelf.couponArray removeObjectAtIndex:j];
                                    [weakSelf.couponArray ARRAY_REMOVEOBJ_AT(j)];
                                }
                            }
                        }
                        
                        for (NSInteger i=0; i < weakSelf.couponArray.count; i++) {
                            NSDictionary *dic = @{@"Cell": @"BBGUseCouponCell",@"isAttached":@(NO)} ;
                            [array addObject:dic] ;
                        }
                        
                        dataArr = [NSMutableArray arrayWithArray:array] ;
                        
                        [weakSelf.tableView reloadData];
                    }
                    
                }else{
                    weakSelf.pageNumber--;
                }
            }];
            
        }];
    }];
    
    [_tableView refreshData:^(id data) {
        array = [NSMutableArray array];
        //        dataArr = [NSMutableArray array];
        weakSelf.pageNumber = 1;
        [weakSelf updateData:^(BOOL sucessful, BBGResponse *response) {
            [weakSelf.tableView stopAnimationWithCompletion:^{
                BBGCouponListResponse * listResponse = (BBGCouponListResponse *)response;
                if (sucessful) {
                    if(weakSelf.couponListArray.count >= listResponse.count){
                        weakSelf.tableView.showsInfiniteScrolling = NO;
                    }else{
                        weakSelf.tableView.showsInfiniteScrolling = YES;
                    }
                    
                    if (weakSelf.couponListArray.count ==0 ) {
                        if (weakSelf.couponStatus == 1) {
                            [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"coupon_nil"] tips:@"没有可使用的优惠券" target:nil actionTitle:nil action:nil WithResponseResult:BBGResponseNotData];
                        }else if (weakSelf.couponStatus ==2){
                            [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"coupon_nil"] tips:@"没有已使用的优惠券" target:nil actionTitle:nil action:nil WithResponseResult:BBGResponseNotData];
                        }else if(weakSelf.couponStatus == 3){
                            [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"coupon_nil"] tips:@"没有已失效的优惠券" target:nil actionTitle:nil action:nil WithResponseResult:BBGResponseNotData];
                        }
                    } else {
                        
                        weakSelf.couponArray = weakSelf.couponListArray;
                        for (NSInteger i=0; i < weakSelf.couponArray.count; i++) {
                            NSDictionary *dic = @{@"Cell": @"BBGUseCouponCell",@"isAttached":@(NO)} ;
                            [array addObject:dic] ;
                        }
                        dataArr = [NSMutableArray arrayWithArray:array] ;
                        
                        [weakSelf.tableView reloadData];
                    }
                    
                    
                }else{
                    [[BBGLoadingTips sharedInstance]showTips:@"刷新失败,请重试"];
                    [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"coupon_nil"] tips:nil target:nil actionTitle:nil action:nil WithResponseResult:BBGResponseNotData];
                }
            }];
            
        }];
    }];
    
    
    
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeViewController{
    self.tableView.scrollsToTop = NO;
}

- (void)loadDataWithMenu:(BBGMenuItem *)menu force:(BOOL)force{
    if ([menu.menuID integerValue]==11) {
        self.couponStatus = 1;
        self.view.backgroundColor = [UIColor whiteColor];
    }else if ([menu.menuID integerValue]==12){
        self.couponStatus = 2;
        self.view.backgroundColor = [UIColor blueColor];
    }else if([menu.menuID integerValue] == 13){
        self.couponStatus = 3;
        self.view.backgroundColor = [UIColor redColor];
    }
    
    self.tableView.scrollsToTop = YES;
    
    if (self.couponListArray.count == 0) {
        self.pageNumber = 1;
        __weak BBGCouponViewController_iPhone * weakSelf = self;
        [[BBGLoadingTips sharedInstance]showLoadingOnView:self.view];
        
        [self updateData:^(BOOL sucessful, BBGResponse *response) {
            array = [NSMutableArray array];
            [_tableView stopAnimation];
            [[BBGLoadingTips sharedInstance] hideTips];;
            if (sucessful) {
                
                if (weakSelf.couponListArray.count ==0 ) {
                    
                    if ([menu.menuID integerValue]==11) {
                        [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"coupon_nil"] tips:@"没有可使用的优惠券" target:nil actionTitle:nil action:nil WithResponseResult:BBGResponseNotData];
                    }else if ([menu.menuID integerValue]==12){
                        [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"coupon_nil"] tips:@"没有已使用的优惠券" target:nil actionTitle:nil action:nil WithResponseResult:BBGResponseNotData];
                    }else if([menu.menuID integerValue] == 13){
                        [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"coupon_nil"] tips:@"没有已失效的优惠券" target:nil actionTitle:nil action:nil WithResponseResult:BBGResponseNotData];
                    }
                } else {
                    BBGCouponListResponse * listResponse = (BBGCouponListResponse *)response;
                    if(weakSelf.couponListArray.count >= listResponse.count){
                        weakSelf.tableView.showsInfiniteScrolling = NO;
                    }
                    weakSelf.couponArray = weakSelf.couponListArray;
                    for (NSInteger i=0; i < weakSelf.couponArray.count; i++) {
                        NSDictionary *dic = @{@"Cell": @"BBGUseCouponCell",@"isAttached":@(NO)} ;
                        [array addObject:dic] ;
                    }
                    dataArr = [NSMutableArray arrayWithArray:array] ;
                    
                    [weakSelf dismissDefaultView];
                    [_tableView reloadData];
                }
            }else{
                [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"coupon_nil"] tips:@"" target:nil actionTitle:nil action:nil WithResponseResult:BBGResponseNotData];
            }
        }];
    }
    
}

- (void)contentViewController:(UINavigationController *)controller{
    
}

#pragma mark - UITableViewDataResouce,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.couponListArray.count;
    return self.couponArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[[dataArr ARRAY_OBJ_AT(indexPath.row)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGUseCouponCell"])
    {
        BBGUseCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGUseCoupon"];
        
        if (self.couponArray.count!=0) {
            [cell updateCell:[self.couponArray ARRAY_OBJ_AT(indexPath.row)]];
        }
        cell.inStrButton.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.instrBtn.tag = indexPath.row ;
        if (![[[dataArr ARRAY_OBJ_AT(indexPath.row)] DICT_OBJ_FOR_K(@"isAttached")] boolValue]) {
            [cell.instrBtn setImage:[UIImage imageNamed:@"canuse-noexpand"]] ;
            if(self.couponStatus == 2 || self.couponStatus == 3){
                if ([[[dataArr ARRAY_OBJ_AT(indexPath.row)] DICT_OBJ_FOR_K(@"isAttached")] boolValue]) {
                    [cell.instrBtn setImage:[UIImage imageNamed:@"nouse-expand"]] ;
                }else {
                    [cell.instrBtn setImage:[UIImage imageNamed:@"nouse-noexpand"]] ;
                }
            }
            cell.leftView.hidden = YES ;
            cell.rightView.hidden = YES ;
        }else{
            cell.leftView.hidden = NO ;
            cell.rightView.hidden = NO ;
            [cell.instrBtn setImage:[UIImage imageNamed:@"canuse-expand"] ] ;
            if(self.couponStatus == 2 || self.couponStatus == 3){
                [cell.instrBtn setImage:[UIImage imageNamed:@"nouse-expand"]] ;
            }
        }
        
        
        [cell.couponBtn setBackgroundImage:[[UIImage imageNamed:@"canuse"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
        [cell.couponBtn setBackgroundImage:[[UIImage imageNamed:@"canuse-select"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateSelected];
        [cell.couponBtn setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal] ;
        [cell.couponBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected] ;
        cell.titleLab.textColor = UICOLOR_FONT_IMPORTANT_RED;
        if(self.couponStatus == 2 || self.couponStatus == 3){
            //            [cell.instrBtn setImage:[UIImage imageNamed:@"nouse-noexpand"]] ;
            [cell.couponBtn setBackgroundImage:[[UIImage imageNamed:@"unenable"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
            [cell.couponBtn setTitleColor:UIColorFromHexadecimalRGB(0xcccccc) forState:UIControlStateNormal] ;
            cell.titleLab.textColor = UIColorFromHexadecimalRGB(0xcccccc);
        }
        
        return cell;
    }else if([[[dataArr ARRAY_OBJ_AT(indexPath.row)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGUseExpandCell"]){
        
        BBGUseExpandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGUseExpand"];
        
        BBGCoupon *coupon = [self.couponArray ARRAY_OBJ_AT(indexPath.row)] ;
        cell.yhqLab.text = [NSString stringWithFormat:@"卡券编号: %@",coupon.couponCode] ;
        cell.dpLab.text = [NSString stringWithFormat:@"店铺来源: %@",coupon.shopName] ;
        cell.gcLab.text = [NSString stringWithFormat:@"使用规则: %@",coupon.couponInfo] ;
        cell.sjLab.text = [NSString stringWithFormat:@"使用日期: %@至%@",coupon.startTime,coupon.endTime] ;
        cell.yhqLab.textColor = UICOLOR_FONT_GENERAL_GRAY ;
        cell.dpLab.textColor = UICOLOR_FONT_GENERAL_GRAY ;
        cell.gcLab.textColor = UICOLOR_FONT_GENERAL_GRAY ;
        cell.sjLab.textColor = UICOLOR_FONT_GENERAL_GRAY ;
        
        if(self.couponStatus == 2 || self.couponStatus == 3){
            cell.yhqLab.textColor = UICOLOR_FONT_GENERAL_GRAYLIGHT ;
            cell.dpLab.textColor = UICOLOR_FONT_GENERAL_GRAYLIGHT ;
            cell.gcLab.textColor = UICOLOR_FONT_GENERAL_GRAYLIGHT ;
            cell.sjLab.textColor = UICOLOR_FONT_GENERAL_GRAYLIGHT ;
        }
        
        
        CGSize size1 = [cell.dpLab.text
                        sizeWithStringFont:cell.dpLab.font constrainedToSize:CGSizeMake(IPHONE_WIDTH-40, 100000)] ;
        CGRect cellFrame1 = cell.frame ;
        CGFloat cellH1 = size1.height ;
        if (cellH1>25.0f) {
            cellFrame1.size.height += cellH1 - 25.0f ;
            cell.frame = cellFrame1 ;
            cell.dpLabHeight.constant = cellH1+1.0f ;
        }
        [cell.dpLab setNeedsDisplay] ;
        [cell setNeedsDisplay] ;
        
        CGSize size = [cell.gcLab.text
                       sizeWithStringFont:cell.gcLab.font constrainedToSize:CGSizeMake(IPHONE_WIDTH-40, 100000)] ;
        CGRect cellFrame = cell.frame ;
        CGFloat cellH = size.height ;
        if (cellH>25.0f) {
            cellFrame.size.height += cellH - 25.0f ;
            cell.frame = cellFrame ;
            cell.gcLabHeight.constant = cellH+1.0f ;
        }
        [cell.gcLab setNeedsDisplay] ;
        [cell setNeedsDisplay] ;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        return cell ;
        
    }
    return nil ;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.couponArray.count == 0) {
        return 44.0f ;
    }else {
        if (dataArr.count==0) {
            return 0 ;
        }else {
            if ([[[dataArr ARRAY_OBJ_AT(indexPath.row)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGUseCouponCell"])
            {
                return 60.0f ;
            }else{
                BBGUseExpandCell *cell = (BBGUseExpandCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath] ;
                return cell.frame.size.height ;
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak BBGCouponViewController_iPhone * weakSelf = self ;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSIndexPath *path = nil;
    
    if ([[[dataArr ARRAY_OBJ_AT(indexPath.row)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGUseCouponCell"]) {
        path = [NSIndexPath indexPathForItem:(indexPath.row+1) inSection:indexPath.section];
    }else{
        path = indexPath;
    }
    if ([[[dataArr ARRAY_OBJ_AT(indexPath.row)] DICT_OBJ_FOR_K(@"Cell")]isEqualToString:@"BBGUseCouponCell"]) {
        if ([[[dataArr ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"isAttached"] boolValue]) {
            NSDictionary *dic = @{@"Cell": @"BBGUseCouponCell",@"isAttached":@(NO)};
            dataArr[path.row-1] = dic;
            [dataArr ARRAY_REMOVEOBJ_AT(path.row)];
            [self.couponArray ARRAY_REMOVEOBJ_AT(path.row)];
            BBGUseCouponCell *cell = (BBGUseCouponCell *)[tableView cellForRowAtIndexPath:indexPath];
            [cell.instrBtn setImage:[UIImage imageNamed:@"canuse-noexpand"]] ;
            if(self.couponStatus == 2 || self.couponStatus == 3){
                [cell.instrBtn setImage:[UIImage imageNamed:@"nouse-noexpand"]] ;
            }
            cell.leftView.hidden = YES ;
            cell.rightView.hidden = YES ;
            if (path!=nil) {
                [weakSelf.tableView beginUpdates];
                [weakSelf.tableView deleteRowsAtIndexPaths:@[path]  withRowAnimation:UITableViewRowAnimationFade];
                [weakSelf.tableView endUpdates];
            }
        }else{
            NSDictionary *dic = @{@"Cell": @"BBGUseCouponCell",@"isAttached":@(YES)};
            dataArr[(path.row-1)] = dic;
            NSDictionary *addDic = @{@"Cell": @"BBGUseExpandCell",@"isAttached":@(YES)};
            [dataArr ARRAY_INSERT_OBJ_AT(addDic,path.row)];
            [self.couponArray ARRAY_INSERT_OBJ_AT([self.couponArray ARRAY_OBJ_AT(path.row-1)],path.row)];
            BBGUseCouponCell * cell = (BBGUseCouponCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.leftView.hidden = NO ;
            cell.rightView.hidden = NO ;
            [cell.instrBtn setImage:[UIImage imageNamed:@"canuse-expand"] ] ;
            if(self.couponStatus == 2 || self.couponStatus == 3){
                [cell.instrBtn setImage:[UIImage imageNamed:@"nouse-expand"]] ;
            }
            if (path!=nil) {
                [weakSelf.tableView beginUpdates];
                [weakSelf.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
                [weakSelf.tableView endUpdates];
            }
        }
    }
}

- (void)dealloc{
    self.tableView = nil;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
