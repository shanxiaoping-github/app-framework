//
//  BBGLogisticsViewController_iPhone.m
//  YHInternational
//
//  Created by Damon on 15/5/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGLogisticsViewController_iPhone.h"
#import "BBGLogisticsSection.h"
#import "BBGLogisticsCell.h"
#import "BBGOrderTrack.h"
#import "BBGOrderInfo.h"
#import "BBGTools.h"
@interface BBGLogisticsViewController_iPhone ()<UITableViewDataSource,UITableViewDelegate,PullDelegate>
@property (strong, nonatomic) IBOutlet BBGPullTable *tableView;
@property (strong, nonatomic) NSMutableArray * isSpreadArray;
@end

@implementation BBGLogisticsViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"物流" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    
    self.listArray = [NSMutableArray array];
    _isSpreadArray = [NSMutableArray array];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.pullDelegate = self;
    self.tableView.notOpenSticky = YES;
    
    self.pageNumber = 1;
    self.pageSize = 20;
    
    [[BBGLoadingTips sharedInstance] showLoading:nil];
    [self getData];
    
    __weak BBGLogisticsViewController_iPhone * weakSelf = self;

    
    [self.tableView refreshData:^(id data) {
        weakSelf.pageNumber = 1;
        [weakSelf getData];
        weakSelf.tableView.showsInfiniteScrolling = YES;
    }];
    
    [self.tableView loadMore:^(id data) {
        weakSelf.pageNumber += 1;
        [weakSelf getData];
        
    }];
    
}

- (void)getData{
    __weak BBGLogisticsViewController_iPhone * weakSelf = self;
    
    [self getLogisticData:^(BOOL successful, id responseData) {
        [[BBGLoadingTips sharedInstance] hideTips];
        [weakSelf.tableView stopAnimationWithCompletion:^{
            if (successful) {
                BBGLogisticsResponse * logisticsResponse = responseData;
                if (logisticsResponse.ordersLogisticsList.count <= 0) {
                    weakSelf.pageNumber -= 1;
                    weakSelf.tableView.showsInfiniteScrolling = NO;
                }
                if (logisticsResponse.ordersLogisticsList.count < 20) {
                    weakSelf.pageNumber -= 1;
                    weakSelf.tableView.showsInfiniteScrolling = NO;
                }
                
                if (weakSelf.listArray.count <= 0) {
                    [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"Logistics_Default"]  tips:@"没有在途的物流记录，包裹可能已被签收了，快去订单列表看看吧..." target:weakSelf actionTitle:nil action:nil WithResponseResult:BBGResponseNotData offset:CGPointMake(0, 0) onView:weakSelf.tableView];
                }
                
                
                for (int i = 0; i < weakSelf.listArray.count; i++) {
                    [weakSelf.isSpreadArray addObject:@(0)];
                }
                [[BBGLoadingTips sharedInstance] hideTips];
                
                [weakSelf.tableView reloadData];
            }else{
                [[BBGLoadingTips sharedInstance] showTips:@"获取物流列表失败，请重试"];
                [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"Logistics_Default"]  tips:@"没有在途的物流记录，包裹可能已被签收了，快去订单列表看看吧..." target:nil actionTitle:nil action:nil WithResponseResult:BBGResponseNotData offset:CGPointMake(0, 0) onView:weakSelf.tableView];
                
            }
        }];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- PullDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView headerView:(NSInteger)section{
    
    if (self.listArray.count > 0) {
        static NSString * sectionIdentifier = @"BBGLogisticsSection";
        BBGLogisticsSection * sectionCell = [tableView dequeueReusableCellWithIdentifier:sectionIdentifier];
        if (sectionCell == nil) {
            sectionCell = [[[NSBundle mainBundle] loadNibNamed:sectionIdentifier owner:nil options:nil] firstObject];
        }
        if (self.listArray.count > 0) {
            NSArray * array = self.listArray[section];
            BBGOrderInfo * orderInfo = array[0];
            
            [sectionCell updateSection:orderInfo];
        }
        return sectionCell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightOfHeaderView:(NSIndexPath *)indexPath{
    return 125;
}

- (void)didSelectedHeaderFooterView:(NSIndexPath *)indexPath{
    
}

#pragma mark -- UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.listArray.count > 0) {
        NSArray * array = self.listArray[section];
        NSArray * trackArray = array[1];
        NSNumber * number = self.isSpreadArray[section];
        if (number.boolValue) {
            return trackArray.count;
        }else{
            return 1;
        }
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"BBGLogisticsCell";
    BBGLogisticsCell * cell;
    if (cell == nil) {
        cell =  [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] firstObject];
    }
    
    
    NSArray * array = self.listArray[indexPath.section];
    NSArray * trackArray = array[1];
    BBGOrderTrack * track = trackArray[indexPath.row];
    
    if (indexPath.row == 0) {
        [cell openArrow:YES];
        cell.type = HeaderType;
    }
    if (indexPath.row == trackArray.count - 1) {
        [cell openArrow:NO];
        cell.type = FooterType;
    }
    
    NSNumber * number = self.isSpreadArray[indexPath.section];
    if (number.boolValue == NO) {
        cell.type = AllType;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateCell:track];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listArray.count > 0) {
        NSArray * array = self.listArray[indexPath.section];
        NSArray * trackArray = array[1];
        BBGOrderTrack * track = trackArray[indexPath.row];
        NSString * str = [NSString stringWithFormat:@"%@ %@",track.trackInfo,[BBGTools timeToString:track.trackTime.timeIntervalSince1970 Format:@"YYYY-MM-dd HH:mm:ss"]];
        CGRect frame = [str boundingRectWithSize:CGSizeMake(IPHONE_WIDTH - 72, 100000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:APP_FONT(14.0)} context:nil];
        return frame.size.height +30;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSIndexPath * index = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
        BBGLogisticsCell * cell = (BBGLogisticsCell *)[tableView cellForRowAtIndexPath:index];
        
        NSNumber * number = self.isSpreadArray[indexPath.section];
        [self.isSpreadArray replaceObjectAtIndex:indexPath.section withObject:@(!number.boolValue)];
        if (!number.boolValue == YES) {
            cell.type = HeaderType;
            [cell spreadAction:YES];
        }else{
            cell.type = AllType;

            [cell spreadAction:NO];
        }
        
        [tableView beginUpdates];
        if (!number.boolValue == YES) {
            
            
            NSArray * array = self.listArray[indexPath.section];
            NSArray * trackArray = array[1];
            NSMutableArray * indexArray = [NSMutableArray array];
            for (int i = 1; i < trackArray.count; i++) {
                [indexArray addObject:[NSIndexPath indexPathForRow:(indexPath.row + 1 + i) inSection:indexPath.section]];
            }
            [tableView insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationFade];
        }else{
            

            
            NSArray * array = self.listArray[indexPath.section];
            NSArray * trackArray = array[1];
            NSMutableArray * indexArray = [NSMutableArray array];
            for (int i = 1; i < trackArray.count; i++) {
                [indexArray addObject:[NSIndexPath indexPathForRow:(indexPath.row + 1 + i) inSection:indexPath.section]];
            }
            [tableView deleteRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationFade];
        }
        
        [tableView endUpdates];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.listArray) {
        return self.listArray.count;
    }
    return 0;
}

- (void)dealloc{
    self.isSpreadArray = nil;
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
