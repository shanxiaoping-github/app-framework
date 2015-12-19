//
//  OnePhotoAlbumViewController.m
//  Common
//
//  Created by yangjie on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "OnePhotoAlbumViewController.h"
#import "Common.h"
#import "AlbumGroupViewController.h"

@interface PhotoAlbumAssetCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView* photoView;
@property(nonatomic,strong)UIImageView* seletedMask;

@end
@implementation PhotoAlbumAssetCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        
        CGSize cellS = [PhotoAlbumAssetCollectionViewCell cellSize];
        
        self.photoView = [[UIImageView alloc] initWithFrame:CCR(1, 1, cellS.width - 2, cellS.height - 2)];
        [self.contentView addSubview:self.photoView];
        
        self.seletedMask = [[UIImageView alloc] initWithFrame:CCR(0, 0, FRAMEW(self.photoView), FRAMEH(self.photoView))];;
        [self.seletedMask setBackgroundColor:RGBA_COLOR(255, 255, 255, 120)];
        [self.photoView addSubview:self.seletedMask];
        
        UIImageView* hookView = [UIImageView imageViewWithMyImage:@"selected"];
        [hookView setCenter:CCP(FRAMEW(self.seletedMask) - 12, FRAMEH(self.seletedMask) - 12)];
        [self.seletedMask addSubview:hookView];
        
    }
    return self;
}


-(void)reloadCell:(NSDictionary*)data{
    
    NSNumber* selected = [data DICT_OBJ_FOR_K(@"selected")];
    ALAsset* asset = [data DICT_OBJ_FOR_K(@"asset")];
    UIImage * img = [UIImage imageWithCGImage:asset.thumbnail];
    //UIImage* img = [data DICT_OBJ_FOR_K(@"thumbnail")];//thumbnail
    [self.photoView setImage:img];
    
    [self.seletedMask setHidden:![selected boolValue]];

    
}


+(CGSize)cellSize{
    CGSize size = CGSizeZero;
    
    if (IS_IPAD) {
        int countOneLine = 6;
        //float _w = (IPHONE_WIDTH - (countOneLine + 1.0))/(countOneLine*1.0);
        float _w = IPHONE_WIDTH/(countOneLine*1.0);
        
        size = CGSizeMake(_w, _w);
    }else{
        
        int countOneLine = 4;
        //float _w = (IPHONE_WIDTH - (countOneLine + 1.0))/(countOneLine*1.0);
        float _w = IPHONE_WIDTH/(countOneLine*1.0);
        
        size = CGSizeMake(_w, _w);
    }
    return size;
}

@end



@interface OnePhotoAlbumViewController ()

@end

@implementation OnePhotoAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [NSString stringWithFormat:@"%@",[self.assetGroup valueForProperty:ALAssetsGroupPropertyName]];
    
    self.assetArray = [NSMutableArray arrayWithCapacity:50];
    self.selectAssetDict = [NSMutableDictionary dictionaryWithCapacity:12];
    [self createView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    //[self.navigationController setCanDragBack:NO];
}

float photoAlbumSelectContollerbottomH = 50;
-(void)createView{

    UIButton* cancelBtn = [[UIButton alloc] initWithFrame:CCR(0, 0, 16*2, 35)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:APP_FONT(16)];
    [cancelBtn setTitleColor:UICOLOR_FONT_IMPORTANT_RED forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:cancelBtn]];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.minimumInteritemSpacing = -5;
    layout.minimumLineSpacing = 0;
    
    self.photoCollectionView = [[UICollectionView alloc] initWithFrame:CCR(0, 0, FRAMEW(self.view), FRAMEH(self.view) - photoAlbumSelectContollerbottomH) collectionViewLayout:layout];
    [self.photoCollectionView setBackgroundColor:[UIColor whiteColor]];
    self.photoCollectionView.dataSource = self;
    self.photoCollectionView.delegate = self;
    [self.photoCollectionView registerClass:[PhotoAlbumAssetCollectionViewCell class] forCellWithReuseIdentifier:@"AlbumPhotoCellId"];
    [self.photoCollectionView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:self.photoCollectionView];
    
    
    
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,YBOTTOM(self.photoCollectionView), FRAMEW(self.photoCollectionView), photoAlbumSelectContollerbottomH)];
    [self.bottomView setBackgroundColor:[UIColor blackColor]];
    [self.bottomView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [self.view addSubview:self.bottomView];
    
    NSString* btnTitle = [NSString stringWithFormat:@"完成 0/%d",self.maxSelectCount];
    float doneBtnW = TRANS_W(90);
    self.doneBtn = [UIButton buttonWithTitle:btnTitle color:UICOLOR_FONT_IMPORTANT_RED rect:CGRectMake(IPHONE_WIDTH - doneBtnW - 8, 8, doneBtnW, 35)];
    [self.doneBtn.titleLabel setFont:APP_FONT(14)];
    [self.doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bottomView addSubview:self.doneBtn];
    [self.doneBtn addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,FRAMEX(self.doneBtn) - 5, photoAlbumSelectContollerbottomH)];
    [self.bottomView addSubview:self.bottomScrollView];
    [self.bottomScrollView setAlwaysBounceHorizontal:YES];
    
    [self performSelectorInBackground:@selector(preparePhotos) withObject:nil];
}


- (void)cancelBtnPressed:(UIButton*)btn{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)preparePhotos{
    [self.assetGroup enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if(asset == nil) {
            return;
        }
        NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithObject:asset forKey:@"asset"];
        [dict setObject:@0 forKey:@"selected"];
        [self.assetArray addObject:dict];
        
    }];
    
    [self performSelectorOnMainThread:@selector(performInMainThread) withObject:nil waitUntilDone:YES];
    
    
}

-(void)performInMainThread{
    [self.photoCollectionView reloadData];
    
    if ([self.assetArray COUNT] > 16) {
        [self.photoCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:[self.assetArray COUNT] - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
    }
}

-(void)doneAction{
    
    NSMutableArray* dictArray = [NSMutableArray arrayWithArray:[self.selectAssetDict allValues]];
    [dictArray sortUsingComparator:^NSComparisonResult(NSDictionary* obj0, NSDictionary* obj1) {
        int tag0 = [[obj0 DICT_OBJ_FOR_K(@"tagOnBottom")] intValue];
        int tag1 = [[obj1 DICT_OBJ_FOR_K(@"tagOnBottom")] intValue];
        
        if (tag1 > tag0) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
    
    NSMutableArray* resultArray = [NSMutableArray arrayWithCapacity:12];
    
    for (int i = 0; i < [dictArray COUNT]; i++) {
        NSDictionary* dict = [dictArray ARRAY_OBJ_AT(i)];
        ALAsset* asset = [dict DICT_OBJ_FOR_K(@"asset")];
        UIImage * thumbImg = [UIImage imageWithCGImage:asset.thumbnail];
        ALAssetRepresentation *assetRep = [asset defaultRepresentation];
        
        NSMutableDictionary* workingDictionary = [NSMutableDictionary dictionaryWithCapacity:5];
        NSURL* url = [[asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[asset valueForProperty:ALAssetPropertyURLs] allKeys] ARRAY_OBJ_AT(0)]];
        
        [workingDictionary DICT_SET_VK([url absoluteString],@"UIImagePickerControllerReferenceURL")];
        [workingDictionary DICT_SET_VK(thumbImg,@"thumbImg")];
        [workingDictionary DICT_SET_VK(assetRep.metadata,@"OriginalImageMetaDict")];
        [workingDictionary DICT_SET_VK(NSStringFromCGSize(assetRep.dimensions),@"dimensions")];
        [workingDictionary DICT_SET_VK(assetRep,@"assetRep")];
        [resultArray ARRAY_ADD_OBJ(workingDictionary)];
    }
    
    
    WS(ws)
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [((AlbumGroupViewController*)(ws.albumGroupVC)).selectedDelegate selectPhotos:resultArray];
    }];
    
    
//    [self popTwoVC];
}

-(void)popTwoVC{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    int row = 0;
    row = [self.assetArray COUNT];
    return row;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = [PhotoAlbumAssetCollectionViewCell cellSize];
    return size;
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0, 0, 0);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoAlbumAssetCollectionViewCell *cell = nil;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumPhotoCellId" forIndexPath:indexPath];
    NSDictionary* dict = [self.assetArray ARRAY_OBJ_AT(indexPath.row)];
    
    [cell reloadCell:dict];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSMutableDictionary* dict = [self.assetArray ARRAY_OBJ_AT(indexPath.row)];
    
    NSNumber* selected = [dict DICT_OBJ_FOR_K(@"selected")];
    
    
    if ([selected boolValue]) {
        //取消选中
        [dict DICT_SET_VK(@0,@"selected")];
        
        [self.selectAssetDict removeObjectForKey:NSStringFromOBJPointer(dict)];
        [self assetUnSelected:dict];
    }else{
        if ([self.selectAssetDict COUNT] >= self.maxSelectCount) {
            [[BBGLoadingTips sharedInstance] showTips:[NSString stringWithFormat:@"本次最多选择%d张照片",self.maxSelectCount]];
            return;
        }
        //选中照片
        [dict DICT_SET_VK(@1,@"selected")];
        
        [self.selectAssetDict setObject:dict forKey:NSStringFromOBJPointer(dict)];
        
        
        [self assetSelected:dict];
    }
    
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}




#define SMALL_IMG_WIDTH 36
#define SMALL_IMG_HEIGHT 36
#define SMALL_IMG_GAP 7
- (void)assetSelected:(NSMutableDictionary*)dict{
    ALAsset* asset = [dict DICT_OBJ_FOR_K(@"asset")];
    
    UIImage * img = [UIImage imageWithCGImage:asset.thumbnail];
    
    //将一幅图片加入滑动条
    int imgCount = 0;
    NSArray* subViews = [self.bottomScrollView subviews];
    for (UIImageView* _v in subViews) {
        if (_v.tag >= 10000) {
            imgCount++;
        }
    }

    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgCount*(SMALL_IMG_WIDTH + SMALL_IMG_GAP) + SMALL_IMG_GAP, 7, SMALL_IMG_WIDTH, SMALL_IMG_HEIGHT)];
    
    static int tagCount = 0;
    imgView.tag = 10000 + tagCount;
    tagCount++;
    CGSize imgSize = imgView.frame.size;
    imgSize.width *= 2;
    imgSize.height *= 2;
    [imgView setImage:[img imageByScalingToSize:imgSize]];
    [self.bottomScrollView addSubview:imgView];
    
    [dict DICT_SET_VK(NSStringFromInt(imgView.tag),@"tagOnBottom")];

    [self.bottomScrollView setContentSize:CGSizeMake((imgCount + 1)*(SMALL_IMG_WIDTH + SMALL_IMG_GAP) + SMALL_IMG_GAP, photoAlbumSelectContollerbottomH)];
    if (self.bottomScrollView.contentSize.width > FRAMEW(self.bottomScrollView)) {
        [self.bottomScrollView setContentOffset:CGPointMake(self.bottomScrollView.contentSize.width - FRAMEW(self.bottomScrollView), 0) animated:YES];
    }
    
    NSString* btnTitle = [NSString stringWithFormat:@"完成 %d/%d",imgCount + 1,self.maxSelectCount];
    [self.doneBtn setTitle:btnTitle forState:UIControlStateNormal];
    
}

- (void)assetUnSelected:(NSMutableDictionary*)dict{

    int viewTag = [[dict DICT_OBJ_FOR_K(@"tagOnBottom")] intValue];
    
    //将viewTag的view移除 ，大于viewTag 的view 位置前移
    
    int imgCount = 0;
    NSArray* subViews = [self.bottomScrollView subviews];
    UIView* willRemoveView = nil;
    NSMutableArray* willChangePosViews = [NSMutableArray arrayWithCapacity:5];
    for (UIImageView* _v in subViews) {
        if (_v.tag >= 10000) {
            imgCount++;
            if (viewTag == _v.tag) {
                willRemoveView = _v;
            }
            if (_v.tag > viewTag) {
                [willChangePosViews addObject:_v];
            }
        }
    }
    
    if (self.bottomScrollView.contentSize.width > FRAMEW(self.bottomScrollView)) {
        //跳到操作位置
        
        //[bottomScrollView setContentOffset:CGPointMake(, 0) animated:YES];
    }
    
    [willRemoveView removeFromSuperview];
    
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.3];
    for (UIImageView* _v in willChangePosViews) {
        CGRect viewRect = _v.frame;
        viewRect.origin.x -= (SMALL_IMG_WIDTH + SMALL_IMG_GAP);
        [_v setFrame:viewRect];
    }
    [UIView commitAnimations];
    
    [self.bottomScrollView setContentSize:CGSizeMake((imgCount - 1)*(SMALL_IMG_WIDTH + SMALL_IMG_GAP) + SMALL_IMG_GAP, photoAlbumSelectContollerbottomH)];
    
    NSString* btnTitle = [NSString stringWithFormat:@"完成 %d/%d",imgCount - 1,self.maxSelectCount];
    //[countLabel setText:btnTitle];
    [self.doneBtn setTitle:btnTitle forState:UIControlStateNormal];
     
     
    
}



@end
