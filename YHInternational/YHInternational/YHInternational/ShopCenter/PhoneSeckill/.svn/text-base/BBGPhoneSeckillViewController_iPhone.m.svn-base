//
//  PhoneSeckillViewController_iPhone.m
//  YHInternational
//
//  Created by 彭腾 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPhoneSeckillViewController_iPhone.h"
#import "BBGPhoneSeckillEmptyCell.h"
#import "BBGPhoneSeckillHeaderCell.h"
#import "BBGPhoneSeckillSubCell.h"
#import "BBGPhoneSeckillModel.h"
#import "BBGSecKillProduct.h"
#import "BBGGoodsDetailViewController_iPhone.h"
#import "BBGSettlementViewController_iPhone.h"
#import "BBGMaternalAndBeautyViewController_iPhone.h"
#import "BBGPhoneSeckillMainCell.h"
#import "BBGPhoneSeckillContentCell.h"
#import "BBGSecKillTableViewCell.h"
#import "BBGGoodsSeckillViewController_iPhone.h"

@interface BBGPhoneSeckillViewController_iPhone ()<UITableViewDelegate,UITableViewDataSource,PullDelegate,BBGSecKillDelegate,BBGPhoneSeckillMainDelegate> {
    NSMutableDictionary *dic;
    NSInteger sectionNum;
    BOOL loadMore;
}
@property (nonatomic, strong) BBGPullTable *PhoneSeckill;
@property (nonatomic, strong) NSMutableArray *totalArr;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *signArr;

@end

@implementation BBGPhoneSeckillViewController_iPhone

#pragma mark - BBGPhoneSeckillMainDelegate
- (void)reload {
    WS(ws)
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        [ws.PhoneSeckill stopAnimationWithCompletion:^{
            if (sucessful) {
                ws.PhoneSeckill.showsInfiniteScrolling = ws.isLoadMore;
                [ws getArray];
                [ws.PhoneSeckill reloadData];
            }
        }];
    }];
}

- (void)animationFinish:(NSInteger)section {
    [self.signArr ARRAY_REMOVEOBJ_AT(section)];
    NSString *string = @"1";
    [self.signArr ARRAY_INSERT_OBJ_AT(string,section)];
}

- (void)initUI {
    dic = [NSMutableDictionary dictionary];
    self.dataArr = [NSMutableArray array];
    self.dataArr = [self getDataSource:self.phoneSeckillArr];
    self.signArr = [NSMutableArray array];
    
    self.view.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;
    
    _PhoneSeckill = [[BBGPullTable alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-64)];
    _PhoneSeckill.delegate = self;
    _PhoneSeckill.dataSource = self;
    _PhoneSeckill.separatorStyle = UITableViewCellSeparatorStyleNone;
    _PhoneSeckill.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;
    
    [self registerCell];
    
    [self.view addSubview:_PhoneSeckill];
}

#pragma mark - 得到数据源
- (void)getArray {
    self.totalArr = [NSMutableArray arrayWithArray:self.phoneSeckillArr];
    self.dataArr = [self getDataSource:self.phoneSeckillArr];
}

#pragma mark - 数据源分类
- (NSMutableArray *)getDataSource:(NSMutableArray *)array {
    NSMutableArray *finalArr = [NSMutableArray array];
    NSMutableArray *mainArr = [NSMutableArray array];
    NSMutableArray *subArr = [NSMutableArray array];
    NSDate *sysDate = [[BBGConfiguration sharedInstance]getCurrentServerTime];
    NSTimeInterval sys = [sysDate timeIntervalSince1970];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    for (NSInteger i=0; i<array.count; i++) {
        BBGPhoneSeckillModel *model = array[i];
        NSDate *startDate = [formatter dateFromString:model.startDate];
        NSTimeInterval start = [startDate timeIntervalSince1970];
        if (sys>start) {
            for (NSInteger i=0; i<model.products.count; i++) {
                BBGSecKillProduct *model1 = model.products[i];
                [mainArr addObject:model1];
            }
        }
        if (sys<start) {
            NSString *string = @"0";
            [self.signArr addObject:string];
            [subArr addObject:model];
        }
    }
    
    if (mainArr.count!=0) {
        [finalArr addObject:mainArr];
        [dic setObject:@"exist" forKey:@"mainArr"];
    }else {
        [dic setObject:@"notexist" forKey:@"mainArr"];
    }
    
    if (subArr.count!=0) {
        [finalArr addObject:subArr];
        if (mainArr.count==0) {
            [finalArr addObject:subArr];
        }
        [dic setObject:@"exist" forKey:@"subArr"];
    }else {
        [dic setObject:@"notexist" forKey:@"subArr"];
    }
    
    NSString *mainStr = [dic objectForKey:@"mainArr"];
    NSString *subStr = [dic objectForKey:@"subArr"];
    
    if ([mainStr isEqualToString:@"notexist"]&&[subStr isEqualToString:@"exist"]) {
        sectionNum = subArr.count;
    }else if ([mainStr isEqualToString:@"notexist"]&&[subStr isEqualToString:@"notexist"]) {
        sectionNum = 0;
    }else {
        sectionNum = 1+subArr.count;
    }
    
    return finalArr;
    
}

#pragma mark - tableViewCell注册
- (void)registerCell {
    [_PhoneSeckill registerNib:[UINib nibWithNibName:@"BBGPhoneSeckillEmptyCell" bundle:nil] forCellReuseIdentifier:@"PhoneSeckillEmpty"];
    [_PhoneSeckill registerNib:[UINib nibWithNibName:@"BBGPhoneSeckillCell" bundle:nil] forCellReuseIdentifier:@"PhoneSeckill"];
    [_PhoneSeckill registerNib:[UINib nibWithNibName:@"BBGPhoneSeckillHeaderCell" bundle:nil] forCellReuseIdentifier:@"PhoneSeckillHeader"];
    [_PhoneSeckill registerNib:[UINib nibWithNibName:@"BBGPhoneSeckillSubCell" bundle:nil] forCellReuseIdentifier:@"PhoneSeckillSub"];
    [_PhoneSeckill registerNib:[UINib nibWithNibName:@"BBGPhoneSeckillMainCell" bundle:nil] forCellReuseIdentifier:@"BBGPhoneSeckillMainCell"];
    [_PhoneSeckill registerNib:[UINib nibWithNibName:@"BBGPhoneSeckillContentCell" bundle:nil] forCellReuseIdentifier:@"BBGPhoneSeckillContent"];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sectionNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *mainStr = [dic objectForKey:@"mainArr"];
    NSString *subStr = [dic objectForKey:@"subArr"];
    if ([mainStr isEqualToString:@"exist"]&&[subStr isEqualToString:@"exist"]) {
        if (section==0) {
            NSMutableArray *array = [self.dataArr ARRAY_OBJ_AT(section)];
            return array.count+1;
        }else {
            NSMutableArray *array = [self.dataArr ARRAY_OBJ_AT(1)];
            BBGPhoneSeckillModel *model = [array ARRAY_OBJ_AT(section-1)];
            return model.products.count;
        }
    }else if ([mainStr isEqualToString:@"exist"]&&[subStr isEqualToString:@"notexist"]) {
        NSMutableArray *array = [self.dataArr ARRAY_OBJ_AT(0)];
        return array.count+1;
    }else if ([mainStr isEqualToString:@"notexist"]&&[subStr isEqualToString:@"exist"]) {
        NSMutableArray *array = [self.dataArr ARRAY_OBJ_AT(0)];
        BBGPhoneSeckillModel *model = [array ARRAY_OBJ_AT(section)];
        return model.products.count;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *mainStr = [dic objectForKey:@"mainArr"];
    NSString *subStr = [dic objectForKey:@"subArr"];
    if ([mainStr isEqualToString:@"exist"]&&[subStr isEqualToString:@"exist"]) {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                BBGPhoneSeckillEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneSeckillEmpty"];
                return cell;
            }else {
                BBGSecKillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGSeckill"];
                if (!cell) {
                    cell = [[BBGSecKillTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BBGSeckill"];
                }
                cell.indexpath = indexPath;
                cell.delegate = self;
                cell.selectionStyle  = UITableViewCellSelectionStyleNone;
                NSMutableArray *array = [self.dataArr ARRAY_OBJ_AT(0)];
                BBGSecKillProduct *model = [array ARRAY_OBJ_AT(indexPath.row-1)];
                [cell updateCell:model isUp:YES];
                return cell;
            }
        }else {
            if (indexPath.row==0) {
                BBGPhoneSeckillMainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGPhoneSeckillMainCell"];
                NSMutableArray *array = [self.dataArr ARRAY_OBJ_AT(1)];
                BBGPhoneSeckillModel *model = [array ARRAY_OBJ_AT(indexPath.section-1)];
                BBGSecKillProduct *model1 = [model.products ARRAY_OBJ_AT(indexPath.row)];
                [cell updateCellWith:model1 Time:model sign:[self.signArr ARRAY_OBJ_AT(indexPath.section-1)] section:indexPath.section-1];
                cell.delegate = self;
                return cell;
            }else {
                BBGPhoneSeckillContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGPhoneSeckillContent"];
                NSMutableArray *array = [self.dataArr ARRAY_OBJ_AT(1)];
                BBGPhoneSeckillModel *model = [array ARRAY_OBJ_AT(indexPath.section-1)];
                BBGSecKillProduct *model1 = [model.products ARRAY_OBJ_AT(indexPath.row)];
                [cell updateCellWith:model1];
                return cell;
            }
        }
    }else if ([mainStr isEqualToString:@"exist"]&&[subStr isEqualToString:@"notexist"]) {
        if (indexPath.row==0) {
            BBGPhoneSeckillEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneSeckillEmpty"];
            return cell;
        }else {
            BBGSecKillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGSeckill"];
            if (!cell) {
                cell = [[BBGSecKillTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BBGSeckill"];
            }
            cell.indexpath = indexPath;
            cell.delegate = self;
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            NSMutableArray *array = [self.dataArr ARRAY_OBJ_AT(0)];
            BBGSecKillProduct *model = [array ARRAY_OBJ_AT(indexPath.row-1)];
            [cell updateCell:model isUp:YES];
            return cell;
        }
    }else if ([mainStr isEqualToString:@"notexist"]&&[subStr isEqualToString:@"exist"]) {
        if (indexPath.row==0) {
            BBGPhoneSeckillMainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGPhoneSeckillMainCell"];
            NSMutableArray *array = [self.dataArr ARRAY_OBJ_AT(1)];
            BBGPhoneSeckillModel *model = [array ARRAY_OBJ_AT(indexPath.section)];
            BBGSecKillProduct *model1 = [model.products ARRAY_OBJ_AT(indexPath.row)];
            [cell updateCellWith:model1 Time:model sign:[self.signArr ARRAY_OBJ_AT(indexPath.section)] section:indexPath.section];
            cell.delegate = self;
            return cell;
        }else {
            BBGPhoneSeckillContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGPhoneSeckillContent"];
            NSMutableArray *array = [self.dataArr ARRAY_OBJ_AT(1)];
            BBGPhoneSeckillModel *model = [array ARRAY_OBJ_AT(indexPath.section)];
            BBGSecKillProduct *model1 = [model.products ARRAY_OBJ_AT(indexPath.row)];
            [cell updateCellWith:model1];
            return cell;
        }
    }else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *mainStr = [dic objectForKey:@"mainArr"];
    NSString *subStr = [dic objectForKey:@"subArr"];
    if ([mainStr isEqualToString:@"exist"]&&[subStr isEqualToString:@"exist"]) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                return 10.0f;
            }else {
                return 133.0f;
            }
        }else {
            if (indexPath.row == 0) {
                return 160.0f;
            }else {
                return 135.0f;
            }
        }
    }else if ([mainStr isEqualToString:@"exist"]&&[subStr isEqualToString:@"notexist"]) {
        if (indexPath.row == 0) {
            return 10.0f;
        }else {
            return 133.0f;
        }
    }else if ([mainStr isEqualToString:@"notexist"]&&[subStr isEqualToString:@"exist"]) {
        if (indexPath.row == 0) {
            return 160.0f;
        }else {
            return 135.0f;
        }
    }else {
        return 0.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *mainStr = [dic objectForKey:@"mainArr"];
    NSString *subStr = [dic objectForKey:@"subArr"];
    
    if ([mainStr isEqualToString:@"exist"]&&[subStr isEqualToString:@"exist"]) {
        if (indexPath.section == 0) {
            if (indexPath.row > 0) {
                NSMutableArray *array = [self.dataArr ARRAY_OBJ_AT(0)];
                BBGSecKillProduct *model = [array ARRAY_OBJ_AT(indexPath.row-1)];
                if (model.isSecKill) {
                    BBGGoodsSeckillViewController_iPhone *vc = [[BBGGoodsSeckillViewController_iPhone alloc]init];
                    vc.productId = model.productId;
                    vc.activityId = model.activityId;
                    [self.navigationController pushViewController:vc animated:YES];
                }else {
                    BBGGoodsDetailViewController_iPhone *vc = [[BBGGoodsDetailViewController_iPhone alloc]init];
                    vc.productId = model.productId;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }else {
            NSMutableArray *array = [self.dataArr ARRAY_OBJ_AT(1)];
            BBGPhoneSeckillModel *model = [array ARRAY_OBJ_AT(indexPath.section-1)];
            BBGSecKillProduct *model1 = [model.products ARRAY_OBJ_AT(indexPath.row)];
            if (model1.isSecKill) {
                BBGGoodsSeckillViewController_iPhone *vc = [[BBGGoodsSeckillViewController_iPhone alloc]init];
                vc.productId = model1.productId;
                vc.activityId = model1.activityId;
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                BBGGoodsDetailViewController_iPhone *vc = [[BBGGoodsDetailViewController_iPhone alloc]init];
                vc.productId = model1.productId;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
    
    if ([mainStr isEqualToString:@"exist"]&&[subStr isEqualToString:@"notexist"]) {
        if (indexPath.row > 0) {
            NSMutableArray *array = [self.dataArr ARRAY_OBJ_AT(0)];
            BBGSecKillProduct *model = [array ARRAY_OBJ_AT(indexPath.row-1)];
            if (model.isSecKill) {
                BBGGoodsSeckillViewController_iPhone *vc = [[BBGGoodsSeckillViewController_iPhone alloc]init];
                vc.productId = model.productId;
                vc.activityId = model.activityId;
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                BBGGoodsDetailViewController_iPhone *vc = [[BBGGoodsDetailViewController_iPhone alloc]init];
                vc.productId = model.productId;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
    
    if ([mainStr isEqualToString:@"notexist"]&&[subStr isEqualToString:@"exist"]) {
        NSMutableArray *array = [self.dataArr ARRAY_OBJ_AT(1)];
        BBGPhoneSeckillModel *model = [array ARRAY_OBJ_AT(indexPath.section)];
        BBGSecKillProduct *model1 = [model.products ARRAY_OBJ_AT(indexPath.row)];
        if (model1.isSecKill) {
            BBGGoodsSeckillViewController_iPhone *vc = [[BBGGoodsSeckillViewController_iPhone alloc]init];
            vc.productId = model1.productId;
            vc.activityId = model1.activityId;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            BBGGoodsDetailViewController_iPhone *vc = [[BBGGoodsDetailViewController_iPhone alloc]init];
            vc.productId = model1.productId;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)];
    label.text = @"手机秒杀";
    label.font = APP_FONT_DEMI_LIGHT(18.0f);
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    [self initUI];
    
    __weak BBGPhoneSeckillViewController_iPhone *weakSelf = self;
    weakSelf.pageIndex = 1;
    
    [self.PhoneSeckill refreshData:^(id data) {
        weakSelf.pageIndex = 1;
        [weakSelf updateData:^(BOOL sucessful, BBGResponse *response) {
            [weakSelf.PhoneSeckill stopAnimationWithCompletion:^{
                if (sucessful) {
                    weakSelf.isLoadMore = YES;
                    weakSelf.PhoneSeckill.showsInfiniteScrolling = weakSelf.isLoadMore;
                    [weakSelf.PhoneSeckill stopAnimation];
                    [weakSelf getArray];
                    [weakSelf.PhoneSeckill reloadData];
                }
            }];
        }];
    }];
    
    [self.PhoneSeckill loadMore:^(id data) {
        weakSelf.pageIndex++;
        [weakSelf updateData:^(BOOL sucessful, BBGResponse *response) {
            [weakSelf.PhoneSeckill stopAnimationWithCompletion:^{
                if (sucessful) {
                    if (weakSelf.phoneSeckillArr.count!=0) {
                        weakSelf.isLoadMore = YES;
                    }else {
                        weakSelf.isLoadMore = NO;
                    }
                    if (weakSelf.phoneSeckillArr.count!=0) {
                        for (NSInteger i=0; i<weakSelf.phoneSeckillArr.count; i++) {
                            BBGPhoneSeckillModel *model = weakSelf.phoneSeckillArr[i];
                            [weakSelf.totalArr addObject:model];
                        }
                        weakSelf.dataArr = [weakSelf getDataSource:weakSelf.totalArr];
                        [weakSelf.PhoneSeckill reloadData];
                    }
                    weakSelf.PhoneSeckill.showsInfiniteScrolling = weakSelf.isLoadMore;
                }else{
                    weakSelf.pageIndex--;
                }
            }];
            
        }];
    }];
    
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        [weakSelf.PhoneSeckill stopAnimationWithCompletion:^{
            if (sucessful) {
                weakSelf.isLoadMore = YES;
                weakSelf.PhoneSeckill.showsInfiniteScrolling = weakSelf.isLoadMore;
                [weakSelf getArray];
                [weakSelf.PhoneSeckill reloadData];
            }
        }];
    }];
}

- (void)indexClicked:(NSIndexPath *)indexpath {
    __weak BBGPhoneSeckillViewController_iPhone *weakSelf = self;
    NSMutableArray *array = [self.dataArr ARRAY_OBJ_AT(0)];
    BBGSecKillProduct *model = [array ARRAY_OBJ_AT(indexpath.row-1)];
    
    if (model.isSecKill) {
        BBGGoodsSeckillViewController_iPhone *goodsSeckillVC = [[BBGGoodsSeckillViewController_iPhone alloc]init];
        goodsSeckillVC.productId = model.productId;
        goodsSeckillVC.activityId = model.activityId;
        [self.navigationController pushViewController:goodsSeckillVC animated:YES];
    }else {
        [self buyOrAddInCart:[model.productType integerValue] store:[model.store integerValue] productId:model.productId callback:^(BOOL sucessful) {
            if (sucessful) {
                BBGSettlementViewController_iPhone *settlement = [[BBGSettlementViewController_iPhone alloc] init];
                settlement.buyType = BBGBuyTypeDirect;
                [weakSelf.navigationController pushViewController:settlement animated:YES];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.PhoneSeckill = nil;
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
