//
//  BBGAllCommentViewController.m
//  Components
//
//  Created by Holyjoy on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGAllCommentViewController.h"
#import "Common.h"

@interface BBGAllCommentViewController ()
/**
 *  @author holyjoy, 15-05-04 20:05:36
 *
 *  获取评论列表请求
 */
@property (nonatomic,strong) BBGGoodsCommentListRequest *commentListRequest;

/**
 *  @author holyjoy, 15-05-04 20:05:14
 *
 *  回复评论请求
 */
@property (nonatomic,strong) BBGReplyRequest *sendReplyRequest;

/**
 *  @author holyjoy, 15-05-12 15:05:53
 *
 *  商品详情进来时，默认发表评论请求
 */
@property (nonatomic,strong) BBGEvaluateRequest *evaluateRequest;

@end

@implementation BBGAllCommentViewController

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
        
        _commentListRequest = [[BBGGoodsCommentListRequest alloc] initWithFromUserCenter:_isFromUserCenter];
    }
    _commentListRequest.size = _pageSize;
    _commentListRequest.pageNumber = _pageIndex;
    _commentListRequest.goodsId = _goodsId;
    _commentListRequest.isFromUserCenter = _isFromUserCenter;
    
    [_commentListRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        BBGGoodsCommentListResponse *commentListResponse = (BBGGoodsCommentListResponse *)responseData;
        if (weakSelf.pageIndex == 1) {
            weakSelf.commentArray = [NSMutableArray array];
        }
        [weakSelf.commentArray addObjectsFromArray:commentListResponse.commentList];
        if ([commentListResponse.commentList count] < weakSelf.pageSize) {
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
        
        BBGReplyResponse *replySponse = (BBGReplyResponse *)responseData;
        weakSelf.sendReplySucessful = replySponse.sucessful;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
        callback(NO,nil);
        
    }];
}

- (void)sendEvaluate:(LoadDataCallback)callback{
    
    WS(weakSelf)
    if (!_evaluateRequest) {
        _evaluateRequest = [[BBGEvaluateRequest alloc] init];
    }
    _evaluateRequest.goodsId = self.goodsId;
    _evaluateRequest.comment = _replyToText;
//    _evaluateRequest.orderId = _orderId;
    
    [_evaluateRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        BBGReplyResponse *replySponse = (BBGReplyResponse *)responseData;
        weakSelf.evaluateSucessful = replySponse.sucessful;
        callback(YES,responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
        callback(NO,nil);
        
    }];
}

- (void)dealloc {
    self.commentListRequest = nil;
    self.sendReplyRequest = nil;
    self.evaluateRequest = nil;
}

@end
