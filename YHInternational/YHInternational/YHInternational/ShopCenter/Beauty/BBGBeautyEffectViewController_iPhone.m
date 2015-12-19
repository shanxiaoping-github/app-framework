//
//  BeautyEffectViewController_iPhone.m
//  YHInternational
//
//  Created by 彭腾 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGBeautyEffectViewController_iPhone.h"
#import "BBGBeautyEffectCell.h"
#import "BBGBeautyEmptyCell.h"
#import "BBGBeautyEffectModel.h"
#import "BBGGoodsListViewController_iPhone.h"
@interface BBGBeautyEffectViewController_iPhone ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    UICollectionView *_beautyEffect;
    NSMutableArray *array;
    NSInteger count;
    NSInteger sectionNum;
}

@end

@implementation BBGBeautyEffectViewController_iPhone

- (void)initUI {
    array = [NSMutableArray arrayWithArray:self.beautyArr];
    
    count = array.count;
    if (array.count%4==0) {
        sectionNum = array.count/4;
    }else {
        sectionNum = array.count/4+1;
    }
    
    
    self.view.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc ]init] ;
//    _beautyEffect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, IPHONE_WIDTH, IPHONE_WIDTH/4/79*56*section) collectionViewLayout:flowLayout];
    _beautyEffect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT) collectionViewLayout:flowLayout];
    _beautyEffect.backgroundColor = [UIColor whiteColor];
    _beautyEffect.showsVerticalScrollIndicator = NO;
    _beautyEffect.bounces = NO;
    _beautyEffect.delegate = self;
    _beautyEffect.dataSource = self;
    
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, _beautyEffect.frame.size.width, 0.5f);
    topBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
    [_beautyEffect.layer addSublayer:topBorder];
    
    [self.view addSubview:_beautyEffect];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        if (array.count%4==0) {
            return array.count;
        }else if (array.count%4==3) {
            return array.count+1;
        }else if (array.count%4==2) {
            return array.count+2;
        }else {
            return array.count+3;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [_beautyEffect registerNib:[UINib nibWithNibName:@"BBGBeautyEmptyCell" bundle:nil] forCellWithReuseIdentifier:@"BBGBeautyEmpty"];
        BBGBeautyEmptyCell *cell = [_beautyEffect dequeueReusableCellWithReuseIdentifier:@"BBGBeautyEmpty" forIndexPath:indexPath];
        cell.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT;
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width, 0.5f);
        bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
        [cell.contentView.layer addSublayer:bottomBorder];
        return cell;
    } else {
        [_beautyEffect registerNib:[UINib nibWithNibName:@"BBGBeautyEffectCell" bundle:nil] forCellWithReuseIdentifier:@"BeautyEffect"];
        BBGBeautyEffectCell *cell = [_beautyEffect dequeueReusableCellWithReuseIdentifier:@"BeautyEffect" forIndexPath:indexPath];
        if (indexPath.item<array.count) {
            BBGBeautyEffectModel *model = array[indexPath.item];
            cell.titleLab.text = model.catName;
            [cell buttonAction:^{
                BBGGoodsListViewController_iPhone *vc = [[BBGGoodsListViewController_iPhone alloc]init];
                vc.fCate = model.catId;
                vc.title = model.catName;
                vc.sourceViewController = BBGSearchController;
                [self.navigationController pushViewController:vc animated:YES];
            }];
        }else {
            cell.titleLab.text = @"";
        }
        
        /**
         *  美妆功效线条
         */
        if (array.count%4==0) {
            if (indexPath.item%4==0) {
                if (indexPath.item>=count-4) {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                }else {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(10.0f, cell.frame.size.height-0.5f, cell.frame.size.width-10.0f, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                }
            }else if (indexPath.item%4==3) {
                if (indexPath.item<4) {
                    CALayer *leftLayer = [CALayer layer];
                    leftLayer.frame = CGRectMake(0.0f, 10.0f, 0.5f, cell.frame.size.height-10.0f);
                    leftLayer.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:leftLayer];
                }else if (indexPath.item>count-4) {
                    CALayer *leftLayer = [CALayer layer];
                    leftLayer.frame = CGRectMake(0.0f, 0.0f, 0.5f, cell.frame.size.height-10.0f);
                    leftLayer.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:leftLayer];
                }else {
                    CALayer *leftLayer = [CALayer layer];
                    leftLayer.frame = CGRectMake(0.0f, 0.0f, 0.5f, cell.frame.size.height);
                    leftLayer.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:leftLayer];
                }
                if (indexPath.item>=count-4) {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                }else {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width-10.0f, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                }
            }else {
                if (indexPath.item<4) {
                    CALayer *leftLayer = [CALayer layer];
                    leftLayer.frame = CGRectMake(0.0f, 10.0f, 0.5f, cell.frame.size.height-10.0f);
                    leftLayer.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:leftLayer];
                }else if (indexPath.item>count-4) {
                    CALayer *leftLayer = [CALayer layer];
                    leftLayer.frame = CGRectMake(0.0f, 0.0f, 0.5f, cell.frame.size.height-10.0f);
                    leftLayer.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:leftLayer];
                }else {
                    CALayer *leftLayer = [CALayer layer];
                    leftLayer.frame = CGRectMake(0.0f, 0.0f, 0.5f, cell.frame.size.height);
                    leftLayer.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:leftLayer];
                }
                CALayer *bottomBorder = [CALayer layer];
                bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width, 0.5f);
                bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                [cell.contentView.layer addSublayer:bottomBorder];
            }
        }
        
        if (array.count%4==1) {
            if (indexPath.item-array.count+1==1) {
                if (indexPath.item==1) {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                    
                    CALayer *leftLayer = [CALayer layer];
                    leftLayer.frame = CGRectMake(0.0f, 10.0f, 0.5f, cell.frame.size.height-10.0f);
                    leftLayer.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:leftLayer];
                }else {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                    
                    CALayer *leftLayer = [CALayer layer];
                    leftLayer.frame = CGRectMake(0.0f, 0.0f, 0.5f, cell.frame.size.height-10.0f);
                    leftLayer.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:leftLayer];
                }
            }else if (indexPath.item-count>0) {
                CALayer *bottomBorder = [CALayer layer];
                bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width, 0.5f);
                bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                [cell.contentView.layer addSublayer:bottomBorder];
            }else if (indexPath.item%4==0) {
                if (indexPath.item>=count-4) {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                }else {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(10.0f, cell.frame.size.height-0.5f, cell.frame.size.width-10.0f, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                }
            }else {
                if (indexPath.item<4) {
                    CALayer *leftLayer = [CALayer layer];
                    leftLayer.frame = CGRectMake(0.0f, 10.0f, 0.5f, cell.frame.size.height-10.0f);
                    leftLayer.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:leftLayer];
                }else {
                    CALayer *leftLayer = [CALayer layer];
                    leftLayer.frame = CGRectMake(0.0f, 0.0f, 0.5f, cell.frame.size.height);
                    leftLayer.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:leftLayer];
                }
                if (indexPath.item%4==3&&indexPath.item<count-1) {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width-10.0f, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                }else {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                }
            }
        }

        if (array.count%4==2) {
            if (indexPath.item-array.count+1==2) {
                CALayer *bottomBorder = [CALayer layer];
                bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width, 0.5f);
                bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                [cell.contentView.layer addSublayer:bottomBorder];
            }else if (indexPath.item%4==0) {
                if (indexPath.item>=count-4) {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                }else {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(10.0f, cell.frame.size.height-0.5f, cell.frame.size.width-10.0f, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                }
            }else {
                if (indexPath.item<4) {
                    CALayer *leftLayer = [CALayer layer];
                    leftLayer.frame = CGRectMake(0.0f, 10.0f, 0.5f, cell.frame.size.height-10.0f);
                    leftLayer.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:leftLayer];
                }else if (indexPath.item+1-count>=0) {
                    CALayer *leftLayer = [CALayer layer];
                    leftLayer.frame = CGRectMake(0.0f, 0.0f, 0.5f, cell.frame.size.height-10.0f);
                    leftLayer.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:leftLayer];
                }else {
                    CALayer *leftLayer = [CALayer layer];
                    leftLayer.frame = CGRectMake(0.0f, 0.0f, 0.5f, cell.frame.size.height);
                    leftLayer.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:leftLayer];
                }
                if (indexPath.item%4==3&&indexPath.item<count-2) {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width-10.0f, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                }else {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                }

            }
        }

        if (array.count%4==3) {
            if (indexPath.item-array.count+1==2) {
                CALayer *bottomBorder = [CALayer layer];
                bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width, 0.5f);
                bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                [cell.contentView.layer addSublayer:bottomBorder];
            }else if (indexPath.item%4==0) {
                if (indexPath.item>=count-4) {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                }else {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(10.0f, cell.frame.size.height-0.5f, cell.frame.size.width-10.0f, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                }
            }else {
                if (indexPath.item<4) {
                    CALayer *leftLayer = [CALayer layer];
                    leftLayer.frame = CGRectMake(0.0f, 10.0f, 0.5f, cell.frame.size.height-10.0f);
                    leftLayer.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:leftLayer];
                }else if (indexPath.item+2-count>=0) {
                    CALayer *leftLayer = [CALayer layer];
                    leftLayer.frame = CGRectMake(0.0f, 0.0f, 0.5f, cell.frame.size.height-10.0f);
                    leftLayer.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:leftLayer];
                }else {
                    CALayer *leftLayer = [CALayer layer];
                    leftLayer.frame = CGRectMake(0.0f, 0.0f, 0.5f, cell.frame.size.height);
                    leftLayer.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:leftLayer];
                }
                if (indexPath.item%4==3&&indexPath.item<count-1) {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width-10.0f, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                }else {
                    CALayer *bottomBorder = [CALayer layer];
                    bottomBorder.frame = CGRectMake(0.0f, cell.frame.size.height-0.5f, cell.frame.size.width, 0.5f);
                    bottomBorder.backgroundColor = [UIColorFromRGB(223,223,223) CGColor];
                    [cell.contentView.layer addSublayer:bottomBorder];
                }
                
            }
        }
        
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake((IPHONE_WIDTH-20)/4,(IPHONE_WIDTH-20-30)/4/79*56) ;
//    NSLog(@"%f",IPHONE_WIDTH/4);
//    return CGSizeMake(IPHONE_WIDTH/4, IPHONE_WIDTH/4/79*56);
    if (indexPath.section==0) {
        return CGSizeMake(IPHONE_WIDTH, 10.0f);
    }else {
        return CGSizeMake(IPHONE_WIDTH/4, 60.0f);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0) ;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0f ;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0f ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)];
    label.text = @"美妆功效";
    label.font = APP_FONT_DEMI_LIGHT(18.0f);
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    [self initUI];
    
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        if (sucessful) {
            array = [NSMutableArray arrayWithArray:self.beautyArr];
            
            count = array.count;
            if (array.count%4==0) {
                sectionNum = array.count/4;
            }else {
                sectionNum = array.count/4+1;
            }
            if (sectionNum*60+10>IPHONE_HEIGHT-64) {
                _beautyEffect.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-64);
            }else {
                _beautyEffect.frame = CGRectMake(0, 0, IPHONE_WIDTH, 60*sectionNum+10);
            }
            [_beautyEffect reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -
-(void)loadDataWithMenu:(BBGMenuItem *)menu force:(BOOL)force{
    
}

- (void)contentViewController:(UINavigationController *)controller{
    self.contentViewController = controller;
}

@end
