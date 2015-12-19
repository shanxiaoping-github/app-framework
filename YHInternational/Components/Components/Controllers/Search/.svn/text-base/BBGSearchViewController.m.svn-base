//
//  BBGSearchViewController.m
//  Components
//
//  Created by Holyjoy on 15/3/20.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGSearchViewController.h"

@interface BBGSearchViewController ()

@property (nonatomic,strong) BBGPhraseAssociationRequest *phraseAssociationRequest;

@end

@implementation BBGSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _phraseAssociationArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  @author holyjoy, 15-03-24 10:03:06
 *
 *  从缓存加载历史纪录
 */
- (void)loadSearchHistory{
    
    self.searchHistoryArray = (NSMutableArray *)[[BBGCache queryCacheForType:BBGCacheTypeSearchHistory maxCount:12] firstObject];
    if (!self.searchHistoryArray) {
        
         NSString *tips = @"暂无搜索历史记录哦...";
        [self showDefaultViewWithStampImage:[UIImage imageNamed:@"searchHistoryNull"] tips:tips target:self actionTitle:nil action:nil WithResponseResult:BBGResponseNotData];
    }else{
        [self.defaultView dismiss];
        
    }
}
- (void)updateData:(LoadDataCallback)callback {
    
    if (!self.phraseAssociationRequest) {
        self.phraseAssociationRequest = [[BBGPhraseAssociationRequest alloc] init];
    }
    _phraseAssociationRequest.keywords = self.keyWords;
    [_phraseAssociationRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        BBGPhraseAssociationResponse *phraseAssociationResponse = (BBGPhraseAssociationResponse *)responseData;

        self.phraseAssociationArray = phraseAssociationResponse.phraseAssociationArray;
        
        callback(YES,responseData);
        
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];
}



- (void)dealloc {

    [_phraseAssociationRequest cancelRequest];
}

@end
