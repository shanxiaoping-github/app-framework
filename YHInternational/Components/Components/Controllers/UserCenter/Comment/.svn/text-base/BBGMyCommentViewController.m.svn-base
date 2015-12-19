//
//  BBGMyCommentViewController.m
//  Components
//
//  Created by Holyjoy on 15/4/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGMyCommentViewController.h"
#import "Common.h"
@interface BBGMyCommentViewController ()
/**
 *  @author holyjoy, 15-05-04 20:05:36
 *
 *  获取评论列表请求
 */
@property (nonatomic,strong) BBGCommentListRequest *commentListRequest;

/**
 *  @author holyjoy, 15-05-04 20:05:14
 *
 *  回复评论请求
 */
@property (nonatomic,strong) BBGReplyRequest *sendReplyRequest;


@property (nonatomic,strong) BBGGetCommentDetailRequest *getCommentDetailRequest;
@end

@implementation BBGMyCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _canLoadMore = YES;
    _pageSize = 20;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateData:(LoadDataCallback)callback{
    WS(weakSelf)
    if (!_commentListRequest) {
        _commentListRequest = [[BBGCommentListRequest alloc] init];
    }
    _commentListRequest.size = _pageSize;
    _commentListRequest.pageNumber = _pageIndex;
    [_commentListRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        BBGCommentListResponse *commentListResponse = (BBGCommentListResponse *)responseData;
        [weakSelf.commentedGoodsArray addObjectsFromArray:commentListResponse.commentedGoodsList];
        if ([commentListResponse.commentedGoodsList count] < weakSelf.pageSize) {
            weakSelf.canLoadMore = NO;
        }
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        callback(NO,nil);
    }];
}

- (void)sendReply:(LoadDataCallback)callback{
    WS(weakSelf)
    if (!_sendReplyRequest) {
        _sendReplyRequest = [[BBGReplyRequest alloc] init];
    }
    _sendReplyRequest.goodsId = _replyToGoodsId;
    _sendReplyRequest.forCommentId = _forCommentId;
    _sendReplyRequest.comment = _replyToText;
    
    [_sendReplyRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        [[BBGLoadingTips sharedInstance] hideTips];
        BBGReplyResponse *replySponse = (BBGReplyResponse *)responseData;
        weakSelf.sendReplySucessful = replySponse.sucessful;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        [[BBGLoadingTips sharedInstance] hideTips];
        [[BBGLoadingTips sharedInstance] showTips:errorMsg];
        callback(NO,nil);

    }];
}

- (void)getCommentDetailCount:(LoadDataCallback)callback{
    if (!self.getCommentDetailRequest) {
        _getCommentDetailRequest = [[BBGGetCommentDetailRequest alloc] init];
    }
    __weak BBGMyCommentViewController *weakSelf = self;
    [_getCommentDetailRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        BBGGetCommentDetailResponse *response = (BBGGetCommentDetailResponse*)responseData;
        weakSelf.noCommentGoodsNumber = response.countsForShareOrder;
        callback(YES,response);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
    }];
}

- (void)dealloc {
    self.commentListRequest = nil;
    self.sendReplyRequest = nil;
}

@end
