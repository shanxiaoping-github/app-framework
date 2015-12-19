//
//  BBGPhotoBrowserEditViewController.m
//  Common
//
//  Created by yangjie on 15/10/20.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import "BBGPhotoBrowserEditViewController.h"
#import "TOCropViewController.h"
#import "BBGTools.h"

@interface BBGPhotoBrowserEditViewController ()<UIScrollViewDelegate,TOCropViewControllerDelegate>

@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong) UIScrollView *photoScrollView;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation BBGPhotoBrowserEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _currentPage = 0;
    NSString *title = [NSString stringWithFormat:@"%ld/%ld",(long)_currentPage+1,(long)[_imgArray COUNT]];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    _titleLabel.text = title;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    _titleLabel.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = _titleLabel ;
    
    [self createRightBarButtonItemWithTarget:self action:@selector(finishPressed) title:@"完成" titleColor:UICOLOR_FONT_IMPORTANT_RED];
    
    [self createView];
}

- (void)finishPressed{
    if ([self.delegate respondsToSelector:@selector(finishEdit:imageArray:)]) {
        [self.delegate finishEdit:self imageArray:_imgArray];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)createView{
    CGRect rect = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-64);
    _photoScrollView = [[UIScrollView alloc] initWithFrame:rect];
    [_photoScrollView setBackgroundColor:[UIColor whiteColor]];
    [_photoScrollView setPagingEnabled:YES];
    [_photoScrollView setDelegate:self];
    [self.view addSubview:_photoScrollView];
    
    float xPoint = 0;
    for (int i=0; i<[_imgArray COUNT]; i++) {
        xPoint = i * FRAMEW(_photoScrollView);
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(xPoint, 0, FRAMEW(_photoScrollView), FRAMEH(_photoScrollView))];
        [_photoScrollView addSubview:bgView];
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[_imgArray ARRAY_OBJ_AT(i)]];
        imgView.tag = 1000+i;
        CGSize newSize = imgView.image.size;
        if (newSize.width > FRAMEW(_photoScrollView)) {
            float ratio = FRAMEW(_photoScrollView)/newSize.width;
            newSize.width = FRAMEW(_photoScrollView);
            newSize.height = floorf(newSize.height *ratio);
        }else if (newSize.height > FRAMEH(_photoScrollView)){
            float ratio = FRAMEH(_photoScrollView)/newSize.height;
            newSize.height = FRAMEH(_photoScrollView);
            newSize.width = floorf(newSize.width *ratio);
        }
        [imgView setFrame:CGRectMake(0, 0, newSize.width, newSize.height)];
        
        [bgView addSubview:imgView];
        [imgView setCenter:CGPointMake(FRAMEW(bgView)/2.0, FRAMEH(bgView)/2.0)];
    }
    [_photoScrollView setContentSize:CGSizeMake(FRAMEW(_photoScrollView)*[_imgArray COUNT], FRAMEH(_photoScrollView))];
    
    UIButton *editBtn = [UIButton buttonWithMyImage:@"setting_about_icon"];
    [editBtn addTarget:self action:@selector(editBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editBtn];
    
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-20);
    }];
}

- (void)editBtnPressed:(UIButton*)btn{
    UIImage *img = [_imgArray ARRAY_OBJ_AT(_currentPage)];
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithImage:img];
    cropController.delegate = self;
    [self presentViewController:cropController animated:YES completion:^{

    }];
}

- (void)reloadScrollWithIndex:(NSInteger)index{
    NSInteger tag = index+1000;
    UIImageView *currentImgView = (UIImageView*)[_photoScrollView viewWithTag:tag];
    UIImage *img = [_imgArray ARRAY_OBJ_AT(index)];
    [currentImgView setImage:img];
    
    CGSize newSize = currentImgView.image.size;
    if (newSize.width > FRAMEW(_photoScrollView)) {
        float ratio = FRAMEW(_photoScrollView)/newSize.width;
        newSize.width = FRAMEW(_photoScrollView);
        newSize.height = floorf(newSize.height *ratio);
    }else if (newSize.height > FRAMEH(_photoScrollView)){
        float ratio = FRAMEH(_photoScrollView)/newSize.height;
        newSize.height = FRAMEH(_photoScrollView);
        newSize.width = floorf(newSize.width *ratio);
    }
    [currentImgView setFrame:CGRectMake(0, 0, newSize.width, newSize.height)];
    [currentImgView setCenter:CGPointMake(FRAMEW(_photoScrollView)/2.0, FRAMEH(_photoScrollView)/2.0)];
}

#pragma mark TOCropViewControllerDelegate
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle{
    [_imgArray ARRAY_INSERT_OBJ_AT(image,_currentPage)];
    [_imgArray ARRAY_REMOVEOBJ_AT(_currentPage+1)];
    [self reloadScrollWithIndex:_currentPage];
    [cropViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_photoScrollView == scrollView) {
        CGFloat pageWidth = scrollView.frame.size.width;
        int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        _currentPage = currentPage;
        int indexOnPageControl = (currentPage % [_imgArray COUNT])+1;
        int sumPage = [_imgArray COUNT];
        [_titleLabel setText:[NSString stringWithFormat:@"%d/%d",indexOnPageControl,sumPage]];
    }
}


- (void)dealloc{
    _photoScrollView.delegate = nil;
}

@end
