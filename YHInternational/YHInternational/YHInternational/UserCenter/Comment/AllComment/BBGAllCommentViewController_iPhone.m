//
//  BBGAllCommentViewController_iPhone.m
//  YHInternational
//
//  Created by Holyjoy on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGAllCommentViewController_iPhone.h"
#import "BBGAllCommentSectionHeaderView_iPhone.h"
#import "BBGGoodsDetailViewController_iPhone.h"
#import "AllCommentTextCell.h"
#import "AllCommentImageCell.h"
#import "AllReplyTextCell.h"
#import "AllReplyImageCell.h"
#import "CommentTableViewCell.h"
#import "ReplyTableViewCell.h"

#import "BBGCommentedGoods.h"
#import "BBGReply.h"
#import "HPGrowingTextView.h"

#import "BBGTopicExplainView.h"

@interface BBGAllCommentViewController_iPhone ()<UITableViewDelegate,UITableViewDataSource,HPGrowingTextViewDelegate,PullDelegate,ImageCollectionViewCellDelegate>
{
    UIView *containerView;
    HPGrowingTextView *textView;
    UIButton *doneBtn;
    BBGTopicExplainView  *topic;

}
@property (nonatomic,strong) BBGPullTable *commentTableView;


@end

@implementation BBGAllCommentViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"全部评论" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    
    //解决IQKeyboard处理不弹出的bug

    if (self.isFromUserCenter) {
        _commentTableView = [[BBGPullTable alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }else{
//        self.view = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _commentTableView = [[BBGPullTable alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height - 54) style:UITableViewStylePlain];

    }

    self.view.backgroundColor = [UIColor whiteColor];

    _commentTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    _commentTableView.pullDelegate = self;
    _commentTableView.notOpenSticky = YES;
    _commentTableView.backgroundColor = [UIColor whiteColor];
    _commentTableView.dataSource = self;
    _commentTableView.delegate = self;
    _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_commentTableView];

    __weak BBGAllCommentViewController_iPhone *weakself = self;
    [_commentTableView loadMore:^(id data) {
        [weakself requestCommentedGoodsList:weakself.pageIndex];
    }];
    
    [_commentTableView refreshData:^(id data) {
        weakself.canLoadMore = YES;
        [weakself requestCommentedGoodsList:1];
    }];
    [_commentTableView triggerPullToRefresh];
    [self creatReplyTextView];
}


- (void)requestCommentedGoodsList:(NSInteger)tempPageIndex{
    self.pageIndex = tempPageIndex;
    
    __weak BBGAllCommentViewController_iPhone * weakSelf = self;
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        
        [weakSelf.commentTableView stopAnimationWithCompletion:^{
            [[BBGLoadingTips sharedInstance] hideTips];
            [weakSelf.defaultView dismiss];
            
            if (sucessful) {
                BBGGoodsCommentListResponse *responseData = (BBGGoodsCommentListResponse *)response;
                if ([responseData.commentList count]) {
                    weakSelf.pageIndex += 1;
                    [weakSelf.commentTableView reloadData];
                }else{
                    //当正好20条评论的时候，只有第一次请求无数据时才显示默认页
                    if (weakSelf.pageIndex == 1) {
                        [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"NullComment"] tips:@"还没有评论..." target:weakSelf actionTitle:nil action:nil WithResponseResult:BBGResponseNotData offset:CGPointMake(0, 0) onView:weakSelf.commentTableView];
                    }
                    
                }
                
            }else{
                
                [weakSelf showDefaultViewWithStampImage:nil tips:@"您的网络不给力，请检查下您的网络设置" target:weakSelf.commentTableView actionTitle:@"重新加载" action:@selector(triggerPullToRefresh)
                                     WithResponseResult:BBGResponseNetError offset:CGPointZero onView:weakSelf.view];
            }
            
            weakSelf.commentTableView.showsInfiniteScrolling = weakSelf.canLoadMore;
        }];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PullDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView headerView:(NSInteger)section{
    if (self.isFromUserCenter) {
        BBGAllCommentSectionHeaderView_iPhone *headerView = [[[NSBundle mainBundle] loadNibNamed:@"BBGAllCommentSectionHeaderView_iPhone" owner:nil options:nil] firstObject];
        headerView.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
        [headerView.goodsImageView sd_setImageWithURL:[NSURL URLWithString:self.goodsImgString]];
        headerView.goodsDescLabel.text = self.goodsDesc;
        headerView.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@",self.goodsPrice];
      
        //点击头部跳转到商品详情
        __weak BBGAllCommentViewController_iPhone *weakself = self;
        headerView.tapBlock = ^(){
        
            BBGGoodsDetailViewController_iPhone *goodsDetailConTrl = [[BBGGoodsDetailViewController_iPhone alloc] init];
            goodsDetailConTrl.goodsId = weakself.goodsId;
            [weakself.navigationController pushViewController:goodsDetailConTrl animated:YES];
        };
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, headerView.frame.size.width)];
        [cell addSubview:headerView];
        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell).with.offset(0);
            make.right.equalTo(cell).with.offset(0);
            make.top.equalTo(cell).with.offset(0);
            make.bottom.equalTo(cell).with.offset(0);
        }];
        return cell;

    }else{
        return nil;
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightOfHeaderView:(NSIndexPath *)indexPath{
    if (self.isFromUserCenter) {
        return 100;
    }else{
        return 0;
    }
}


#pragma mark - BBGTableViewDataSource And BBGTableViewDelegate Methods
- (NSInteger)numberOfSectionsInTableView:(BBGTableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(BBGTableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.commentArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    BBGComment *comment = [self.commentArray ARRAY_OBJ_AT(indexPath.row)];
    BBGReply *reply = comment.replyFor;
    if (comment.replyFor.replyText.length == 0) {
        return [CommentTableViewCell cellHeignt:comment];
//        if ([comment.imgUrlListArray count] == 0) {
//            ///无回复无图片
//            return [AllCommentTextCell cellHeignt:comment];
//        }else{
//            ///无回复有图片
//            return [AllCommentImageCell cellHeignt:comment];
//        }
    }else{
        return [ReplyTableViewCell cellHeignt:comment replyText:reply];

//        if ([reply.imgUrlListArray count] == 0) {
//            ///有回复无图片
//            return [AllReplyTextCell cellHeignt:comment replyText:reply];
//        }else{
//            ///有回复有图片
//            return [AllReplyImageCell cellHeignt:comment replyText:reply];
//        }
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    BBGComment *comment = [self.commentArray ARRAY_OBJ_AT(indexPath.row)];
    BBGReply *reply = comment.replyFor;
    ///是否有回复
    if (comment.replyFor.replyText.length == 0) {
//        ///无回复且无图片
//        if ([comment.imgUrlListArray count] == 0) {
//            static NSString *identifier1 = @"AllCommentTextCell";
//            AllCommentTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
//            if (cell == nil) {
//                cell = [[[NSBundle mainBundle] loadNibNamed:identifier1 owner:nil options:nil] firstObject];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            }
//            [cell updateCell:comment];
//            return cell;
//        }else{
//            ///无回复但有图片
//            static NSString *identifier2 = @"AllCommentImageCell";
//            AllCommentImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
//            if (cell == nil) {
//                cell = [[[NSBundle mainBundle] loadNibNamed:identifier2 owner:nil options:nil] firstObject];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            }
//            cell.delegate = self;
//            [cell updateCell:comment];
//            return cell;
//        }
        
        static NSString *identifier = @"CommentTableViewCell";
        CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.delegate = self;
        [cell updateCell:comment];
        //第一个隐藏分割线
        if (indexPath.row == 0) {
            cell.separateLine.hidden = YES;
        }
        return cell;

        
    }else{
        static NSString *identifier2 = @"ReplyTableViewCell";
        ReplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:identifier2 owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.replyReferenceImageView.delegate = self;
        [cell updateCell:comment replyText:reply];
        //第一个隐藏分割线
        if (indexPath.row == 0) {
            cell.separateLine.hidden = YES;
        }
        return cell;

//        ///有回复无图片
//        if ([reply.imgUrlListArray count] == 0) {
//            static NSString *identifier3 = @"AllReplyTextCell";
//            AllReplyTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier3];
//            if (cell == nil) {
//                cell = [[[NSBundle mainBundle] loadNibNamed:identifier3 owner:nil options:nil] firstObject];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            }
//            [cell updateCell:comment replyText:reply];
//            return cell;
//            
//        }else{
//            ///有回复有图片
//            static NSString *identifier4 = @"AllReplyImageCell";
//            AllReplyImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier4];
//            if (cell == nil) {
//                cell = [[[NSBundle mainBundle] loadNibNamed:identifier4 owner:nil options:nil] firstObject];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            }
//            cell.replyReferenceImageView.delegate = self;
//            [cell updateCell:comment replyText:reply];
//            return cell;
//        }
    }

    
}

- (void)tableView:(BBGPullTable *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    textView.text = nil;
    self.replyToText = nil;
    doneBtn.tag = 200;
    BBGComment *comment = [self.commentArray ARRAY_OBJ_AT(indexPath.row)];
    self.replyToGoodsId = self.goodsId;
    
    textView.placeholder = [NSString stringWithFormat:@"回复%@：",comment.nickName];
    self.forCommentId = comment.commentId;
//    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [textView becomeFirstResponder];
//    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 9.0;
    
//    [topic reloadSubViews];
}


#pragma mark 创建回复框
- (void)creatReplyTextView{
    
    containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 54, self.view.frame.size.width, 54)];
    containerView.layer.borderWidth = 0.3;
    containerView.layer.borderColor = UIColorFromHexadecimalRGB(0xcccccc).CGColor;
    
    textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(10, 8, self.view.frame.size.width - 80, 54-8-8)];
    textView.isScrollable = NO;
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    textView.tintColor = [UIColor redColor];
    textView.textColor = UIColorFromHexadecimalRGB(0x333333);
    textView.minNumberOfLines = 1;
    textView.maxNumberOfLines = 3;
    // textView.maxHeight = 200.0f;
    textView.layer.borderWidth = 0.3;
    textView.layer.borderColor = [UIColor grayColor].CGColor;
    textView.layer.cornerRadius = 4;
    textView.returnKeyType = UIReturnKeyGo; //just as an example
    textView.font = APP_FONT(17.0);
//    textView.font = [UIFont systemFontOfSize:17.0];
    textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor whiteColor];
    textView.placeholder = @"发表评论：";
    // textView.text = @"test\n\ntest";
    // textView.animateHeightChange = NO; //turns off animation
    
    [self.view addSubview:containerView];
    
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    containerView.backgroundColor = UIColorFromHexadecimalRGB(0xf6f6f6);
    [containerView addSubview:textView];
    
    
    doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(containerView.frame.size.width - 69, 14, 63, 27);
    doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [doneBtn setTitle:@"提交" forState:UIControlStateNormal];
    doneBtn.titleLabel.font =  APP_FONT(15.0);
    doneBtn.tag = 100;
    [doneBtn setTitleColor:UIColorFromHexadecimalRGB(0xf63876) forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(resignTextView:) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setBackgroundColor:[UIColor clearColor]];
    [containerView addSubview:doneBtn];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    float temp = containerView.frame.origin.y + 2 - 64 - containerView.frame.size.height;
    topic = [[BBGTopicExplainView alloc]initWithFrame:CGRectMake(0, temp, 0, 0)];
    topic.dataArray =@[@"真漂亮",@"美美的",@"萌萌哒萌萌哒萌萌哒萌萌",@"卡哇伊",@"色彩缤纷",@"人生",@"本性",@"真漂亮",@"美美的",@"萌萌哒萌萌哒萌萌哒萌萌",@"卡哇伊",@"色彩缤纷",@"人生",@"本性",@"大海",@"天空灰",@"赞",@"大赞",@"真心赞",@"啦啦啦",@"嘿嘿嘿"];
    [topic reloadSubViews];
    [self.view addSubview:topic];
    topic.backgroundColor = [UIColor colorWithRed:247.0f/255 green:248.0f/255 blue:249.0f/255 alpha:1.0f];
    
    if (self.isFromUserCenter) {
        [containerView setHidden:YES];
        [topic setHidden:YES];

    }else{
        [containerView setHidden:NO];
        [topic setHidden:NO];

    }
    
}

#pragma mark 评论和回复
-(void)resignTextView:(UIButton *)button
{
    NSString *text = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (text.length > 0) {
    
        //现在内容长度500字内
        if (text.length > 500) {
            [[BBGLoadingTips sharedInstance] showTips:@"评论内容不能超过500字"];
        }else{
            if ([BBGSessionManager sharedInstance].isLogin) {
                //发表评论
                if (button.tag == 100) {
                    self.replyToText = text;
                    [[BBGLoadingTips sharedInstance] showLoading:@"正在发送..."];
                    
                    __weak BBGAllCommentViewController_iPhone *weakself = self;
                    [self sendEvaluate:^(BOOL sucessful, BBGResponse *response) {
                        
                        [[BBGLoadingTips sharedInstance] hideTips];
                        
                        if (sucessful) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"Text" object:text];
                            weakself.commentArray = [NSMutableArray array];
                            [weakself.commentTableView triggerPullToRefresh];
                            textView.text = nil;
//                            if (weakself.refreshListDelegate && [weakself.refreshListDelegate respondsToSelector:@selector(refreshCommetList)]) {
//                                [weakself.refreshListDelegate refreshCommetList];
//                            }
                        }
                    }];
                    
                }else{
                    //发送回复
                    self.replyToText = text;
                    [[BBGLoadingTips sharedInstance] showLoading:@"正在发送..."];
                    
                    __weak BBGAllCommentViewController_iPhone *weakself = self;
                    [self sendReply:^(BOOL sucessful, BBGResponse *response) {
                        
                        [[BBGLoadingTips sharedInstance] hideTips];
                        
                        if (sucessful) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"Text" object:text];
                            weakself.commentArray = [NSMutableArray array];
                            [weakself.commentTableView triggerPullToRefresh];
                            textView.text = nil;
//                            if (weakself.refreshListDelegate && [weakself.refreshListDelegate respondsToSelector:@selector(refreshCommetList)]) {
//                                [weakself.refreshListDelegate refreshCommetList];
//                            }
                        }
                    }];
                }

            }else {
                __weak BBGAllCommentViewController_iPhone *weakself = self;

                [[BBGSessionManager sharedInstance] doLogin:^(BOOL successful) {
                    if (successful) {
                        //发表评论
                        if (button.tag == 100) {
                            weakself.replyToText = text;
                            [[BBGLoadingTips sharedInstance] showLoading:@"正在发送..."];
                            
                            [weakself sendEvaluate:^(BOOL sucessful, BBGResponse *response) {
                                
                                [[BBGLoadingTips sharedInstance] hideTips];
                                
                                if (sucessful) {
                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"Text" object:text];
                                    weakself.commentArray = [NSMutableArray array];
                                    [weakself.commentTableView triggerPullToRefresh];
                                    textView.text = nil;
//                                    if (weakself.refreshListDelegate && [weakself.refreshListDelegate respondsToSelector:@selector(refreshCommetList)]) {
//                                        [weakself.refreshListDelegate refreshCommetList];
//                                    }
                                    [weakself.navigationController popViewControllerAnimated:YES];
                                }
                            }];
                            
                        }else{
                            //发送回复
                            weakself.replyToText = text;
                            [[BBGLoadingTips sharedInstance] showLoading:@"正在发送..."];
                            
                            [weakself sendReply:^(BOOL sucessful, BBGResponse *response) {
                                
                                [[BBGLoadingTips sharedInstance] hideTips];
                                
                                if (sucessful) {
                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"Text" object:text];
                                    weakself.commentArray = [NSMutableArray array];
                                    [weakself.commentTableView triggerPullToRefresh];
                                    textView.text = nil;
//                                    if (weakself.refreshListDelegate && [weakself.refreshListDelegate respondsToSelector:@selector(refreshCommetList)]) {
//                                        [weakself.refreshListDelegate refreshCommetList];
//                                    }
                                    [weakself.navigationController popViewControllerAnimated:YES];
                                }
                            }];
                        }

                    }
                }];
            }
        }
    }
    [textView resignFirstResponder];
}

#pragma mark -HPGrowingTextViewDelegate

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
    CGRect r = containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    containerView.frame = r;
    
    [doneBtn setCenter:CGPointMake(doneBtn.center.x, containerView.frame.size.height/2.0)];
}

- (void)growingTextViewDidEndEditing:(HPGrowingTextView *)growingTextView {
    if (self.isFromUserCenter) {
        [containerView setHidden:YES];
        [topic setHidden:YES];
    }else{
        [containerView setHidden:NO];
        [topic setHidden:NO];
    }
}

- (BOOL)growingTextViewShouldBeginEditing:(HPGrowingTextView *)growingTextView{
    [containerView setHidden:NO];
    [topic setHidden:NO];
    return YES;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}


#pragma mark - ImageCollectionViewCellDelegate
- (void)didClickedImageViewCell:(NSIndexPath *)indexPath imageArray:(NSMutableArray *)imageArray{
    BBGPhotoBrowserViewController *con = [[BBGPhotoBrowserViewController alloc] init];
    con.imgArray = imageArray;
    con.currentImgIndex = (int)indexPath.row;
    [self.navigationController presentViewController:con animated:YES completion:nil];
    
}

- (void)dealloc{
    containerView = nil;
    textView = nil;
    doneBtn = nil;
}


@end
