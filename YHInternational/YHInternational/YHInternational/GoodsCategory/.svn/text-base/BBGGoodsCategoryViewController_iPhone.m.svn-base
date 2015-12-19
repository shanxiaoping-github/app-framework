//
//  BBGGoodsCategoryViewController_iPhone.m
//  YHInternational
//
//  Created by Timmy Ouyang on 15/4/26.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsCategoryViewController_iPhone.h"
#import "BBGAttribute.h"
#import "BBGCategoryCell_iPhone.h"
#import "BBGSubCatCell_iPhone.h"
#import "BBGCategory.h"

@interface BBGGoodsCategoryViewController_iPhone ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *firstTableView;
@property (weak, nonatomic) IBOutlet UITableView *secondTableView;
@property (strong, nonatomic) BBGAttribute *selectionAttribute;
@property (strong, nonatomic) BBGCategory *oldSelectedCate;
@property (strong, nonatomic) NSMutableDictionary *allFilter;
@property (strong, nonatomic) NSMutableArray *brandFilter;
@property (assign, nonatomic) BOOL isShowSecondTable;
@property (assign, nonatomic) BOOL isHasStore;
@property (assign, nonatomic) BOOL isProprietary;
@property (strong, nonatomic) NSArray *leftBarButtonClearArray;
@property (strong, nonatomic) NSArray *leftBarButtonCancelArray;

@end

@implementation BBGGoodsCategoryViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //重置按钮
    UIBarButtonItem *leftBarButtonClearItem = [self createBarButtonItemWithTarget:self action:@selector(clearFilter) title:@"重置" titleColor:UICOLOR_FONT_GENERAL_GRAYLIGHT normalImage:nil highlightedImage:nil];
    //取消按钮
    UIBarButtonItem *leftBarButtonCancelItem = [self createBarButtonItemWithTarget:self action:@selector(clearFilter) title:nil titleColor:nil normalImage:[UIImage imageNamed:@"Cancel"] highlightedImage:nil];

    UIBarButtonItem *flexBarButtonItem = [self createFlexSpacerBarButtonItemWithTarget:self action:@selector(clearFilter) width:45.0];
    self.leftBarButtonClearArray = @[flexBarButtonItem,leftBarButtonClearItem];
    self.leftBarButtonCancelArray = @[flexBarButtonItem,leftBarButtonCancelItem];

    [self.navigationItem setLeftBarButtonItems:self.leftBarButtonClearArray];
    self.isMainViewController = YES;
    [self createRightBarButtonItemWithTarget:self action:@selector(doFilter) title:@"确定" titleColor:UICOLOR_FONT_IMPORTANT_RED];
    
    
    self.firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.firstTableView.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
    self.secondTableView.hidden = YES;

    self.isShowSecondTable = NO;
    self.isHasStore = NO;
    self.isProprietary = NO;

    _allFilter = [NSMutableDictionary dictionary];
    _brandFilter = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearFilter {

    if (self.isShowSecondTable) {
        [self secondTableViewWithAttribute:nil];
        
        //清除选中状态
        if ([self.selectionAttribute.attributeName isEqualToString:@"品牌"]) {
            for (BBGCategory *cate in self.brandFilter) {
                cate.isSelected = NO;
            }
            [self.brandFilter removeAllObjects];
        }
        
        id selectedCate = [self.allFilter objectForKey:self.selectionAttribute.attributeName];
        if ([selectedCate isKindOfClass:[BBGCategory class]]) {
            BBGCategory *selectedCat = (BBGCategory *)selectedCate;
            selectedCat.isSelected = NO;
        }
        [self.allFilter removeObjectForKey:self.selectionAttribute.attributeName];

    }else {
        [self.allFilter enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([obj isKindOfClass:[NSArray class]]) {
                NSArray *selectedArray = (NSArray *)obj;
                for (BBGCategory *cat in selectedArray) {
                    cat.isSelected = NO;
                }
            }else {
                BBGCategory *selecteCat = (BBGCategory *)obj;
                selecteCat.isSelected = NO;
            }
            
            if ([key isEqualToString:@"分类"]) {
                //检测到有分类信息，清除切换分类刷新的筛选信息的选中状态（服务器返回的选中状态）
                for (BBGAttribute *attribute in self.filterAttributes) {
                    if ([attribute.attributeName isEqualToString:@"分类"]) {
                        for (BBGCategory *cate in attribute.subAttributes) {
                            for (BBGCategory *childCate in cate.childrenCate) {
                                if ([childCate.catId isEqualToString:self.oldSelectedCate.catId]) {
                                    childCate.isSelected = NO;
                                    cate.isExpanded = NO;
                                    break;
                                }
                            }
                        }
                        break;
                    }
                }
            }
        }];
        
        
        //清除品牌多选数据
        [self.brandFilter removeAllObjects];
        //清除所有已选数据
        [self.allFilter removeAllObjects];
        
        self.isHasStore = NO;
        self.isProprietary = NO;
    }
    [self.firstTableView reloadData];
    [self.secondTableView reloadData];

}

- (void)doFilter {
    if (self.isShowSecondTable) {
        if (self.selectionAttribute.isMultiSelection) {
            if (self.brandFilter.count>0) {
                [self.allFilter setObject:self.brandFilter forKey:self.selectionAttribute.attributeName];
            }else {
                [self.allFilter removeObjectForKey:self.selectionAttribute.attributeName];
            }
        }
        
        //切换了分类信息，刷新筛选条件
        BBGCategory *catFilter = [self.allFilter objectForKey:@"分类"];
        if (![catFilter.catId isEqualToString:self.backCate]) {
            self.backCate = catFilter.catId;
            __weak BBGGoodsCategoryViewController_iPhone *weakSelf = self;
            if (catFilter) {
                [self updateData:^(BOOL sucessful, BBGResponse *response) {
                    BBGSearchFilterResponse *re = (BBGSearchFilterResponse *)response;
                    weakSelf.filterAttributes = re.allFilterAttributes;
                    
                    //刷新筛选条件后，清除其他的筛选结果，然后保留当前的“分类”筛选信息
                    [weakSelf.allFilter removeAllObjects];
                    [weakSelf.allFilter setObject:catFilter forKey:@"分类"];
                    
                    [weakSelf.brandFilter removeAllObjects];
                    [weakSelf.firstTableView reloadData];
                }];
            }
        }

        [self.firstTableView reloadData];
    }else {
    
        if (self.allFilter.count>0) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(categoryController:allFilters:hasStore:isProprietary:)]) {
                [self.delegate categoryController:self allFilters:self.allFilter hasStore:self.isHasStore isProprietary:self.isProprietary];
            }
            
        }else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(categoryController:allFilters:hasStore:isProprietary:)]) {
                [self.delegate categoryController:self allFilters:nil hasStore:self.isHasStore isProprietary:self.isProprietary];
            }
        }
    }
    
    [self secondTableViewWithAttribute:nil];
}

- (void)secondTableViewWithAttribute:(BBGAttribute *)attribute {
    
    if (self.isShowSecondTable) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.secondTableView.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        } completion:^(BOOL finished) {
            self.secondTableView.hidden = YES;
            [self.secondTableView reloadData];
        }];
        
        [self.navigationItem setLeftBarButtonItems:self.leftBarButtonClearArray];
        self.isShowSecondTable = NO;

    }else {
        if (attribute) {

            [self.navigationItem setLeftBarButtonItems:self.leftBarButtonCancelArray];

            self.secondTableView.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.secondTableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                self.secondTableView.hidden = NO;
            } completion:^(BOOL finished) {
                [self.secondTableView reloadData];
            }];
            self.isShowSecondTable = YES;
        }
    }
}
- (void)changeProprietaryStatus:(UISwitch *)sender {
    
    self.isProprietary = sender.on;
    [self.firstTableView reloadData];
}

- (void)changeStoreStatus:(UISwitch *)sender {

    self.isHasStore = sender.on;
    [self.firstTableView reloadData];
}

- (void)setFilterAttributes:(NSArray *)filterAttributes {

    if (_filterAttributes != filterAttributes) {
        _filterAttributes = filterAttributes;
        [self.firstTableView reloadData];
    }
}

#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView == self.firstTableView) {
        switch (section) {
            case 0:
                return 2;
                break;
            case 1:
                return self.filterAttributes.count;
                break;
                
            default:
                break;
        }
    }else {
        BBGCategory *cate = [self.selectionAttribute.subAttributes ARRAY_OBJ_AT(section)];
        if(cate.isExpanded) {
            return cate.childrenCate.count +1;
        }else {
            return 1;
        }
        return 0;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView==self.firstTableView) {
        return 2;
    }else {
        return self.selectionAttribute.subAttributes.count;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (tableView == self.firstTableView) {
        if (section == 1) {
            UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 11)];
            sectionView.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
            return sectionView;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.firstTableView) {
        if (indexPath.section==0) {
            return 42.0;
        }else {
            return [BBGCategoryCell_iPhone cellHeight];
        }
    }else {
        return [BBGSubCatCell_iPhone cellHeight];;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (tableView == self.firstTableView) {
        if (section == 0) {
            return 0;
        }else {
            return 11;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.firstTableView) {
        static NSString *cellIdentifier = @"cellIdentifier";
        BBGCategoryCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"BBGCategoryCell_iPhone" bundle:nil] forCellReuseIdentifier:cellIdentifier];
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGCategoryCell_iPhone" owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                cell.tag = 10001;
                cell.isProprietarySwitch.on = self.isProprietary;
                cell.titleLable.text = @"只显示自营";
                cell.isProprietarySwitch.hidden = NO;
                cell.isHaveGoodsSwitch.hidden = YES;
                cell.leftArrowImageView.hidden = YES;
                cell.filterResultsLbl.hidden = YES;
                cell.selectionStyle = UITableViewCellSelectionStyleNone ;
                [cell.isProprietarySwitch addTarget:self action:@selector(changeProprietaryStatus:) forControlEvents:UIControlEventValueChanged];
            } else {
                cell.tag = 10000;
                cell.isHaveGoodsSwitch.on = self.isHasStore;
                cell.titleLable.text = @"只显示有货";
                cell.isHaveGoodsSwitch.hidden = NO;
                cell.isProprietarySwitch.hidden = YES;
                cell.leftArrowImageView.hidden = YES;
                cell.filterResultsLbl.hidden = YES;
                cell.selectionStyle = UITableViewCellSelectionStyleNone ;
                [cell.isHaveGoodsSwitch addTarget:self action:@selector(changeStoreStatus:) forControlEvents:UIControlEventValueChanged];
            }

        }else {
            BBGAttribute *attribute = [self.filterAttributes ARRAY_OBJ_AT(indexPath.row)];
            
            cell.titleLable.text = attribute.attributeName;
            cell.isHaveGoodsSwitch.hidden = YES;
            cell.isProprietarySwitch.hidden = YES;
            cell.leftArrowImageView.hidden = NO;
            cell.filterResultsLbl.hidden = NO;
            
            if (self.allFilter.count>0) {
                id results = [self.allFilter objectForKey:attribute.attributeName];
                if (results) {
                    if ([results isKindOfClass:[NSArray class]]) {
                        //多选结果
                        NSArray *resultsArray = (NSArray *)results;
                        NSMutableArray *array = [NSMutableArray array];
                        for (BBGCategory *cat in resultsArray) {
                            [array addObject:cat.name];
                        }
                        NSString *resultString = [array componentsJoinedByString:@";"];
                        cell.filterResultsLbl.text = resultString;
                    }else {
                        //单选结果
                        BBGCategory *resultCat = (BBGCategory *)results;
                        cell.filterResultsLbl.text = resultCat.name;
                        if ([attribute.attributeName isEqualToString:@"价格"]) {
                            int minP = resultCat.minPrice/100;
                            int maxP = resultCat.maxPrice/100;
                            cell.filterResultsLbl.text = [NSString stringWithFormat:@"%d-%d",minP,maxP];
                        }
                    }
                }else {
                    cell.filterResultsLbl.text = @"";
                }
            }else {
                cell.filterResultsLbl.text = @"";
            }
        }
        return cell;
    }else {
        static NSString *secondCellIdentifier = @"secondCellIdentifier";
        BBGSubCatCell_iPhone *cell = [tableView dequeueReusableCellWithIdentifier:secondCellIdentifier ];
        CGPoint centre;
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"BBGSubCatCell_iPhone" bundle:nil] forCellReuseIdentifier:secondCellIdentifier];
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BBGSubCatCell_iPhone" owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            centre = cell.nameLbl.center;
        }
        BBGCategory *cat = [self.selectionAttribute.subAttributes ARRAY_OBJ_AT(indexPath.section)];
        if (cat.childrenCate.count>0) {
            if (indexPath.row == 0) {
                cell.moreArrowImg.hidden = NO;
                cell.selectImage.hidden = YES;
                cell.nameLbl.text = cat.name;
                [cell updateCellWith:cat index:indexPath];
            }else {
                BBGCategory *childCate = [cat.childrenCate ARRAY_OBJ_AT(indexPath.row-1)];
                cell.moreArrowImg.hidden = YES;
                cell.selectImage.hidden = !childCate.isSelected;
                cell.nameLbl.text = childCate.name;
                [cell updateCellWith:childCate index:indexPath];
            }
        }else {
            cell.moreArrowImg.hidden = YES;
            cell.selectImage.hidden = !cat.isSelected;
            cell.nameLbl.text = cat.name;
            if ([self.selectionAttribute.attributeName isEqualToString:@"价格"]) {
                int minP = cat.minPrice/100;
                int maxP = cat.maxPrice/100;
                cell.nameLbl.text = [NSString stringWithFormat:@"%d~%d",minP,maxP];
            }
            [cell updateCellWith:cat index:indexPath];
        }
        return cell;
    }
    return nil;
}

#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.firstTableView) {
        if (indexPath.section != 0) {
            BBGAttribute *attribute = [self.filterAttributes ARRAY_OBJ_AT(indexPath.row)];
            if (self.selectionAttribute != attribute) {
                self.selectionAttribute = attribute;
                self.secondTableView.tableFooterView = [UIView new];
                self.secondTableView.backgroundColor =UIColorFromHexadecimalRGB(0xf0efed) ;
                self.secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                self.secondTableView.allowsMultipleSelection = self.selectionAttribute.isMultiSelection;
                //切换了父分类，初始化选中条件,将self.oldSelectedCate置为nil，作为二级分类是否要遍历之前选中cat的开关
                self.oldSelectedCate = nil;
            }
            [self secondTableViewWithAttribute:self.selectionAttribute];
        }
    }else {
        
        BBGCategory *cat = [self.selectionAttribute.subAttributes ARRAY_OBJ_AT(indexPath.section)];
        //二级分类有子分类
        if (cat.childrenCate.count>0) {
            if (indexPath.row == 0) {
                //显示二级分类内容，提供展开折叠逻辑
                cat.isExpanded = !cat.isExpanded;
                [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            }else {
                //显示二级分类下的子分类内容
                BBGCategory *childCate = [cat.childrenCate ARRAY_OBJ_AT(indexPath.row-1)];
                //非多选情况，要注意之前选中的cat的选中状态
                if (!self.selectionAttribute.isMultiSelection) {
                    //切换了父分类，遍历出该分来下之前选中的cat（在点击firstTableView时添加nil开关条件）
                    if (!self.oldSelectedCate) {
                        bool flag=true;
                        for (int i=0;i<self.selectionAttribute.subAttributes.count&&flag;i++) {
                            BBGCategory *category=[self.selectionAttribute.subAttributes objectAtIndex:i];
                            //再次遍历二级分类下嵌套的一层子分类
                            for (BBGCategory *child in category.childrenCate) {
                                if (child.isSelected) {
                                    self.oldSelectedCate = child;
                                    flag=false;
                                    break;
                                }
                            }
                        }
                    }
                    
                    childCate.isSelected = !childCate.isSelected;
                    //判断是否重复点击，若不是，则直接添加
                    if (self.oldSelectedCate != childCate) {
                        self.oldSelectedCate.isSelected = NO;
                        self.oldSelectedCate = childCate;
                        if (childCate.isSelected) {
                            [self.allFilter setObject:childCate forKey:_selectionAttribute.attributeName];
                        }else {
                            [self.allFilter removeObjectForKey:_selectionAttribute.attributeName];
                        }
                    }else {
                        //重复点击
                        if (childCate.isSelected) {
                            [self.allFilter setObject:childCate forKey:_selectionAttribute.attributeName];
                        }else {
                            [self.allFilter removeObjectForKey:_selectionAttribute.attributeName];
                        }
                    }
                }else {
                    //多选情况，判断是否选择
                    childCate.isSelected = !childCate.isSelected;
                    if (childCate.isSelected) {
                        [self.brandFilter addObject:childCate];
                    }else {
                        [self.brandFilter removeObject:cat];
                    }
                }
                [tableView reloadData];
            }
        }else {
            //无子分类情况，非多选情况
            if (!self.selectionAttribute.isMultiSelection) {
                //切换了父分类，遍历出该分来下之前选中的cat（在点击firstTableView时添加nil开关条件）
                if (!self.oldSelectedCate) {
                    for (BBGCategory *category in self.selectionAttribute.subAttributes) {
                        if (category.isSelected) {
                            self.oldSelectedCate = category;
                            break;
                        }
                    }
                }
                //无子分类情况
                cat.isSelected = !cat.isSelected;

                //是否重复点击
                if (self.oldSelectedCate != cat) {
                    self.oldSelectedCate.isSelected = NO;
                    self.oldSelectedCate = cat;
                    if (cat.isSelected) {
                        [self.allFilter setObject:cat forKey:_selectionAttribute.attributeName];
                    }else {
                        [self.allFilter removeObjectForKey:_selectionAttribute.attributeName];
                    }
                }else {
                    if (cat.isSelected) {
                        [self.allFilter setObject:cat forKey:_selectionAttribute.attributeName];
                    }else {
                        [self.allFilter removeObjectForKey:_selectionAttribute.attributeName];
                    }
                }
            }else {
                //多选情况，判断是否选择
                cat.isSelected = !cat.isSelected;

                if (cat.isSelected) {
                    [self.brandFilter addObject:cat];
                }else {
                    [self.brandFilter removeObject:cat];
                }
            }
        }
        [self.secondTableView reloadData];
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
