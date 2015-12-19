//
//  BBGGoodsListViewController.m
//  Components
//
//  Created by Timmy Ouyang on 15/4/17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsListViewController.h"
#import "Common.h"
#import "BBGCartDirectRequest.h"

@interface BBGGoodsListViewController ()

@property (nonatomic,strong) BBGSearchRequest *searchRequest;
@property (nonatomic, strong) BBGPhoneExtraRequest *phoneExtraRequest;
@property (nonatomic, strong) BBGPhoneRecommendRequest *phoneRecommendRequest;
@property (nonatomic, strong) BBGCartDirectRequest *cartDirectRequest;
@end

@implementation BBGGoodsListViewController

- (void)clearSearchItems {

    self.type = SortTypeDefault;
    self.keyword = nil;
    self.categoryID = nil;
    self.brandIDs = nil;
    self.minPrice = -1;
    self.maxPrice = -1;
    self.showHaveStoreOnly = NO;
    self.page = 1;
    self.pageSize = 20;
    self.facetProps = nil;
    self.facetSpec = nil;

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.page = 1;
        self.pageSize = 20;
        self.canLoadMore = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateData:(LoadDataCallback)callback {
    if (!self.searchRequest) {
        self.searchRequest = [[BBGSearchRequest alloc] init];
    }
    _searchRequest.keyword = self.keyword;
    _searchRequest.type = self.type;
    _searchRequest.page = self.page;
    _searchRequest.pageSize = self.pageSize;
    _searchRequest.categoryID = self.categoryID;
    _searchRequest.brandIDs = self.brandIDs;
    _searchRequest.minPrice = self.minPrice;
    _searchRequest.maxPrice = self.maxPrice;
    _searchRequest.facetSpec = self.facetSpec;
    _searchRequest.facetProps = self.facetProps;
    _searchRequest.fCate = self.fCate;
    _searchRequest.showHaveStoreOnly = self.showHaveStoreOnly;
    _searchRequest.showProprietaryOnly = self.showProprietaryOnly;

    
    __weak BBGGoodsListViewController *weakSelf = self;
    
    if (!self.products) {
        _products = [NSMutableArray array];
    }
    if (!self.filterAttributes) {
        _filterAttributes = [NSMutableArray array];
    }
    
    if (self.dataLoadType == BBGDataLoadRefresh) {
        _searchRequest.page = 1;
    }
    
    [_searchRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGSearchResponse *results = (BBGSearchResponse *)responseData;
        //商品列表
        if (self.dataLoadType == BBGDataLoadRefresh) {
            [weakSelf.products removeAllObjects];
            weakSelf.page = 1;
            if (results.products.count > 0) {
                [weakSelf.products addObjectsFromArray:results.products];
                weakSelf.canLoadMore = YES;
                if (weakSelf.products.count == results.totalCount) {
                    weakSelf.canLoadMore = NO;
                }
                //筛选条件列表
                self.filterAttributes = results.allFilterAttributes;
                callback(YES, responseData);

            }else {
                [weakSelf.products removeAllObjects];
                weakSelf.canLoadMore = NO;
                callback(NO,0);
            }
        }else {
            if (results.products.count > 0) {
                [weakSelf.products addObjectsFromArray:results.products];
                
                //判断是否加载完毕
                if (weakSelf.products.count == results.totalCount) {
                    weakSelf.canLoadMore = NO;
                }
                callback(YES, responseData);
            }else {
                callback(NO,0);
            }
        }
        
        [[BBGLoadingTips sharedInstance] hideTips];

    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        [weakSelf.products removeAllObjects];
        callback(NO,nil);
        
        [[BBGLoadingTips sharedInstance] hideTips];
    }];
}

- (void)addPraiseRequest:(LoadDataCallback)callback{
    
    if (!_addPraiseRequest) {
        _addPraiseRequest  = [[BBGAddPraiseRequest alloc] init];
    }

    [_addPraiseRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
}

- (void)addCartRequet:(LoadDataCallback)callback{
    if (!_addCartRequet) {
        _addCartRequet = [[BBGAddCartRequest alloc] init];
    }
    _addCartRequet.productId = self.productId;
    _addCartRequet.quantity = self.quantity;
    [[BBGLoadingTips sharedInstance] showLoading:nil];
    [_addCartRequet sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        [[BBGLoadingTips sharedInstance] hideTips];
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
        [[BBGLoadingTips sharedInstance] hideTips];
    }];
}

- (void)loadPhoneExtra:(LoadDataCallback)callback {

    if (!_phoneExtraRequest) {
        _phoneExtraRequest = [[BBGPhoneExtraRequest alloc] init];
    }
    __weak BBGGoodsListViewController *weakSelf = self;

    if (!self.products) {
        _products = [NSMutableArray array];
    }
    _phoneExtraRequest.type = self.type;
    _phoneExtraRequest.page = self.page;
    _phoneExtraRequest.pageSize = self.pageSize;

    if (self.dataLoadType == BBGDataLoadRefresh) {
        _phoneExtraRequest.page = 1;
    }

    [_phoneExtraRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGPhoneExtraResponse *response = (BBGPhoneExtraResponse *)responseData;
        //商品列表
        if (self.dataLoadType == BBGDataLoadRefresh) {
            [weakSelf.products removeAllObjects];
            weakSelf.page = 1;
            if (response.products.count > 0) {
                [weakSelf.products addObjectsFromArray:response.products];
                weakSelf.canLoadMore = YES;
                if (weakSelf.products.count == response.totalCount) {
                    weakSelf.canLoadMore = NO;
                }
                callback(YES,responseData);
            }else {
                [weakSelf.products removeAllObjects];
                weakSelf.canLoadMore = NO;
                callback(NO,responseData);
            }
        }else {
            if (response.products.count > 0) {
                [weakSelf.products addObjectsFromArray:response.products];
                
                weakSelf.canLoadMore = YES;
                //判断是否加载完毕
                if (weakSelf.products.count == response.totalCount) {
                    weakSelf.canLoadMore = NO;
                }

                callback(YES,responseData);
            }else {
                callback(NO,responseData);
            }
        }

        if (response.products.count < self.pageSize) {
            weakSelf.canLoadMore = NO;
        }

    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];
    
}

- (void)cartDirectRequest:(LoadDataCallback)callback {
    
    if (!_cartDirectRequest) {
        _cartDirectRequest = [[BBGCartDirectRequest alloc] init];
    }
    _cartDirectRequest.productId = self.productId;
    _cartDirectRequest.quantity = self.quantity;
    [[BBGLoadingTips sharedInstance] showLoading:nil];
    if ([BBGSessionManager sharedInstance].isLogin) {
        [_cartDirectRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
            callback(YES,responseData);
        } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
            
        }];
        [[BBGLoadingTips sharedInstance] hideTips];

    }else {

        [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
            if (successful) {
                [_cartDirectRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
                    
                    callback(YES,responseData);
                } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
                    
                }];
            }
            [[BBGLoadingTips sharedInstance] hideTips];

        }];
    }
}


- (void)dealloc
{
    [_searchRequest cancelRequest];
    [_phoneExtraRequest cancelRequest];
    [_addCartRequet cancelRequest];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)loadPhoneRequest:(LoadDataCallback)callback{
    if (!_phoneRecommendRequest) {
        _phoneRecommendRequest = [[BBGPhoneRecommendRequest alloc] init];
    }
    __weak BBGGoodsListViewController *weakSelf = self;
    
    if (!self.products) {
        _products = [NSMutableArray array];
    }
    _phoneRecommendRequest.page = self.page;
    _phoneRecommendRequest.pageSize = self.pageSize;
    
    if (self.dataLoadType == BBGDataLoadRefresh) {
        _searchRequest.page = 1;
    }
    
    [_phoneRecommendRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGPhoneRecommendResponse *response = (BBGPhoneRecommendResponse *)responseData;
        //商品列表
        if (self.dataLoadType == BBGDataLoadRefresh) {
            [weakSelf.products removeAllObjects];
            _phoneRecommendRequest.page = 1;
            if (response.products.count > 0) {
                [weakSelf.products addObjectsFromArray:response.products];
                weakSelf.canLoadMore = YES;
                if (weakSelf.products.count < 20) {
                    weakSelf.canLoadMore = NO;
                }
                callback(YES,responseData);
            }else {
                [weakSelf.products removeAllObjects];
                weakSelf.canLoadMore = NO;
                callback(NO,responseData);
            }
        }else {
            if (response.products.count > 0) {
                [weakSelf.products addObjectsFromArray:response.products];
                
                weakSelf.canLoadMore = YES;
                //判断是否加载完毕
                if (weakSelf.products.count < response.totalCount) {
                    weakSelf.canLoadMore = NO;
                }
                
                callback(YES,responseData);
            }else {
                callback(NO,responseData);
            }
        }
        
        if (response.products.count < self.pageSize) {
            weakSelf.canLoadMore = NO;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];

}
@end
