//
//  BBGShoppingCarViewController_iPhone.m
//  YHInternational
//
//  Created by yangjie on 15/5/11.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGShoppingCartViewController_iPhone.h"
#import "BBGProductsCart.h"
#import "BBGShoppingCartHeaderView.h"
#import "BBGShoppingCartFooterViewCell.h"
#import "BBGShoppingCartBottomView.h"
#import "BBGIndexPathButton.h"
#import "BBGIndexPathTextField.h"
#import "BBGSettlementViewController_iPhone.h"
#import "BBGNavigationController.h"
#import "BBGGoodsDetailViewController_iPhone.h"
#import "BBGSpecialWebViewController_iPhone.h"

@interface BBGShoppingCartViewController_iPhone ()<UITableViewDataSource,UITableViewDelegate,PullDelegate,BBGShoppingCartBottomViewDelegate,BBGShoppingCartHeaderViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) BBGPullTable *shoppingCartTableView;
@property (nonatomic,strong) BBGShoppingCartBottomView *bottomView;

@property (nonatomic, strong) NSString *updateProductId;

@end

@implementation BBGShoppingCartViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:RGB_COLOR(240, 239, 237)];
    //self.isMainViewController = YES;
    //self.navigationController.navigationBar.translucent = NO;
    //self.tabBarController.tabBar.translucent = NO;
//    self.title = @"购物车";
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"购物车" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    
    
    [self createRightBarButtonItemWithTarget:self action:@selector(shoppingCartOnlineCustomerService) title:@"联系客服" titleColor:UICOLOR_FONT_IMPORTANT_RED];
    
    [self createView];
    [self createBottomView];
    
    //取消拆单规则说明
    //[self createTableFooterView];
    //[self.shoppingCartTableView.tableFooterView setHidden:YES];
    
    [[BBGCartManager sharedInstance] updateCartData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestShoppingCard];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
#pragma mark ------在线客服
- (void)shoppingCartOnlineCustomerService
{
    NSMutableArray *productIdArray = [NSMutableArray array];
    for (NSInteger i = 0 ; i < self.productsCart.groups.count; i++) {
        
        BBGProductsCartGroup *productsCartGroup = self.productsCart.groups[i];
        for (NSInteger j = 0 ; j < productsCartGroup.products.count; j++) {
            BBGCartProduct *product = productsCartGroup.products[j];
            if (product.selected == 1) {
                [productIdArray addObject:product.productId];
            }
        }
        
        for (NSInteger k = 0 ; k < productsCartGroup.giftsList.count; k++) {
            BBGCartProduct *gift = productsCartGroup.giftsList[k];
            if (gift.selected == 1) {
                [productIdArray addObject:gift.productId];
            }
        }
    }
    
    
    if (![BBGLaunchManager sharedInstance].isOpenContactURL) {
        [BBGTools callPhone:@"400-888-8881" alertTitle:@"当前在线客服系统暂不可用，请电话联系客服。"];
    }else{
        [self connectServer];
    }
    

}
- (void)reloadView{
    if ([self.productsCart.groups COUNT] == 0) {
        [self.bottomView setHidden:YES];
        //[self.shoppingCartTableView.tableFooterView setHidden:YES];
        
        [self showDefaultViewWithStampImage:[UIImage imageNamed:@"shoppingCartNull"] tips:@"还没有添加商品..." target:nil actionTitle:nil action:nil WithResponseResult:BBGResponseNotData];
    }else{
        [self.bottomView setHidden:NO];
        //[self.shoppingCartTableView.tableFooterView setHidden:NO];
        [self dismissDefaultView];
    }
    [self.bottomView reloadViewWithCartGroup:self.productsCart];
    [self.shoppingCartTableView reloadData];
}

- (void)requestShoppingCard{
    __weak BBGShoppingCartViewController_iPhone *weakSelf = self;
    [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        [weakSelf.shoppingCartTableView stopAnimation];
        [weakSelf dismissDefaultView];
        
        if (sucessful) {
            [weakSelf reloadView];
        }else{
            [weakSelf showDefaultViewWithStampImage:nil tips:@"您的网络不给力，请检查下您的网络设置" target:weakSelf.shoppingCartTableView actionTitle:@"重新加载" action:@selector(triggerPullToRefresh)
                                 WithResponseResult:BBGResponseNetError offset:CGPointZero onView:weakSelf.view];
        }
    }];
}

- (void)createView{
    CGRect rect= self.view.bounds;
    rect.size.height = rect.size.height - 60;
    _shoppingCartTableView = [[BBGPullTable alloc] initWithFrame:rect style:UITableViewStylePlain];
    _shoppingCartTableView.openDeleteCell = YES;
    [_shoppingCartTableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    _shoppingCartTableView.dataSource = self;
    _shoppingCartTableView.delegate = self;
    _shoppingCartTableView.notOpenSticky = NO;
    _shoppingCartTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _shoppingCartTableView.tableHeaderView= [[UIView alloc] init];
    
    [_shoppingCartTableView setBackgroundColor:RGB_COLOR(240, 239, 237)];
    [self.view addSubview:_shoppingCartTableView];
    
    __weak BBGShoppingCartViewController_iPhone *weakSelf = self;
    [_shoppingCartTableView refreshData:^(id data) {
        [weakSelf requestShoppingCard];
    }];
}

- (void)createTableFooterView{
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 80)];
    [tableFooterView setBackgroundColor:RGB_COLOR(240, 239, 237)];
    
    UILabel *titleLabelOne = [UILabel new];
    [titleLabelOne setFont:APP_FONT(12)];
    [titleLabelOne setTextColor:UICOLOR_FONT_GENERAL_GRAYLIGHT];
    [titleLabelOne setText:@"全球购商品涉及关税征收 为了降低你的购买成本"];
    [tableFooterView addSubview:titleLabelOne];
    
    UILabel *titleLabelTwo = [UILabel new];
    [titleLabelTwo setFont:APP_FONT(12)];
    [titleLabelTwo setTextColor:UICOLOR_FONT_GENERAL_GRAYLIGHT];
    [titleLabelTwo setText:@"云猴全球购将为你智能拆单以减免部分商品的关税"];
    [tableFooterView addSubview:titleLabelTwo];
    
    UIButton *ruleBtn = [UIButton new];
    [ruleBtn setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal];
    [ruleBtn setTitle:@"查看拆单规则" forState:UIControlStateNormal];
    [ruleBtn.titleLabel setFont:APP_FONT(12)];
    [ruleBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [tableFooterView addSubview:ruleBtn];
    [ruleBtn addTarget:self action:@selector(ruleBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [titleLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@10);
        make.centerX.mas_equalTo(tableFooterView);
    }];
    [titleLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabelOne).offset(20);
        make.centerX.mas_equalTo(tableFooterView);
    }];
    [ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabelTwo).offset(10);
        make.centerX.mas_equalTo(tableFooterView);
    }];
    
    _shoppingCartTableView.tableFooterView = tableFooterView;
}

- (void)createBottomView{
    _bottomView = [[BBGShoppingCartBottomView alloc] initWithFrame:CGRectMake(0, IPHONE_HEIGHT-60, IPHONE_WIDTH, 60)];
    [_bottomView setBackgroundColor:[UIColor whiteColor]];
    _bottomView.delegate = self;
    [_bottomView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [self.view addSubview:_bottomView];
    [_bottomView setHidden:YES];
}

- (void)ruleBtnPressed:(UIButton*)btn{
    BBGSpecialWebViewController_iPhone *webViewController = [[BBGSpecialWebViewController_iPhone alloc] initWithURL:[NSURL URLWithString:@"http://112.124.102.135/AppTest/app/g/g.html"]];
    webViewController.title = @"拆单规则";
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger section = [self.productsCart.groups COUNT];
    return section;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(section)];
    NSInteger row = [productsCartGroup.products COUNT];
    return row+2+productsCartGroup.giftsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float rowHeigh;
    BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(indexPath.section)];
    
    NSInteger row = indexPath.row;
    if (row == 0) {
        rowHeigh = 40;
    }else if (row == [productsCartGroup.products COUNT]+[productsCartGroup.giftsList COUNT]+1){
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        // 要为cell的分割线加上额外的1pt高度。因为分隔线是被加在cell底边和contentView底边之间的。
        //height += 1.0f;

        rowHeigh = height;
    }else{
        rowHeigh = 100;
        
    }
    return rowHeigh;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    BOOL canEdit = NO;
    
    BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(indexPath.section)];
    
    if (row == 0) {
        canEdit = NO;
    }else if (row == [productsCartGroup.products COUNT]+1){
        canEdit = NO;
    }else{
        canEdit = YES;
    }
    return canEdit;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(indexPath.section)];
        if (row != 0 && row <= [productsCartGroup.products COUNT]) {
            row -= 1;
            BBGCartProduct *productModel = [productsCartGroup.products ARRAY_OBJ_AT(row)];
            [self delProdcutWithProductID:productModel];
        }
    }
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    
    BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(indexPath.section)];
    NSInteger row = indexPath.row;
//    此处分4种情况，头部店铺信息，中间商品信息和赠品信息，底部结算信息
        if (row == 0) {
            cell = [self tableView:tableView shoppingCartHeaderView:indexPath.section];
        }else if (row == [productsCartGroup.products COUNT]+[productsCartGroup.giftsList COUNT]+1){
            cell = [self tableView:tableView shoppingCartFooterView:indexPath.section];
        }else if(0 < row && row <= [productsCartGroup.products COUNT]){
            cell = [self tableView:tableView productCellForRowAtIndexPath:indexPath];
        }else if([productsCartGroup.products COUNT] < row && row <= [productsCartGroup.products COUNT]+[productsCartGroup.giftsList COUNT]){
            cell =[self tableView:tableView giftsCellForRowAtIndexPath:indexPath];
        }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView shoppingCartHeaderView:(NSInteger)section{
    static NSString *cellIndex = @"ShoppingCarTableHeaderCellIndex";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndex];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndex];
        BBGShoppingCartHeaderView *headerView = [[BBGShoppingCartHeaderView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 40)];
        headerView.tag = 1000;
        headerView.delegate = self;
        [cell addSubview:headerView];
    }
    BBGProductsCartGroup *group = [self.productsCart.groups ARRAY_OBJ_AT(section)];
    
    BBGShoppingCartHeaderView *headerView = (BBGShoppingCartHeaderView*)[cell viewWithTag:1000];
    headerView.section = section;
    [headerView reloadViewWithModel:group];
    return cell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView shoppingCartFooterView:(NSInteger)section{
    BBGProductsCartGroup *group = [self.productsCart.groups ARRAY_OBJ_AT(section)];
    BBGShoppingCartFooterViewCell *cell = [[BBGShoppingCartFooterViewCell alloc] initWithModel:group];
    return cell;
}
/**
 * 赠品cell
 */
- (UITableViewCell*)tableView:(UITableView *)tableView giftsCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndex = @"ShoppingCarGiftTableCellIndex";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndex];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndex];
        [cell.contentView setBackgroundColor:RGB_COLOR(250, 248, 251)];
        
        BBGIndexPathButton *selectBtn = [BBGIndexPathButton new];
        [selectBtn setImage:[UIImage imageNamed:@"shoppingCartGift"] forState:UIControlStateNormal];
        [selectBtn setHidden:YES];
        [selectBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [cell.contentView addSubview:selectBtn];
        
        
        
        UIView *imgBgView = [UIView new];
        [imgBgView setBackgroundColor:[UIColor whiteColor]];
        [cell.contentView addSubview:imgBgView];
        
        UIImageView *prodcutImgView = [UIImageView new];
        prodcutImgView.tag = 20001;
        [prodcutImgView setContentMode:UIViewContentModeScaleAspectFit];
        [imgBgView addSubview:prodcutImgView];
        
        UIImageView *giftImgView = [UIImageView imageViewWithMyImage:@"shoppingCartGift"];
        [imgBgView addSubview:giftImgView];
        
        UILabel *productNameLabel = [UILabel new];
         productNameLabel.tag = 20002;
        [productNameLabel setNumberOfLines:1];
        [productNameLabel setFont:APP_FONT(14)];
        [cell.contentView addSubview:productNameLabel];
        
        UILabel *specLabel = [UILabel new];
        specLabel.tag = 20004;
        [specLabel setFont:APP_FONT(14)];
        [specLabel setTextColor:UICOLOR_FONT_WEAK_GRAYLIGHT];
        [cell.contentView addSubview:specLabel];
        
        UILabel *bargainPriceLabe = [UILabel new];
        bargainPriceLabe.tag = 20005;
        [bargainPriceLabe setFont:APP_FONT_DEMI_LIGHT(14)];
        [bargainPriceLabe setTextColor:UICOLOR_FONT_IMPORTANT_RED];
        [cell.contentView addSubview:bargainPriceLabe];
        
        UILabel *lineLabel = [UILabel new];
        lineLabel.tag = 20006;
        [lineLabel setFont:APP_FONT(10)];
        [lineLabel setTextColor:UICOLOR_FONT_WEAK_GRAYLIGHT];
        [cell.contentView addSubview:lineLabel];

        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@0);
            make.centerY.mas_equalTo(cell.contentView);
        }];
        
        [imgBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(selectBtn.mas_right).offset(2);
            make.centerY.mas_equalTo(cell.contentView);
            make.size.mas_equalTo(CGSizeMake(80, 80));
        }];
        
        [prodcutImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(imgBgView);
        }];
        [giftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.top.mas_equalTo(5);
        }];
        
        [productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imgBgView.mas_top);
            make.left.mas_equalTo(imgBgView.mas_right).offset(10);
            make.right.mas_lessThanOrEqualTo(cell.contentView.mas_right);
        }];
        [productNameLabel setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
        [specLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(productNameLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(productNameLabel.mas_left);
            make.right.mas_lessThanOrEqualTo(cell.contentView.mas_right);
        }];
        [specLabel setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];

        [bargainPriceLabe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(productNameLabel.mas_left);
            make.bottom.mas_equalTo(imgBgView.mas_bottom).offset(-4);
        }];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(productNameLabel.mas_left);
            make.bottom.mas_equalTo(imgBgView.mas_bottom).offset(-20);
        }];

        
    }
   
    BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(indexPath.section)];
    NSInteger row = indexPath.row - productsCartGroup.products.count-1;
    BBGCartProduct *productModel = [productsCartGroup.giftsList ARRAY_OBJ_AT(row)];
    
    UIImageView *prodcutImgView = (UIImageView*)[cell viewWithTag:20001];
    UILabel *productNameLabel = (UILabel*)[cell viewWithTag:20002];
    UILabel *specLabel = (UILabel*)[cell viewWithTag:20004];
    UILabel *bargainPriceLabe = (UILabel*)[cell viewWithTag:20005];
    [prodcutImgView sd_setImageWithURL:[NSURL URLWithString:productModel.productImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType ==SDImageCacheTypeNone) {
            [prodcutImgView setFadeInWithDefaultTime];
        }
    }];

    UILabel *lineLabel = (UILabel*)[cell viewWithTag:20006];

    productNameLabel.text = productModel.productName;
    NSMutableString *specStr = [NSMutableString string];
    for (int i=0; i<[productModel.specList COUNT]; i++) {
        BBGProductSpecVo *specVoModel = [productModel.specList ARRAY_OBJ_AT(i)];
        if (i != [productModel.specList COUNT]-1) {
            [specStr appendFormat:@"%@,",specVoModel.value];
        }else{
            [specStr appendFormat:@"%@",specVoModel.value];
        }
        
    }
    [specLabel setText:specStr];
    
    NSString *bargainPriceStr = [NSString stringWithFormat:@"￥%0.2f",productModel.unCrossedPrice/100.0];
    [bargainPriceLabe setText:bargainPriceStr];
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%0.2f",productModel.crossedPrice/100.0]];
    [attrStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttribute:NSStrikethroughColorAttributeName value:UICOLOR_FONT_WEAK_GRAYLIGHT range:NSMakeRange(0, attrStr.length)];
    lineLabel.attributedText = attrStr;
    
    
    return cell;
}

/**
 * 商品cell
 */
#pragma mark ------商品cell
- (UITableViewCell*)tableView:(UITableView *)tableView productCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndex = @"ShoppingCarProductTableCellIndex";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndex];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndex];
        [cell.contentView setBackgroundColor:RGB_COLOR(250, 248, 251)];
        
        BBGIndexPathButton *selectBtn = [BBGIndexPathButton new];
        selectBtn.tag = 2000;
        [selectBtn addTarget:self action:@selector(selectBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [selectBtn setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
        [selectBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [cell.contentView addSubview:selectBtn];
        
        UIView *imgBgView = [UIView new];
        [imgBgView setBackgroundColor:[UIColor whiteColor]];
        [cell.contentView addSubview:imgBgView];
        
        UIImageView *prodcutImgView = [UIImageView new];
        [prodcutImgView setContentMode:UIViewContentModeScaleAspectFit];
        prodcutImgView.tag = 2001;
        [imgBgView addSubview:prodcutImgView];
        
        UILabel *tipLabel = [UILabel new];
        tipLabel.tag = 2002;
        [tipLabel setTextColor:[UIColor whiteColor]];
        [tipLabel setBackgroundColor:RGBA_COLOR(155, 155, 155, 215)];
        [tipLabel setFont:APP_FONT(12)];
        [tipLabel setTextAlignment:NSTextAlignmentCenter];
        [imgBgView addSubview:tipLabel];
        
        UIView *modelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 60)];
        modelView.tag = 1999;
        modelView.backgroundColor = [UIColor whiteColor];
        modelView.alpha = 0.7;
        [imgBgView addSubview:modelView];
        
        
        
        
        UILabel *productNameLabel = [UILabel new];
        productNameLabel.tag = 2003;
        [productNameLabel setNumberOfLines:1];
        [productNameLabel setFont:APP_FONT(14)];
        [cell.contentView addSubview:productNameLabel];
        
        UILabel *specLabel = [UILabel new];
        specLabel.tag = 2004;
        [specLabel setFont:APP_FONT(14)];
        [specLabel setTextColor:UICOLOR_FONT_WEAK_GRAYLIGHT];
        [cell.contentView addSubview:specLabel];
        //[specLabel setBackgroundColor:DEBUG_COLOR];
        
        UILabel *bargainPriceLabe = [UILabel new];
        bargainPriceLabe.tag = 2005;
        [bargainPriceLabe setFont:APP_FONT_DEMI_LIGHT(14)];
        [bargainPriceLabe setTextColor:UICOLOR_FONT_IMPORTANT_RED];
        [cell.contentView addSubview:bargainPriceLabe];
        
        
        UILabel *lineLabel = [UILabel new];
        lineLabel.tag = 2106;
        [lineLabel setFont:APP_FONT(12)];
        [lineLabel setTextColor:UICOLOR_FONT_WEAK_GRAYLIGHT];
        [cell.contentView addSubview:lineLabel];
        
        
        UILabel *tariffLabel = [UILabel new];
        tariffLabel.tag = 2006;
        [tariffLabel setFont:APP_FONT(13)];
        [tariffLabel setTextColor:UICOLOR_FONT_WEAK_GRAYLIGHT];
        [cell.contentView addSubview:tariffLabel];
        //[tariffLabel setBackgroundColor:DEBUG_COLOR];
        
        UIView *sliderBgView = [UIView new];
        sliderBgView.tag = 3001;
        [cell.contentView addSubview:sliderBgView];
        
        BBGIndexPathButton *sliderLeftBtn = [BBGIndexPathButton new];
        [sliderLeftBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 0)];
        sliderLeftBtn.tag = 2007;
        [sliderLeftBtn addTarget:self action:@selector(sliderLeftBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [sliderLeftBtn setImage:[UIImage imageNamed:@"sliderLeft"] forState:UIControlStateNormal];
        //[sliderLeftBtn setImage:[UIImage imageNamed:@"sliderLeftTap"] forState:UIControlStateHighlighted];
        [sliderBgView addSubview:sliderLeftBtn];
        
        UIImageView *sliderMiddelImgView = [UIImageView imageViewWithMyImage:@"sliderMiddle"];
        [sliderBgView addSubview:sliderMiddelImgView];
        
        BBGIndexPathButton *sliderRightBtn = [BBGIndexPathButton new];
        [sliderRightBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 10)];
        sliderRightBtn.tag = 2008;
        [sliderRightBtn addTarget:self action:@selector(sliderRightBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [sliderRightBtn setImage:[UIImage imageNamed:@"sliderRight"] forState:UIControlStateNormal];
        //[sliderRightBtn setImage:[UIImage imageNamed:@"sliderRightTap"] forState:UIControlStateHighlighted];
        [sliderBgView addSubview:sliderRightBtn];
        
        
        UIImageView *subtractImgView = [UIImageView imageViewWithMyImage:@"subtract"];
        subtractImgView.tag = 2009;
        [sliderLeftBtn addSubview:subtractImgView];
        
        UIImageView *deleteImgView = [UIImageView imageViewWithMyImage:@"delete"];
        deleteImgView.tag = 2010;
        [sliderLeftBtn addSubview:deleteImgView];
        
        //        数量可输入
        sliderMiddelImgView.userInteractionEnabled = YES;
        BBGIndexPathTextField *quantityTF = [BBGIndexPathTextField new];
        quantityTF.textAlignment = NSTextAlignmentCenter;
        quantityTF.tag = 2011;
        [quantityTF setFont:APP_FONT(12)];
        [sliderMiddelImgView addSubview:quantityTF];
        
        
        UIImageView *addImgView = [UIImageView imageViewWithMyImage:@"add"];
        [sliderRightBtn addSubview:addImgView];
        
        
        
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@0);
            make.centerY.mas_equalTo(cell.contentView);
        }];
        
        [imgBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(selectBtn.mas_right).offset(2);
            make.centerY.mas_equalTo(cell.contentView);
            make.size.mas_equalTo(CGSizeMake(80, 80));
        }];
        
        [prodcutImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(imgBgView);
        }];
        
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@0);
            make.right.mas_equalTo(@0);
            make.bottom.mas_equalTo(imgBgView.mas_bottom);
            make.height.mas_equalTo(@20);
        }];
        
        [productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imgBgView.mas_top);
            make.left.mas_equalTo(imgBgView.mas_right).offset(10);
            make.right.mas_equalTo(sliderRightBtn.mas_right).priorityLow();
        }];
        [productNameLabel setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
        
        [specLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(productNameLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(productNameLabel.mas_left);
            make.right.mas_lessThanOrEqualTo(cell.contentView.mas_right);
        }];
        [specLabel setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
        
        [tariffLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(specLabel);
            make.left.mas_equalTo(specLabel.mas_right).offset(10);
        }];
        
        [bargainPriceLabe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(productNameLabel.mas_left);
            make.bottom.mas_equalTo(imgBgView.mas_bottom);
        }];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(productNameLabel.mas_left);
            make.bottom.mas_equalTo(imgBgView.mas_bottom).offset(-20);
        }];
        
        
        [sliderBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(113, 47));
        }];
        
        [sliderLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(sliderBgView).offset(0);
            make.right.mas_equalTo(sliderMiddelImgView.mas_left).offset(0);
        }];
        
        [sliderMiddelImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(sliderRightBtn.mas_left).offset(0);
            make.top.mas_equalTo(sliderRightBtn).offset(10);
        }];
        
        [sliderRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(sliderLeftBtn);
            make.right.mas_equalTo(sliderBgView).offset(0);
        }];
        
        [subtractImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(sliderLeftBtn).offset(5);
            make.centerY.mas_equalTo(sliderLeftBtn);
        }];
        
        [deleteImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(sliderLeftBtn).offset(5);
            make.centerY.mas_equalTo(sliderLeftBtn);
        }];
        
        [quantityTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(sliderMiddelImgView);
            make.height.mas_equalTo(sliderMiddelImgView).offset(20);
            make.center.mas_equalTo(sliderMiddelImgView);
        }];
        
        [addImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(sliderRightBtn).offset(-5);
            make.centerY.mas_equalTo(sliderRightBtn);
        }];
    }
    NSInteger row = indexPath.row - 1;
    BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(indexPath.section)];
    BBGCartProduct *productModel = [productsCartGroup.products ARRAY_OBJ_AT(row)];
    
    BBGIndexPathButton *selectBtn = (BBGIndexPathButton*)[cell viewWithTag:2000];
    UIImageView *prodcutImgView = (UIImageView*)[cell viewWithTag:2001];
    UILabel *tipLabel = (UILabel*)[cell viewWithTag:2002];
    UILabel *productNameLabel = (UILabel*)[cell viewWithTag:2003];
    UILabel *specLabel = (UILabel*)[cell viewWithTag:2004];
    UILabel *bargainPriceLabe = (UILabel*)[cell viewWithTag:2005];
    UILabel *tariffLabel = (UILabel*)[cell viewWithTag:2006];
    UILabel *lineLabel = (UILabel*)[cell viewWithTag:2106];
    
    UIView *sliderBgView = (UIView*)[cell viewWithTag:3001];
    BBGIndexPathButton *sliderLeftBtn = (BBGIndexPathButton*)[cell viewWithTag:2007];
    BBGIndexPathButton *sliderRightBtn = (BBGIndexPathButton*)[cell viewWithTag:2008];
    UIImageView *subtractImgView = (UIImageView*)[cell viewWithTag:2009];
    UIImageView *deleteImgView = (UIImageView*)[cell viewWithTag:2010];
    BBGIndexPathTextField *quantityTF  = (BBGIndexPathTextField *)[cell viewWithTag:2011];
    quantityTF.indexPath = indexPath;
    quantityTF.textAlignment = NSTextAlignmentCenter;
    quantityTF.keyboardType = UIKeyboardTypeNumberPad;
    quantityTF.delegate = self;
    UIView *mmodelView =(UIView*)[cell viewWithTag:1999];
    
    sliderLeftBtn.indexPath = indexPath;
    sliderRightBtn.indexPath = indexPath;
    
    selectBtn.indexPath = indexPath;
    if (productModel.selected == 1) {
        [selectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    }else if (productModel.selected == 2){
        [selectBtn setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
    }else{
        [selectBtn setImage:[UIImage imageNamed:@"shoppingIconStop"] forState:UIControlStateNormal];
    }
    [prodcutImgView sd_setImageWithURL:[NSURL URLWithString:productModel.productImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType ==SDImageCacheTypeNone) {
            [prodcutImgView setFadeInWithDefaultTime];
        }
    }];

    
    
    
    
    if (productModel.productStatus == 100) {
        //正常销售
        [tipLabel setHidden:YES];
        //mmodelView.hidden  = YES;
        [productNameLabel setTextColor:[UIColor blackColor]];
        [bargainPriceLabe setTextColor:UICOLOR_FONT_IMPORTANT_RED];
    }else{
        [tipLabel setHidden:NO];
        [tipLabel setText:productModel.statusTip];
        [productNameLabel setTextColor:UIColorFromHexadecimalRGB(0x999999)];
        [bargainPriceLabe setTextColor:UIColorFromHexadecimalRGB(0x999999)];
        //mmodelView.hidden  = NO;
    }
    
    //小于100不可销售，隐藏操作按钮
    if (productModel.productStatus < 100) {
        sliderBgView.hidden = YES;
        mmodelView.hidden  = NO;
    }else{
        sliderBgView.hidden = NO;
        mmodelView.hidden  = YES;
    }
    
    [productNameLabel setText:productModel.productName];
    
    NSString *bargainPriceStr = [NSString stringWithFormat:@"￥%0.2f",productModel.unCrossedPrice/100.0];
    //NSString *tariffStr = [NSString stringWithFormat:@"关税￥%0.2f",productModel.tariff/100.0];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%0.2f",productModel.crossedPrice/100.0]];
    
    if (productModel.crossedPrice) {
        lineLabel.hidden = NO;
    } else {
        lineLabel.hidden = YES;
    }
    
    [attrStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttribute:NSStrikethroughColorAttributeName value:UICOLOR_FONT_WEAK_GRAYLIGHT range:NSMakeRange(0, attrStr.length)];
    lineLabel.attributedText = attrStr;
    
    NSMutableString *specStr = [NSMutableString string];
    for (int i=0; i<[productModel.specList COUNT]; i++) {
        BBGProductSpecVo *specVoModel = [productModel.specList ARRAY_OBJ_AT(i)];
        if (i != [productModel.specList COUNT]-1) {
            [specStr appendFormat:@"%@,",specVoModel.value];
        }else{
            [specStr appendFormat:@"%@",specVoModel.value];
        }
        
    }
    
    [specLabel setText:specStr];
    [bargainPriceLabe setText:bargainPriceStr];
    //    [tariffLabel setText:tariffStr];
    [tariffLabel setText:@""];
    
    [tariffLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(specLabel);
        if (![BBGTools checkStringIsBlank:specStr]) {
            make.left.mas_equalTo(specLabel.mas_right).offset(10);
        }else{
            make.left.mas_equalTo(specLabel.mas_right).offset(0);
        }
    }];
    
    [quantityTF setText:[NSString stringWithFormat:@"%ld",(long)productModel.quantity]];
    
    if (productModel.quantity == 1) {
        [deleteImgView setHidden:NO];
        [subtractImgView setHidden:YES];
    }else{
        [deleteImgView setHidden:YES];
        [subtractImgView setHidden:NO];
    }
    
    if (productModel.selected != 1 && productModel.selected != 2) {
        [deleteImgView setHidden:NO];
        [subtractImgView setHidden:YES];
    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(indexPath.section)];
    if (row != 0 && row <= [productsCartGroup.products COUNT]) {
        row -= 1;
        BBGCartProduct *productModel = [productsCartGroup.products ARRAY_OBJ_AT(row)];
        
        BBGGoodsDetailViewController_iPhone *goodsDetail = [[BBGGoodsDetailViewController_iPhone alloc] init];
        goodsDetail.productId = productModel.productId;
        [self.navigationController pushViewController:goodsDetail animated:YES];
    }else if (row >=[productsCartGroup.products COUNT] &&row <= [productsCartGroup.products COUNT]+[productsCartGroup.giftsList count]){
        row = row - [productsCartGroup.products COUNT] - 1;
        BBGCartProduct *productModel = [productsCartGroup.giftsList ARRAY_OBJ_AT(row)];
        
        BBGGoodsDetailViewController_iPhone *goodsDetail = [[BBGGoodsDetailViewController_iPhone alloc] init];
        goodsDetail.productId = productModel.productId;
        [self.navigationController pushViewController:goodsDetail animated:YES];
    }
    
}

- (void)selectBtnPressed:(BBGIndexPathButton*)btn{
    NSInteger row = btn.indexPath.row - 1;
    BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(btn.indexPath.section)];
    BBGCartProduct *productModel = [productsCartGroup.products ARRAY_OBJ_AT(row)];
    
    if (productModel.selected != 3) {
        NSMutableArray *selectedIds = [self allProductSelectedIds];
        if (productModel.selected == 1) {
            [selectedIds removeObject:productModel.productId];
        }else{
            [selectedIds ARRAY_ADD_OBJ(productModel.productId)];
        }
        
        [self checkProductWithProductArray:selectedIds];
    }else{
        //[[BBGLoadingTips sharedInstance] showTips:@"不可选择"];
    }
    
    
}
- (BOOL)textFieldShouldEndEditing:(BBGIndexPathTextField *)textField
{
    NSInteger row = textField.indexPath.row - 1;
    BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(textField.indexPath.section)];
    BBGCartProduct *productModel = [productsCartGroup.products ARRAY_OBJ_AT(row)];
    __weak BBGShoppingCartViewController_iPhone *weakSelf = self;
    NSInteger productCount = [textField.text integerValue];
    
    if (productCount <= 0) {
        //至少购买一件商品
        [[BBGLoadingTips sharedInstance] showTips:@"单件商品数量不能少于1件"];
        self.updateCartRequest.productId = productModel.productId;
        self.updateCartRequest.quantity = 1;
        [[BBGLoadingTips sharedInstance] showLoading:@""];
        [self shoppingCartUpdate:^(BOOL sucessful, BBGResponse *response) {
            [[BBGLoadingTips sharedInstance] hideTips];
            if (sucessful) {
                [weakSelf reloadView];
            }
        }];

        return YES;
    } else if(productCount > productModel.limit){
        //超出购买限制
        [[BBGLoadingTips sharedInstance] showTips:@"超出购买限制"];
        self.updateCartRequest.productId = productModel.productId;
        self.updateCartRequest.quantity = productModel.limit;
        [[BBGLoadingTips sharedInstance] showLoading:@""];
        [self shoppingCartUpdate:^(BOOL sucessful, BBGResponse *response) {
            [[BBGLoadingTips sharedInstance] hideTips];
            if (sucessful) {
                [weakSelf reloadView];
            }
        }];

        return YES;
    }else if(productCount == productModel.quantity){
      return YES;
    }else{
        self.updateCartRequest.productId = productModel.productId;
        self.updateCartRequest.quantity = productCount;
        [[BBGLoadingTips sharedInstance] showLoading:@""];
        [self shoppingCartUpdate:^(BOOL sucessful, BBGResponse *response) {
            [[BBGLoadingTips sharedInstance] hideTips];
            if (sucessful) {
                [weakSelf reloadView];
            }
        }];
        return YES;
    }


}

/**
 *  商品减
 *
 *  @param btn <#btn description#>
 */
- (void)sliderLeftBtnPressed:(BBGIndexPathButton*)btn{
    NSInteger row = btn.indexPath.row - 1;
    BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(btn.indexPath.section)];
    BBGCartProduct *productModel = [productsCartGroup.products ARRAY_OBJ_AT(row)];
    NSInteger productCount = productModel.quantity - 1;
    
    
    
    if ([productModel.productId isEqualToString:_updateProductId] || _updateProductId == nil) {
        _updateProductId = productModel.productId;
        
        if ((productCount == 0) || (productModel.selected!=1 && productModel.selected!=2)) {
            //个数为0或不可选商品做删除操作
            _updateProductId = nil;
            [self delProdcutWithProductID:productModel];
        }else{
            //减商品
            UITableViewCell *cell = [BBGTools tableViewCell:btn];
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
            [self performSelector:@selector(afterDelaySubtractProductWithIndexPath:) withObject:btn afterDelay:0.25];
            
            UITextField *quantityTF = (UITextField*)[cell viewWithTag:2011];
            if ([quantityTF isKindOfClass:[UITextField class]]) {
                NSInteger count = [quantityTF.text integerValue];
                if (count == 1) {
                    return;
                }
                count--;
                [quantityTF setText:NSStringFromInt(count)];
            }
        }
    }
}

- (void)afterDelaySubtractProductWithIndexPath:(BBGIndexPathButton*)btn{
    NSInteger row = btn.indexPath.row - 1;
    UITableViewCell *cell = [BBGTools tableViewCell:btn];
    UITextField *quantityTF = (UITextField*)[cell viewWithTag:2011];
    if ([quantityTF isKindOfClass:[UITextField class]]) {
        NSInteger count = [quantityTF.text integerValue];
        BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(btn.indexPath.section)];
        BBGCartProduct *productModel = [productsCartGroup.products ARRAY_OBJ_AT(row)];
        
        __weak BBGShoppingCartViewController_iPhone *weakSelf = self;
        NSInteger productCount = count;
        
        if ((productCount == 0) || (productModel.selected!=1 && productModel.selected!=2)) {
            //商品删除
            [self delProdcutWithProductID:productModel];
        }else{
            //商品减
            self.updateCartRequest.productId = productModel.productId;
            self.updateCartRequest.quantity = productCount;
            [[BBGLoadingTips sharedInstance] showLoading:@""];
            [self shoppingCartUpdate:^(BOOL sucessful, BBGResponse *response) {
                _updateProductId = nil;
                [[BBGLoadingTips sharedInstance] hideTips];
                if (sucessful) {
                    [weakSelf reloadView];
                }else{
                    [weakSelf.shoppingCartTableView reloadData];
                }
            }];
        }
    }
}

/**
 *  商品加
 *
 *  @param btn <#btn description#>
 */
- (void)sliderRightBtnPressed:(BBGIndexPathButton*)btn{
    NSInteger row = btn.indexPath.row - 1;
    BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(btn.indexPath.section)];
    BBGCartProduct *productModel = [productsCartGroup.products ARRAY_OBJ_AT(row)];
    
    if ([productModel.productId isEqualToString:_updateProductId] || _updateProductId == nil) {
        _updateProductId = productModel.productId;
        
        UITableViewCell *cell = [BBGTools tableViewCell:btn];
        UITextField *quantityTF = (UITextField*)[cell viewWithTag:2011];
        
        if ([quantityTF isKindOfClass:[UITextField class]]) {
            NSInteger count = [quantityTF.text integerValue];
            if (count >= productModel.limit) {
                //超出购买限制
                _updateProductId = nil;
                [[BBGLoadingTips sharedInstance] showTips:@"超出购买限制"];
                return;
            }
        }
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(afterDelayAddProductWithIndexPath:) withObject:btn afterDelay:0.25];
        
        if ([quantityTF isKindOfClass:[UITextField class]]) {
            NSInteger count = [quantityTF.text integerValue];
            count++;
            [quantityTF setText:NSStringFromInt(count)];
        }
    }
    
    
    
//    NSInteger row = btn.indexPath.row - 1;
//    BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(btn.indexPath.section)];
//    BBGCartProduct *productModel = [productsCartGroup.products ARRAY_OBJ_AT(row)];
//
//    __weak BBGShoppingCartViewController_iPhone *weakSelf = self;
//    if (productModel.quantity >= productModel.limit) {
//        //超出购买限制
//        [[BBGLoadingTips sharedInstance] showTips:@"超出购买限制"];
//    }else{
//        self.updateCartRequest.productId = productModel.productId;
//        self.updateCartRequest.quantity = productModel.quantity+1;
//        [[BBGLoadingTips sharedInstance] showLoading:@""];
//        [self shoppingCartUpdate:^(BOOL sucessful, BBGResponse *response) {
//            [[BBGLoadingTips sharedInstance] hideTips];
//            if (sucessful) {
//                [weakSelf reloadView];
//            }
//        }];
//    }
}

- (void)afterDelayAddProductWithIndexPath:(BBGIndexPathButton*)btn{
    NSInteger row = btn.indexPath.row - 1;
    
    UITableViewCell *cell = [BBGTools tableViewCell:btn];
    UITextField *quantityTF = (UITextField*)[cell viewWithTag:2011];
    
    if ([quantityTF isKindOfClass:[UITextField class]]) {
        NSInteger count = [quantityTF.text integerValue];
        
        BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(btn.indexPath.section)];
        BBGCartProduct *productModel = [productsCartGroup.products ARRAY_OBJ_AT(row)];
        
        __weak BBGShoppingCartViewController_iPhone *weakSelf = self;
        
        self.updateCartRequest.productId = productModel.productId;
        self.updateCartRequest.quantity = count;
        [[BBGLoadingTips sharedInstance] showLoading:@""];
        [self shoppingCartUpdate:^(BOOL sucessful, BBGResponse *response) {
            _updateProductId = nil;
            [[BBGLoadingTips sharedInstance] hideTips];
            if (sucessful) {
                [weakSelf reloadView];
            }else{
                [weakSelf.shoppingCartTableView reloadData];
            }
        }];
    }
}


/**
 *  删除商品请求
 *
 *  @param productID 产品ID
 */
- (void)delProdcutWithProductID:(BBGCartProduct*)cartProduct{
    WS(ws)
    [BBGAlertView showWithTitle:@"" message:@"确定删除商品？" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            self.removeCartRequest.productIds = [NSArray arrayWithObject:cartProduct.productId];
            [[BBGLoadingTips sharedInstance] showLoading:@""];
            [self shoppingCartRemove:^(BOOL sucessful, BBGResponse *response) {
                _updateProductId = nil;
                [[BBGLoadingTips sharedInstance] hideTips];
                if (sucessful) {
                    [ws reloadView];
                }
            }];
        }
    } buttonTitles:@"确定", nil];
}


#pragma mark BBGShoppingCartHeaderViewDelegate
- (void)selectedSection:(NSInteger)section{
    BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(section)];
    if (productsCartGroup.selected != 3) {
        NSMutableArray *allProductIdsArray = [self allProductSelectedIds];
        NSArray *array = [self productIdsWithSection:section];
        if (productsCartGroup.selected == 1) {
            [allProductIdsArray removeObjectsInArray:array];
        }else{
            [allProductIdsArray ARRAY_ADD_OBJS_FROM_ARRAY(array)];
        }
        [self checkProductWithProductArray:allProductIdsArray];
    }else{
        //[[BBGLoadingTips sharedInstance] showTips:@"不可选择"];
    }
   
}


#pragma mark BBGShoppingCartBottomViewDelegate
- (void)shoppingCartSelectButtonClick:(BBGShoppingCartSelectType)type{
    if (self.productsCart.selected != 3) {
        if (type == BBGShoppingCartAllSelected) {
            [self checkProductWithProductArray:[self allProductIds]];
        }else if (type == BBGShoppingCartCancelSelected){
            [self checkProductWithProductArray:[NSArray array]];
        }
    }else{
        //[[BBGLoadingTips sharedInstance] showTips:@"不可选择"];
    }
    
}

- (void)shoppingCartEditButtonClick:(BBGShoppingCartSelectType)type
{
    if (self.productsCart.selected != 3) {
        if (type == BBGShoppingCartAllSelected) {
            [self checkProductWithProductArray:[self allProductIds]];
        }else if (type == BBGShoppingCartSomeDelete){
            [self deleteAllProductWithProductArray:[self allDeleteProductIds]];
        }
    }
}


- (void)tradeCheckout{
    if ([[self allProductSelectedIds] COUNT] > 0) {
        BBGSettlementViewController_iPhone *settlement = [[BBGSettlementViewController_iPhone alloc] init];
        settlement.buyType = BBGBuyTypeNormal;
        [self.navigationController pushViewController:settlement animated:YES];
    }else{
        [[BBGLoadingTips sharedInstance] showTips:@"至少选择一件商品"];
    }
}
- (void)deleteAllProductWithProductArray:(NSArray *)array{
     
    WS(ws)
    [BBGAlertView showWithTitle:@"" message:@"确定删除？" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            self.removeCartRequest.productIds = array;
            [[BBGLoadingTips sharedInstance] showLoading:@""];
            [self shoppingCartRemove:^(BOOL sucessful, BBGResponse *response) {
                [[BBGLoadingTips sharedInstance] hideTips];
                if (sucessful) {
                    [ws reloadView];
                }
            }];
        }
    } buttonTitles:@"确定", nil];
    
}
/**
 *  删除所有商品
 *
 *  @return NSArray
 */
- (NSArray*)allDeleteProductIds{
    NSMutableArray *productIdsArray = [NSMutableArray array];
    
    for (int i=0; i<[self.productsCart.groups COUNT]; i++) {
        BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(i)];
        for (int j=0; j<[productsCartGroup.products COUNT]; j++) {
            BBGCartProduct *productModel = [productsCartGroup.products ARRAY_OBJ_AT(j)];
            if (productModel.selected == 1) {
                NSString *productId = productModel.productId;
                [productIdsArray ARRAY_ADD_OBJ(productId)];
            }
        }
    }
    return productIdsArray;
}

/**
 *  选择商品
 *
 *  @param array 商品ID数组
 */
- (void)checkProductWithProductArray:(NSArray*)array{
    __weak BBGShoppingCartViewController_iPhone *weakSelf = self;
    self.checkCartRequest.productIds = array;
    [[BBGLoadingTips sharedInstance] showLoading:@""];
    [self shoppingCartChechk:^(BOOL sucessful, BBGResponse *response) {
        [[BBGLoadingTips sharedInstance] hideTips];
        if (sucessful) {
           [weakSelf reloadView];
        }
    }];
}

/**
 *  获取一个店铺的所有产品ID
 *
 *  @param section <#section description#>
 *
 *  @return <#return value description#>
 */
- (NSArray*)productIdsWithSection:(NSInteger)section{
    NSMutableArray *productIdsArray = [NSMutableArray array];
    
    BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(section)];
    for (int i=0; i<[productsCartGroup.products COUNT]; i++) {
        BBGCartProduct *productModel = [productsCartGroup.products ARRAY_OBJ_AT(i)];
        if (productModel.selected != 3) {
            NSString *productId = productModel.productId;
            [productIdsArray ARRAY_ADD_OBJ(productId)];
        }
    }

    return productIdsArray;
}

/**
 *  所有店铺产品ID
 *
 *  @return <#return value description#>
 */
- (NSArray*)allProductIds{
    NSMutableArray *productIdsArray = [NSMutableArray array];
    
    for (int i=0; i<[self.productsCart.groups COUNT]; i++) {
        BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(i)];
        for (int j=0; j<[productsCartGroup.products COUNT]; j++) {
            BBGCartProduct *productModel = [productsCartGroup.products ARRAY_OBJ_AT(j)];
            if (productModel.selected != 3) {
                NSString *productId = productModel.productId;
                [productIdsArray ARRAY_ADD_OBJ(productId)];
            }
        }
    }
    return productIdsArray;
}

/**
 *  所有店铺购物车已选产品ID
 *
 *  @return <#return value description#>
 */
- (NSMutableArray*)allProductSelectedIds{
    NSMutableArray *productIdsArray = [NSMutableArray array];
    
    for (int i=0; i<[self.productsCart.groups COUNT]; i++) {
        BBGProductsCartGroup *productsCartGroup = [self.productsCart.groups ARRAY_OBJ_AT(i)];
        for (int j=0; j<[productsCartGroup.products COUNT]; j++) {
            BBGCartProduct *productModel = [productsCartGroup.products ARRAY_OBJ_AT(j)];
            if (productModel.selected != 3) {
                if (productModel.selected == 1) {
                    NSString *productId = productModel.productId;
                    [productIdsArray ARRAY_ADD_OBJ(productId)];
                }
            }
        }
    }
    return productIdsArray;
}

@end

