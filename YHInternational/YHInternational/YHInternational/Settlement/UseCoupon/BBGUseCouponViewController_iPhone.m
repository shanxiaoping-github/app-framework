//
//  BBGUseCouponViewController_iPhone.m
//  YHInternational
//
//  Created by Damon on 15/5/15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUseCouponViewController_iPhone.h"
#import "BBGUseCouponView.h"
#import "BBGUseCouponCell.h"
#import "BBGUseExpandCell.h"
#import "BBGUseEmptyCell.h"
#import "Common.h"
@interface BBGUseCouponViewController_iPhone ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat cellHeight ;
    NSString *isExpand ;
    NSMutableArray *stateArr ;
    NSInteger subRow ;
    NSInteger mainRow ;
    NSMutableArray *dataArr ;
    NSMutableArray *enableArr ;
    NSMutableArray *array ;
    NSMutableArray *array1 ;
    NSMutableArray *dataSourceArr ;

}
@property (strong, nonatomic) IBOutlet BBGPullTable *tableView;
@property (nonatomic, strong) BBGUseCouponView * couponView;
@property (nonatomic, assign) NSInteger selectedNum;
@property (nonatomic, strong) NSMutableArray * couponArray;
@property (nonatomic, strong) NSMutableArray * enableArray;
@property (nonatomic, copy) UseCouponBlock callback;
@end

@implementation BBGUseCouponViewController_iPhone

- (id)initWithCallback:(void(^)(BOOL successful,id response))callback{
    self = [super init];
    if (self) {
        self.callback = callback;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"使用优惠券" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    __weak BBGUseCouponViewController_iPhone * weakSelf = self;
    
    cellHeight = 115 ;
    isExpand = @"0" ;
    stateArr = [NSMutableArray array] ;
    dataArr = [NSMutableArray array] ;
    array = [NSMutableArray array] ;
    array1 = [NSMutableArray array] ;
    enableArr = [NSMutableArray array] ;
    self.tableView.bounces = NO ;
    
    [self.tableView refreshData:^(id data) {
        [weakSelf checkUserCoupon:weakSelf.shopId buyType:weakSelf.buyType callback:^(BOOL successful, id response) {
            [weakSelf.tableView stopAnimation];
            BBGUserCouponResponse * responseData = response;
            weakSelf.couponArray = responseData.couponArray;
            [weakSelf.tableView reloadData];
        }];
    }];
    
    [self checkUserCoupon:self.shopId buyType:self.buyType callback:^(BOOL successful, id response) {
        BBGUserCouponResponse * responseData = response;
        weakSelf.couponArray = responseData.couponArray;
        weakSelf.enableArray = responseData.enableArray;
        for (NSInteger i=0; i < weakSelf.couponArray.count; i++) {
            NSDictionary *dic = @{@"Cell": @"BBGUseCouponCell",@"isAttached":@(NO)} ;
            [array addObject:dic] ;
        }

        dataArr = [NSMutableArray arrayWithArray:array] ;
        
        for (NSInteger i=0; i < weakSelf.enableArray.count; i++) {
            NSDictionary *dic = @{@"Cell": @"BBGUseCouponCell",@"isAttached":@(NO)} ;
            [array1 addObject:dic] ;
        }
        enableArr = [NSMutableArray arrayWithArray:array1] ;
        
        
        [weakSelf.tableView reloadData];
    }];
    
    _couponView = [[[NSBundle mainBundle] loadNibNamed:@"BBGUseCouponView" owner:self options:nil] firstObject];
    [_couponView setFrame:CGRectMake(0, 0, IPHONE_WIDTH, 150)];
    [self.view addSubview:_couponView];
    _couponView.block = ^{
        [weakSelf useCouponCode:weakSelf.couponView.couponCode shopId:weakSelf.shopId buyType:weakSelf.buyType couponType:@"out" callback:weakSelf.callback];
    };
    [_couponView handlerButtonAction:^{
        [weakSelf cancelUserCoupon:weakSelf.shopId buyType:weakSelf.buyType callback:^(BOOL successful, id response) {
            if (successful) {
                if (weakSelf.callback) {
                    weakSelf.callback(YES,response);
                    [self.navigationController popViewControllerAnimated:YES] ;
                }
            }
        }] ;
    }] ;
    
    self.selectedNum = -1;
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 10)];
    view.backgroundColor = UIColorFromRGB(240, 239, 237);
    self.tableView.tableFooterView = view;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (self.couponArray) {
//        return self.couponArray.count;
//    }
//    return 0;
    if (section == 0) {
        if (self.couponArray.count==0) {
            return 1 ;
        }else {
            return self.couponArray.count ;
        }
    }else {
        return self.enableArray.count ;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.couponArray.count == 0) {
            
            [tableView registerNib:[UINib nibWithNibName:@"BBGUseEmptyCell" bundle:nil] forCellReuseIdentifier:@"BBGUseEmpty"] ;
            
            BBGUseEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGUseEmpty"];
            
            return cell ;
        }else {
            if ([[[dataArr ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"Cell"] isEqualToString:@"BBGUseCouponCell"])
            {
                static NSString *identifier = @"BBGUseCouponCell";
                
                BBGUseCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] firstObject];
                }
                cell.inStrButton.hidden = NO;
                cell.instrBtn.hidden = YES;
                if (self.couponArray) {
                    [cell updateCell:[self.couponArray ARRAY_OBJ_AT(indexPath.row)]];
                    BBGCoupon *model = [self.couponArray ARRAY_OBJ_AT(indexPath.row)];
                    if ([model.couponCode isEqualToString:self.selectedCoupon.couponCode]) {
                        cell.couponBtn.selected = YES ;
                    }
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.instrBtn.tag = indexPath.row ;
                cell.leftView.hidden = YES ;
                cell.rightView.hidden = YES ;
            
                [cell.inStrButton setBackgroundImage:[UIImage imageNamed:@"canuse-noexpand"] forState:UIControlStateNormal];
                [cell.couponBtn setBackgroundImage:[[UIImage imageNamed:@"canuse"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
                [cell.couponBtn setBackgroundImage:[[UIImage imageNamed:@"canuse-select"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateSelected];
                [cell.couponBtn setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal] ;
                [cell.couponBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected] ;
                
                [cell.inStrButton addTarget:self action:@selector(couponClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.titleLab.textColor = UICOLOR_FONT_IMPORTANT_RED;
                if (cell.couponBtn.selected == YES) {
                    cell.titleLab.textColor = [UIColor whiteColor];
                }
                
                if (self.selectedNum == -1) {
                    BBGCoupon * coupon = [self.couponArray ARRAY_OBJ_AT(indexPath.row)];
                    if ([self.selectedCoupon.couponCode isEqualToString:coupon.couponCode]) {
                        [cell setSelected:YES animated:NO];
                        self.selectedNum = indexPath.row;
                    }
                }
                
                if (self.selectedNum == indexPath.row) {
                    [cell setSelected:YES animated:NO];
                }
                
                return cell;
            }else if([[[dataArr ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"Cell"] isEqualToString:@"BBGUseExpandCell"]){
                
                static NSString *identifier = @"BBGUseExpandCell";
                
                BBGUseExpandCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] firstObject];
                }
                BBGCoupon * coupon = [self.couponArray ARRAY_OBJ_AT(indexPath.row)] ;
                cell.yhqLab.text = [NSString stringWithFormat:@"卡券编号: %@",coupon.couponCode] ;
                cell.dpLab.text = [NSString stringWithFormat:@"店铺来源: %@",coupon.shopName] ;
                cell.gcLab.text = [NSString stringWithFormat:@"使用规则: %@",coupon.couponInfo] ;
                cell.sjLab.text = [NSString stringWithFormat:@"使用日期: %@至%@",coupon.startTime,coupon.endTime] ;
                cell.yhqLab.textColor = UICOLOR_FONT_GENERAL_GRAY ;
                cell.dpLab.textColor = UICOLOR_FONT_GENERAL_GRAY ;
                cell.gcLab.textColor = UICOLOR_FONT_GENERAL_GRAY ;
                cell.sjLab.textColor = UICOLOR_FONT_GENERAL_GRAY ;
                
                CGSize size1 = [cell.dpLab.text
                                sizeWithStringFont:cell.dpLab.font constrainedToSize:CGSizeMake(IPHONE_WIDTH-40, 100000)] ;
                CGRect cellFrame1 = cell.frame ;
                CGFloat cellH1 = size1.height ;
                cellFrame1.size.height += cellH1 - 25.0f ;
                cell.frame = cellFrame1 ;
                cell.dpLabHeight.constant = cellH1 ;
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
        }
    }else {
        if ([[[enableArr ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"Cell"] isEqualToString:@"BBGUseCouponCell"])
        {
            static NSString *identifier = @"BBGUseCouponCell";
            
            BBGUseCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] firstObject];
            }
            if (self.enableArray) {
                [cell updateCell:[self.enableArray ARRAY_OBJ_AT(indexPath.row)]];
            }
            cell.instrBtn.hidden = YES;
            cell.inStrButton.hidden = NO;
            
            cell.couponBtn.enabled = NO ;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.instrBtn.tag = indexPath.row ;
            cell.leftView.hidden = YES ;
            cell.rightView.hidden = YES ;
            
            [cell.inStrButton setBackgroundImage:[UIImage imageNamed:@"nouse-noexpand"] forState:UIControlStateNormal] ;
            [cell.couponBtn setBackgroundImage:[[UIImage imageNamed:@"unenable"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
            [cell.couponBtn setTitleColor:UIColorFromHexadecimalRGB(0xcccccc) forState:UIControlStateNormal] ;
            [cell.inStrButton addTarget:self action:@selector(enableClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.titleLab.textColor = UIColorFromHexadecimalRGB(0xcccccc);
            
            return cell;
        }else if([[[enableArr ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"Cell"] isEqualToString:@"BBGUseExpandCell"]){
            
            static NSString *identifier = @"BBGUseExpandCell";
            
            BBGUseExpandCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] firstObject];
            }

            BBGCoupon * coupon ;
            coupon = [self.enableArray ARRAY_OBJ_AT(indexPath.row)] ;
            cell.yhqLab.text = [NSString stringWithFormat:@"卡券编号: %@",coupon.couponCode] ;
            cell.dpLab.text = [NSString stringWithFormat:@"店铺来源: %@",coupon.shopName] ;
            cell.gcLab.text = [NSString stringWithFormat:@"使用规则: %@",coupon.couponInfo] ;
            cell.sjLab.text = [NSString stringWithFormat:@"使用日期: %@至%@",coupon.startTime,coupon.endTime] ;
            cell.yhqLab.textColor = UICOLOR_FONT_GENERAL_GRAYLIGHT ;
            cell.dpLab.textColor = UICOLOR_FONT_GENERAL_GRAYLIGHT ;
            cell.gcLab.textColor = UICOLOR_FONT_GENERAL_GRAYLIGHT ;
            cell.sjLab.textColor = UICOLOR_FONT_GENERAL_GRAYLIGHT ;
            
            CGSize size1 = [cell.dpLab.text
                            sizeWithStringFont:cell.dpLab.font constrainedToSize:CGSizeMake(IPHONE_WIDTH-40, 100000)] ;
            CGRect cellFrame1 = cell.frame ;
            CGFloat cellH1 = size1.height ;
            cellFrame1.size.height += cellH1 - 25.0f ;
            cell.frame = cellFrame1 ;
            cell.dpLabHeight.constant = cellH1+1.0f ;
            [cell.dpLab setNeedsDisplay] ;
            [cell setNeedsDisplay] ;
            
            CGSize size = [cell.gcLab.text
                           sizeWithStringFont:cell.gcLab.font constrainedToSize:CGSizeMake(IPHONE_WIDTH-40, 100000)] ;
            CGRect cellFrame = cell.frame ;
            CGFloat cellH = size.height ;
            cellFrame.size.height += cellH - 25.0f ;
            cell.frame = cellFrame ;
            cell.gcLabHeight.constant = cellH+1.0f ;
            [cell.gcLab setNeedsDisplay] ;
            [cell setNeedsDisplay] ;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone ;
            
            return cell ;
            
        }
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.couponArray.count == 0) {
            return 44.0f ;
        }else {
            if (dataArr.count==0) {
                return 0 ;
            }else {
                if ([[[dataArr ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"Cell"] isEqualToString:@"BBGUseCouponCell"])
                {
                    return 60.0f ;
                }else{
                    BBGUseExpandCell *cell = (BBGUseExpandCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath] ;
                    return cell.frame.size.height ;
                }
            }
        }
    }else {
        if (enableArr.count==0) {
            return 0 ;
        }else {
            if ([[[enableArr ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"Cell"] isEqualToString:@"BBGUseCouponCell"])
            {
                return 60.0f ;
            }else{
                BBGUseExpandCell *cell = (BBGUseExpandCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath] ;
                return cell.frame.size.height ;
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.couponArray.count!=0) {
            if ([[[dataArr ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"Cell"] isEqualToString:@"BBGUseCouponCell"]){
                BBGUseCouponCell * cell = (BBGUseCouponCell *)[tableView cellForRowAtIndexPath:indexPath];
                if (self.selectedNum != indexPath.row) {
                    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:self.selectedNum inSection:indexPath.section];
                    BBGUseCouponCell * cell = (BBGUseCouponCell *)[tableView cellForRowAtIndexPath:selectedIndexPath];
                    [cell setSelected:NO animated:NO];
                }
                
                self.selectedNum = indexPath.row;
                [cell setSelected:YES animated:NO];
                __weak BBGUseCouponViewController_iPhone * weakSelf = self;
                
                BBGCoupon *coupon = [self.couponArray ARRAY_OBJ_AT(indexPath.row)];
                
                [self useCouponCode:coupon.couponCode shopId:self.shopId buyType:self.buyType couponType:coupon.type callback:^(BOOL successful, id response) {
                    if (successful) {
                        if (weakSelf.callback) {
                            weakSelf.callback(YES,response);
                        }
                    }
                }];
            }
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *myView = [[UIView alloc]init] ;
    myView.backgroundColor = UIColorFromRGB(240,239,237) ;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)] ;
    if (section == 0) {
        titleLabel.text = @"选择可用优惠券" ;
    }else {
        titleLabel.text = @"不可用优惠券" ;
    }
    titleLabel.textColor = UICOLOR_FONT_IMPORTANT_BLACK ;
    titleLabel.font = APP_FONT(14.0f) ;
    [myView addSubview:titleLabel] ;
    return myView ;
}

- (void)couponClick:(UIButton *)sender {
    BBGUseCouponCell *cell = (BBGUseCouponCell*)[BBGTools tableViewCell:sender];
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];

    [_tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSIndexPath *path = nil;

    if ([[[dataArr ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"Cell"] isEqualToString:@"BBGUseCouponCell"]) {
        path = [NSIndexPath indexPathForItem:(indexPath.row+1) inSection:indexPath.section];
    }else{
        path = indexPath;
    }

    if ([[[dataArr ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"isAttached"] boolValue]) {
        NSDictionary *dic = @{@"Cell": @"BBGUseCouponCell",@"isAttached":@(NO)};
        dataArr[(path.row-1)] = dic;
        [dataArr removeObjectAtIndex:path.row];
        [self.couponArray removeObjectAtIndex:path.row] ;
        [cell.inStrButton setBackgroundImage:[UIImage imageNamed:@"canuse-noexpand"] forState:UIControlStateNormal] ;
        cell.leftView.hidden = YES ;
        cell.rightView.hidden = YES ;
        [_tableView beginUpdates];
        [_tableView deleteRowsAtIndexPaths:@[path]  withRowAnimation:UITableViewRowAnimationFade];
        [_tableView endUpdates];

    }else{
        NSDictionary *dic = @{@"Cell": @"BBGUseCouponCell",@"isAttached":@(YES)};
        dataArr[(path.row-1)] = dic;
        NSDictionary *addDic = @{@"Cell": @"BBGUseExpandCell",@"isAttached":@(YES)};
        [dataArr insertObject:addDic atIndex:path.row];
        [self.couponArray insertObject:self.couponArray[path.row-1] atIndex:path.row] ;
        cell.leftView.hidden = NO ;
        cell.rightView.hidden = NO ;
        [cell.inStrButton setBackgroundImage:[UIImage imageNamed:@"canuse-expand"] forState:UIControlStateNormal] ;
        [_tableView beginUpdates];
        [_tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        [_tableView endUpdates];
    }
}

- (void)enableClick:(UIButton *)sender {
    BBGUseCouponCell *cell = (BBGUseCouponCell*)[BBGTools tableViewCell:sender];
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSIndexPath *path = nil;

    if ([[[enableArr ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"Cell"] isEqualToString:@"BBGUseCouponCell"]) {
        path = [NSIndexPath indexPathForItem:(indexPath.row+1) inSection:indexPath.section];
    }else{
        path = indexPath;
    }

    NSLog(@"当前path:%ld %ld",path.row,path.section);

    if ([[[enableArr ARRAY_OBJ_AT(indexPath.row)] objectForKey:@"isAttached"] boolValue]) {
        NSDictionary *dic = @{@"Cell": @"BBGUseCouponCell",@"isAttached":@(NO)};
        enableArr[(path.row-1)] = dic;
        [enableArr removeObjectAtIndex:path.row];
        [self.enableArray removeObjectAtIndex:path.row] ;
        cell.leftView.hidden = YES ;
        cell.rightView.hidden = YES ;
        [cell.inStrButton setBackgroundImage:[UIImage imageNamed:@"nouse-noexpand"] forState:UIControlStateNormal] ;
        [_tableView beginUpdates];
        [_tableView deleteRowsAtIndexPaths:@[path]  withRowAnimation:UITableViewRowAnimationFade];
        [_tableView endUpdates];

    }else{
        NSDictionary *dic = @{@"Cell": @"BBGUseCouponCell",@"isAttached":@(YES)};
        enableArr[(path.row-1)] = dic;
        NSDictionary *addDic = @{@"Cell": @"BBGUseExpandCell",@"isAttached":@(YES)};
        [enableArr insertObject:addDic atIndex:path.row];
        [self.enableArray insertObject:self.enableArray[path.row-1] atIndex:path.row] ;
        cell.leftView.hidden = NO ;
        cell.rightView.hidden = NO ;
        [cell.inStrButton setBackgroundImage:[UIImage imageNamed:@"nouse-expand"] forState:UIControlStateNormal] ;
        [_tableView beginUpdates];
        [_tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        [_tableView endUpdates];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (self.enableArray.count == 0) {
        if (section == 1) {
            return 0.0f ;
        }else {
            return 40.0f ;
        }
    }else {
        return 40.0f ;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40.0f ;
    if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0) ;
    }else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0) ;
    }
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
