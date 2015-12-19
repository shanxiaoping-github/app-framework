//
//  BBGMyCommentViewController_iPhone.m
//  YHInternational
//
//  Created by Holyjoy on 15/4/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGMyCommentViewController_iPhone.h"
#import "BBGCommentSectionHeaderView_iPhone.h"
#import "BBGCommentSectionFooterView_iPhone.h"
#import "BBGMyCommentTextCell.h"
#import "BBGMyCommentImageCell.h"
#import "BBGReplyTextCell.h"
#import "BBGReplyImageCell.h"

#import "CommentTableViewCell.h"
#import "ReplyTableViewCell.h"

#import "UnCommentCell.h"
#import "BBGPullTable.h"
#import "HPGrowingTextView.h"
#import "BBGAllCommentViewController_iPhone.h"
#import "BBGUnEvaluateGoodsListViewController_iPhone.h"
#import "BBGGoodsDetailViewController_iPhone.h"

#import "IQKeyboardManager.h"
#import "BBGCommentedGoods.h"
#import "BBGReply.h"

#import "BBGTopicExplainView.h"

@interface BBGMyCommentViewController_iPhone ()<UITableViewDelegate,UITableViewDataSource,HPGrowingTextViewDelegate,PullDelegate,ImageCollectionViewCellDelegate,BBGUnCommentCellDelegate,BBGCommentRefreshListPtotocol,BBGCellPopupViewDelegate>
{
    UIView *containerView;
    HPGrowingTextView *textView;
    UIButton *doneBtn;
    
    BBGTopicExplainView  *topic;
}
@property (nonatomic,strong) BBGPullTable *commentTableView;
@property (nonatomic,assign) BOOL showForComment;
@end

@implementation BBGMyCommentViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"评论晒单";
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    
    self.view.backgroundColor = [UIColor whiteColor];
    _commentTableView = [[BBGPullTable alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _commentTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    _commentTableView.backgroundColor = [UIColor whiteColor];
    _commentTableView.dataSource = self;
    _commentTableView.delegate = self;
    _commentTableView.pullDelegate = self;
    _commentTableView.notOpenSticky = YES;
    _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_commentTableView];
    
//    /**
//     时间轴
//     */
//    UIImageView *timeLineImgView  = [[UIImageView alloc] initWithFrame:CGRectMake(21, 0, 1, self.view.bounds.size.height + 10000)];
//    timeLineImgView.backgroundColor = UIColorFromHexadecimalRGB(0xc8c7cc);
//
//    [self.commentTableView addSubview:timeLineImgView];
//    [self.commentTableView sendSubviewToBack:timeLineImgView];
    
    self.commentedGoodsArray = [NSMutableArray array];
        
    __weak BBGMyCommentViewController_iPhone *weakself = self;
    [_commentTableView loadMore:^(id data) {
        [weakself requestCommentedGoodsList:weakself.pageIndex];
    }];
    
    [_commentTableView refreshData:^(id data) {
        weakself.commentedGoodsArray = [NSMutableArray array];
        weakself.canLoadMore = YES;
        [weakself requestCommentedGoodsList:1];
    }];
    [_commentTableView triggerPullToRefresh];

    [self creatReplyTextView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCommetList) name:@"Text" object:nil] ;
}

- (void)requestCommentedGoodsList:(NSInteger)tempPageIndex{
    self.showForComment = NO;
    self.pageIndex = tempPageIndex;
    WS(weakSelf)
    [self updateData:^(BOOL sucessful, BBGResponse *response) {
        
        [weakSelf.commentTableView stopAnimationWithCompletion:^{
            [[BBGLoadingTips sharedInstance] hideTips];
            [weakSelf.defaultView dismiss];
            
            if (sucessful) {
                weakSelf.showForComment = YES;

                BBGCommentListResponse *responseData = (BBGCommentListResponse *)response;
                if ([responseData.commentedGoodsList count]) {
                    weakSelf.pageIndex += 1;
                    [weakSelf.commentTableView reloadData];
                }else{
                    //当正好20条评论的时候，只有第一次请求无数据时才显示默认页
                    if (weakSelf.pageIndex == 1) {
                        CGPoint offset = weakSelf.noCommentGoodsNumber == 0? CGPointZero:CGPointMake(0, 81);
                        [weakSelf showDefaultViewWithStampImage:[UIImage imageNamed:@"NullComment"]  tips:@"还没有评论..." target:weakSelf actionTitle:nil action:nil WithResponseResult:BBGResponseNotData offset:offset onView:weakSelf.commentTableView];
                    }
                }
                weakSelf.commentTableView.showsInfiniteScrolling = weakSelf.canLoadMore;

            }else{
                
                [weakSelf showDefaultViewWithStampImage:nil tips:@"您的网络不给力，请检查下您的网络设置" target:weakSelf.commentTableView actionTitle:@"重新加载" action:@selector(triggerPullToRefresh)
                                     WithResponseResult:BBGResponseNetError offset:CGPointZero onView:weakSelf.view];
            }
            
            
            [weakSelf.commentTableView stopAnimation];
        }];
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    
    WS(ws)
    [self getCommentDetailCount:^(BOOL sucessful, BBGResponse *response) {
        if ([ws.commentedGoodsArray count]) {
            [ws dismissDefaultView];
        }
        if (sucessful) {
            [ws.commentTableView reloadData];
            
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}

- (void)actionOfCancel{
    
    [self dismissViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PullDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView headerView:(NSInteger)section{
    
    if (section == 0) {
        return [[UITableViewCell alloc] init];
    }else{
        BBGCommentSectionHeaderView_iPhone *headerView = [[[NSBundle mainBundle] loadNibNamed:@"BBGCommentSectionHeaderView_iPhone" owner:nil options:nil] firstObject];
        BBGCommentedGoods *commentedGoods = [self.commentedGoodsArray ARRAY_OBJ_AT(section-1)];
        [headerView.goodsImageView sd_setImageWithURL:[NSURL URLWithString:commentedGoods.goodsImgUrl]];
        headerView.goodsDescLabel.text = commentedGoods.goodsName;
        headerView.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@",commentedGoods.goodsPrice];
        
        /**
         *  @author holyjoy, 15-06-04 10:06:08
         *
         *  点击section跳转到商品详情
         */
        __weak BBGMyCommentViewController_iPhone *weakself = self;
        headerView.headerBlock = ^(){
            
            BBGGoodsDetailViewController_iPhone *goodsDetailConTrl = [[BBGGoodsDetailViewController_iPhone alloc] init];
            goodsDetailConTrl.goodsId = commentedGoods.goodsId;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView footerView:(NSInteger)section{
    
    if (section == 0){
        return [[UITableViewCell alloc] init];
        
    }else{
        BBGCommentSectionFooterView_iPhone *footerView = [[[NSBundle mainBundle] loadNibNamed:@"BBGCommentSectionFooterView_iPhone" owner:nil options:nil] firstObject];
        footerView.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);

        BBGCommentedGoods *commentedGoods = [self.commentedGoodsArray ARRAY_OBJ_AT(section-1)];
        /**
         *  @author holyjoy, 15-05-06 15:05:27
         *
         *  点击footview全部按钮跳转事件
         *
         *  @return 跳转到全部评论页
         */
        __weak BBGMyCommentViewController_iPhone *weakself = self;
        footerView.block = ^(){
            
            BBGAllCommentViewController_iPhone *nextConTrl = [[BBGAllCommentViewController_iPhone alloc] init];
            nextConTrl.title = @"全部评论";
            nextConTrl.goodsId = commentedGoods.goodsId;
            nextConTrl.goodsDesc = commentedGoods.goodsName;
            nextConTrl.goodsImgString = commentedGoods.goodsImgUrl;
            nextConTrl.goodsPrice = commentedGoods.goodsPrice;
            nextConTrl.isFromUserCenter = YES;
//            nextConTrl.refreshListDelegate = self;
            [weakself.navigationController pushViewController:nextConTrl animated:YES];
        };
        
        UITableViewCell *footerCell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,footerView.frame.size.height)];
        [footerCell addSubview:footerView];
        [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(footerCell).with.offset(0);
            make.right.equalTo(footerCell).with.offset(0);
            make.top.equalTo(footerCell).with.offset(0);
            make.bottom.equalTo(footerCell).with.offset(0);
        }];
        return footerCell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightOfHeaderView:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 0;
    }else {
        return 82;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightOfFooterView:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 0;
    }else {
        return 50;
    }
}

#pragma mark - BBGTableViewDataSource And BBGTableViewDelegate Methods
- (NSInteger)numberOfSectionsInTableView:(BBGTableView *)tableView {
    
    return [self.commentedGoodsArray count] + 1;
}

- (NSInteger)tableView:(BBGTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.noCommentGoodsNumber == 0) {
            return 0;
        }else if(self.showForComment){
            return 1;
        }else{
            return 0;
        }
        
    }else {
        if ([self.commentedGoodsArray count] > 0) {
            BBGCommentedGoods *commentedGood = [self.commentedGoodsArray ARRAY_OBJ_AT(section-1)];
            self.commentArray = commentedGood.commentList;
            return [self.commentArray count];
        }else{
            return 0;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 62;
    }else{
        if ([self.commentedGoodsArray count] > 0) {
            BBGCommentedGoods *commentedGood = [self.commentedGoodsArray ARRAY_OBJ_AT(indexPath.section-1)];
            self.commentArray = commentedGood.commentList;
            BBGComment *comment = [self.commentArray ARRAY_OBJ_AT(indexPath.row)];
            BBGReply *reply = comment.replyFor;
//            if (comment.replyFor.replyText.length == 0) {
//                if ([comment.imgUrlListArray count] == 0) {
//                    ///无回复无图片
//                    return [BBGMyCommentTextCell cellHeignt:comment];
//                }else{
//                    ///无回复有图片
//                    return [BBGMyCommentImageCell cellHeignt:comment];
//                }
//            }else{
//                if ([reply.imgUrlListArray count] == 0) {
//                    ///有回复无图片
//                    return [BBGReplyTextCell cellHeignt:comment replyText:reply];
//                }else{
//                    ///有回复有图片
//                    return [BBGReplyImageCell cellHeignt:comment replyText:reply];
//                }
//            }
            if (comment.replyFor.replyText.length == 0) {
                return [CommentTableViewCell cellHeignt:comment];
            }else{
                return [ReplyTableViewCell cellHeignt:comment replyText:reply];
//                if ([reply.imgUrlListArray count] == 0) {
                    ///有回复无图片
//                    return [BBGReplyTextCell cellHeignt:comment replyText:reply];
//                }else{
//                    ///有回复有图片
//                    return [BBGReplyImageCell cellHeignt:comment replyText:reply];
//                }
            }
        }else{
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (indexPath.section == 0) {
        static NSString *identifier0 = @"UnCommentCell";
        UnCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier0];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:identifier0 owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        cell.showUnCommentLabel.text = [NSString stringWithFormat:@"你有%ld个购买过的商品未晒单,快点分享下你的使用感受吧！",(long)self.noCommentGoodsNumber];
        
        //关键字飘红
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:cell.showUnCommentLabel.text];
        NSString *keyword = [[NSString stringWithFormat:@"%ld",(long)self.noCommentGoodsNumber] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSRange range = [cell.showUnCommentLabel.text rangeOfString:keyword];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        cell.showUnCommentLabel.attributedText = attrString;

        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        BBGCommentedGoods *commentedGood = [self.commentedGoodsArray ARRAY_OBJ_AT(indexPath.section-1)];
        self.commentArray = commentedGood.commentList;
        BBGComment *comment = [self.commentArray ARRAY_OBJ_AT(indexPath.row)];
        BBGReply *reply = comment.replyFor;
        ///是否有回复
        if (comment.replyFor.replyText.length == 0) {
//            ///无回复且无图片
//            if ([comment.imgUrlListArray count] == 0) {
//                static NSString *identifier1 = @"BBGMyCommentTextCell";
//                BBGMyCommentTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
//                if (cell == nil) {
//                    cell = [[[NSBundle mainBundle] loadNibNamed:identifier1 owner:nil options:nil] firstObject];
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//                }
//                [cell updateCell:comment];
//                cell.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
//                return cell;
//            }else{
//                ///无回复但有图片
//                static NSString *identifier2 = @"BBGMyCommentImageCell";
//                BBGMyCommentImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
//                if (cell == nil) {
//                    cell = [[[NSBundle mainBundle] loadNibNamed:identifier2 owner:nil options:nil] firstObject];
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//                }
//                cell.delegate = self;
//                [cell updateCell:comment];
//                cell.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
//                return cell;
//            }
                static NSString *identifier = @"CommentTableViewCell";
                CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] firstObject];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;

                }
                cell.delegate = self;
                [cell updateCell:comment];
            
                cell.menuHandleView.indexPath = indexPath;
                cell.menuHandleView.delegate = self;
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
            
            cell.menuHandleView.indexPath = indexPath;
            cell.menuHandleView.delegate = self;
            //第一个隐藏分割线
            if (indexPath.row == 0) {
                cell.separateLine.hidden = YES;
            }
            return cell;
//            ///有回复无图片
//            if ([reply.imgUrlListArray count] == 0) {
//                static NSString *identifier3 = @"BBGReplyTextCell";
//                BBGReplyTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier3];
//                if (cell == nil) {
//                    cell = [[[NSBundle mainBundle] loadNibNamed:identifier3 owner:nil options:nil] firstObject];
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//                }
//                [cell updateCell:comment replyText:reply];
//                cell.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
//
//                return cell;
//                
//            }else{
//                ///有回复有图片
//                static NSString *identifier4 = @"BBGReplyImageCell";
//                BBGReplyImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier4];
//                if (cell == nil) {
//                    cell = [[[NSBundle mainBundle] loadNibNamed:identifier4 owner:nil options:nil] firstObject];
//                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//                }
//                cell.replyReferenceImageView.delegate = self;
//                [cell updateCell:comment replyText:reply];
//                cell.backgroundColor = UIColorFromHexadecimalRGB(0xf0efed);
//                return cell;
//            }
        }
    }

}

- (void)tableView:(BBGPullTable *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (indexPath.section) {
//        textView.text = nil;
//        BBGCommentedGoods *commentedGoods = [self.commentedGoodsArray ARRAY_OBJ_AT(indexPath.section-1)];
//        BBGComment *comment = [commentedGoods.commentList ARRAY_OBJ_AT(indexPath.row)];
//        
//        self.replyToGoodsId = commentedGoods.goodsId;
//        textView.placeholder = [NSString stringWithFormat:@"回复%@：",comment.nickName];
//        self.forCommentId = comment.commentId;
//        [textView becomeFirstResponder];
    
//        [topic reloadSubViews];
//    }
}

#pragma mark 创建回复框
- (void)creatReplyTextView{
    
    containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 54, self.view.frame.size.width, 54)];
    containerView.layer.borderWidth = 0.3;
    containerView.layer.borderColor = UIColorFromHexadecimalRGB(0xcccccc).CGColor;
    containerView.layer.cornerRadius = 4;
    
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
    textView.returnKeyType = UIReturnKeyGo;
    textView.font = APP_FONT(17.0);
//    textView.font = [UIFont systemFontOfSize:17.0];
    textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);

    textView.backgroundColor = [UIColor whiteColor];
    textView.placeholder = @"回复钟大帅：";
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
    doneBtn.titleLabel.font = APP_FONT(15.0);
    
    [doneBtn setTitleColor:UIColorFromHexadecimalRGB(0xf63876) forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(resignTextView) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setBackgroundColor:[UIColor clearColor]];
    [containerView addSubview:doneBtn];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [containerView setHidden:YES];
    
    float temp = containerView.frame.origin.y + 2 - 64 - containerView.frame.size.height;
    topic = [[BBGTopicExplainView alloc]initWithFrame:CGRectMake(0, temp, 0, 0)];
    topic.dataArray =@[@"真漂亮",@"美美的",@"萌萌哒萌萌哒萌萌哒萌萌",@"卡哇伊",@"色彩缤纷",@"人生",@"本性",@"真漂亮",@"美美的",@"萌萌哒萌萌哒萌萌哒萌萌",@"卡哇伊",@"色彩缤纷",@"人生",@"本性",@"大海",@"天空灰",@"赞",@"大赞",@"真心赞",@"啦啦啦",@"嘿嘿嘿"];
    [topic reloadSubViews];
    [self.view addSubview:topic];
    topic.backgroundColor = [UIColor colorWithRed:247.0f/255 green:248.0f/255 blue:249.0f/255 alpha:1.0f];
    [topic setHidden:YES];
}

#pragma mark 评论回复
-(void)resignTextView
{
    NSString *text = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if (text.length > 0) {
        
        //现在内容长度500字内
        if (text.length > 500) {
            [[BBGLoadingTips sharedInstance] showTips:@"内容不能超过500字哦"];
        }else{
            //发送回复
            self.replyToText = text;
            [[BBGLoadingTips sharedInstance] showLoading:@"正在发送..."];
            __weak BBGMyCommentViewController_iPhone *weakself = self;
            
            [self sendReply:^(BOOL sucessful, BBGResponse *response) {
                
                if (sucessful) {
                    weakself.commentedGoodsArray = [NSMutableArray array];
                    [weakself.commentTableView triggerPullToRefresh];
                }
            }];

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
    
    [topic moveViewWithDistance:containerView.frame.origin.y animationTime:1.0];
}

- (void)growingTextViewDidEndEditing:(HPGrowingTextView *)growingTextView {
    
    [containerView setHidden:YES];
    [topic setHidden:YES];
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


#pragma mark BBGUnCommentCellDelegate
- (void)didClickedShowGoodsBtn {
    
    BBGUnEvaluateGoodsListViewController_iPhone *unEvaluateCtrl = [[BBGUnEvaluateGoodsListViewController_iPhone alloc] init];
    [self.navigationController pushViewController:unEvaluateCtrl animated:YES];
}

#pragma mark BBGCommentRefreshListPtotocol
- (void)refreshCommetList{
    [_commentTableView triggerPullToRefresh];
}

#pragma mark BBGCellPopupViewDelegate
- (void)popupView:(BBGCellPopupView *)popupView didSeletedAtIndex:(NSInteger)index cellIndexPath:(NSIndexPath *)cellIndex{

    
    //index 0:点赞 1：评论
        if (index == 0) {
            
            
        }else if (index == 1){
            textView.text = nil;
            BBGCommentedGoods *commentedGoods = [self.commentedGoodsArray ARRAY_OBJ_AT(cellIndex.section-1)];
            BBGComment *comment = [commentedGoods.commentList ARRAY_OBJ_AT(cellIndex.row)];
            
            self.replyToGoodsId = commentedGoods.goodsId;
            textView.placeholder = [NSString stringWithFormat:@"回复%@：",comment.nickName];
            self.forCommentId = comment.commentId;
            [textView becomeFirstResponder];
            
            //            [topic reloadSubViews];

        }

}

//移除通知
- (void)dismissViewController{
    [super dismissViewController];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Text" object:nil];
}

- (void)dealloc{
    containerView = nil;
    textView = nil;
    doneBtn = nil;
    topic = nil;
}

@end
