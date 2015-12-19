//
//  UMFeedbackViewController.m
//  UMeng Analysis
//
//  Created by liu yu on 7/12/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import "BBGUMFeedbackViewController.h"
#import "UMFeedbackTableViewCellLeft.h"
#import "UMFeedbackTableViewCellRight.h"
#import "UMContactViewController.h"
#import "HPGrowingTextView.h"
#import "BBGSpecialWebViewController_iPhone.h"

#define TOP_MARGIN 20.0f
#define kNavigationBar_ToolBarBackGroundColor  [UIColor colorWithRed:0.149020 green:0.149020 blue:0.149020 alpha:1.0]
#define kContactViewBackgroundColor  [UIColor colorWithRed:0.078 green:0.584 blue:0.97 alpha:1.0]

static UITapGestureRecognizer *tapRecognizer;

static NSInteger lineNumed;

@interface BBGUMFeedbackViewController ()<UITableViewDelegate,UITableViewDataSource,UMFeedbackDataDelegate,HPGrowingTextViewDelegate,UITextViewDelegate>
@property(nonatomic, copy) NSString *mContactInfo;
@property(nonatomic, assign) CGRect tableFrame;

@property(nonatomic,strong)UIView *inputBarBack;
@property(nonatomic,strong)UIButton *doneBtn;
@property(nonatomic,strong)HPGrowingTextView *inputView;

@end

@implementation BBGUMFeedbackViewController

@synthesize mTableView = _mTableView, mFeedbackData = _mFeedbackData;

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"意见反馈" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
    
    
    lineNumed = 0;
    
    self.view.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0];
    [self createRightBarButtonItemWithTarget:self action:@selector(callKeFu) title:@"联系客服" titleColor:UICOLOR_FONT_IMPORTANT_RED];
    
    CGRect rect = self.view.bounds;
    rect.size.height -= 54;
    self.mTableView = [[BBGPullTable alloc] initWithFrame:rect];
    [self.mTableView setDelegate:self];
    [self.mTableView setDataSource:self];
    [self.mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.mTableView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    self.mTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:self.mTableView];
    
    [self createBottomView];
    
    [self setFeedbackClient];
    [self updateTableView:nil];
    
    _shouldScrollToBottom = YES;
    

    NSString *memberId = [BBGSession sharedInstance].userInfo.memberId;
    if (![BBGTools checkStringIsBlank:memberId]) {
        memberId = [NSString stringWithFormat:@"memberID:%@",memberId];
        NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
        [infoDict DICT_SET_VK(memberId,@"plain")];
        
        NSMutableDictionary *contactDict = [NSMutableDictionary dictionary];
        [contactDict DICT_SET_VK(infoDict,@"contact")];
        
        [feedbackClient updateUserInfo:contactDict completion:^(NSError *error) {
            
        }];
    }
}

- (void)createBottomView{
    self.inputBarBack = [[UIView alloc] initWithFrame:CGRectMake(0, FRAMEH(self.view)-54, IPHONE_WIDTH, 54)];
    self.inputBarBack.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    self.inputBarBack.layer.borderWidth = 0.3;
    self.inputBarBack.layer.borderColor = UIColorFromHexadecimalRGB(0xcccccc).CGColor;
    [self.inputBarBack setBackgroundColor:UICOLOR_BACKGROUND_HILIGHT_GRAY];
    [self.view addSubview:self.inputBarBack];
    
    self.inputView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(10, 10, IPHONE_WIDTH - 80, 54-16)];
    [self.inputView setDelegate:self];
    self.inputView.isScrollable = NO;
    self.inputView.minNumberOfLines = 1;
    self.inputView.maxNumberOfLines = 3;
    self.inputView.layer.borderWidth = 0.3;
    self.inputView.layer.borderColor = [UIColor grayColor].CGColor;
    self.inputView.layer.cornerRadius = 4;
    self.inputView.layer.masksToBounds = YES;
    self.inputView.returnKeyType = UIReturnKeySend; //just as an example
    self.inputView.internalTextView.delegate = self;
    self.inputView.font = APP_FONT(17.0);
    self.inputView.placeholder = @"您的意见...";
    [self.inputView setBackgroundColor:[UIColor whiteColor]];
    [self.inputBarBack addSubview:self.inputView];
    
    self.doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.doneBtn.frame = CGRectMake(FRAMEW(self.inputBarBack) - 69, 14, 63, 27);
    self.doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [self.doneBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.doneBtn.titleLabel.font = APP_FONT(15.0);
    
    [self.doneBtn setTitleColor:UIColorFromHexadecimalRGB(0xf63876) forState:UIControlStateNormal];
    [self.doneBtn addTarget:self action:@selector(sendFeedback:) forControlEvents:UIControlEventTouchUpInside];
    [self.doneBtn setBackgroundColor:[UIColor clearColor]];
    [self.inputBarBack addSubview:self.doneBtn];
}
- (void)sendFeedback:(id)sender {
    if (![BBGTools checkStringIsBlank:self.inputView.text]) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        [dictionary setObject:self.inputView.text forKey:@"content"];
        
        [[BBGLoadingTips sharedInstance] showLoadingOnView:self.view];
        [feedbackClient post:dictionary];
        [self.inputView resignFirstResponder];
        _shouldScrollToBottom = YES;
    }else{
        [self.view endEditing:YES];
        [[BBGLoadingTips sharedInstance] showTips:@"请输入反馈内容"];
    }
}

- (void)callKeFu{
    if (![BBGLaunchManager sharedInstance].isOpenContactURL) {
        [BBGTools callPhone:@"400-888-8881" alertTitle:@"当前在线客服系统暂不可用，请电话联系客服。"];
    }else{
        [self connectServer];
    }

}

- (void)setFeedbackClient {
//    _mFeedbackData = [[NSArray alloc] init];
    feedbackClient = [UMFeedback sharedInstance];
    [feedbackClient setAppkey:UMENG_APPKEY delegate:(id <UMFeedbackDataDelegate>) self];

    
    self.mFeedbackData = feedbackClient.topicAndReplies;
    NSMutableArray *array = feedbackClient.theNewReplies;
    if ([array COUNT]) {
        [self.mFeedbackData ARRAY_ADD_OBJS_FROM_ARRAY(array)];
        if ([self.mFeedbackData count]) {
            [self.mTableView reloadData];
        }
    }
}

#pragma mark tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_mFeedbackData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *content = [[feedbackClient.topicAndReplies objectAtIndex:(NSUInteger) indexPath.row] objectForKey:@"content"];
//    CGSize labelSize = [content sizeWithStringFont:APP_FONT(14) constrainedToSize:CGSizeMake(226.0f, MAXFLOAT)];
    CGSize labelSize = [content sizeWithStringFont:APP_FONT(14) constrainedToSize:CGSizeMake(226, MAXFLOAT) lineSpacing:8.0];
    return labelSize.height + 40 + TOP_MARGIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *L_CellIdentifier = @"L_UMFBTableViewCell";
    static NSString *R_CellIdentifier = @"R_UMFBTableViewCell";

    NSDictionary *data = [self.mFeedbackData objectAtIndex:(NSUInteger) indexPath.row];

    if ([[data valueForKey:@"type"] isEqualToString:@"dev_reply"]) {
        UMFeedbackTableViewCellLeft *cell = (UMFeedbackTableViewCellLeft *) [tableView dequeueReusableCellWithIdentifier:L_CellIdentifier];
        if (cell == nil) {
            cell = [[UMFeedbackTableViewCellLeft alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:L_CellIdentifier];
        }
        double time = [[data DICT_OBJ_FOR_K(@"created_at")] doubleValue]/1000.0;
        NSString *timeStr = [BBGTools timeToString:time Format:@"YYYY-MM-dd hh:mm:ss"];
        
        NSString *content = [data DICT_OBJ_FOR_K(@"content")];
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",content]];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:8];
        [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [content length])];
        
        [cell.textLabel setAttributedText:attrStr];
        
//        cell.textLabel.text = [data DICT_OBJ_FOR_K(@"content")];
        cell.timestampLabel.text = timeStr;

        return cell;
    }else {
        UMFeedbackTableViewCellRight *cell = (UMFeedbackTableViewCellRight *) [tableView dequeueReusableCellWithIdentifier:R_CellIdentifier];
        if (cell == nil) {
            cell = [[UMFeedbackTableViewCellRight alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:R_CellIdentifier];
        }
        double time = [[data DICT_OBJ_FOR_K(@"created_at")] doubleValue]/1000.0;
        NSString *timeStr = [BBGTools timeToString:time Format:@"YYYY-MM-dd hh:mm:ss"];
        NSString *content = [data DICT_OBJ_FOR_K(@"content")];
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",content]];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:8];
        [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [content length])];
        
        [cell.textLabel setAttributedText:attrStr];
//        cell.textLabel.text = [data DICT_OBJ_FOR_K(@"content")];
        cell.timestampLabel.text = timeStr;

        return cell;

    }
}

#pragma mark Umeng Feedback delegate
- (void)getFinishedWithError: (NSError *)error{
    if (!error) {
        [self updateTableView:error];
    }
    
    if (_shouldScrollToBottom) {
        [self scrollToBottom];
    }
}
- (void)updateTableView:(NSError *)error {
    if ([self.mFeedbackData count]) {
        [self.mTableView reloadData];
    }
}

- (void)updateTextField:(NSError *)error {
    if (!error) {
        self.inputView.text = @"";
        self.inputView.text = @"";
        WS(ws)
        [feedbackClient get:^(NSError *error) {
            [ws getFinishedWithError:error];
        }];
    }
}

- (void)postFinishedWithError:(NSError *)error {
    [[BBGLoadingTips sharedInstance] hideTips];
    if (error){
        [BBGAlertView showWithTitle:@"" message:@"发送失败，请重试" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
            
        } buttonTitles:@"是", nil];
    }

    [self updateTextField:error];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollToBottom {
    if ([self.mTableView numberOfRowsInSection:0] > 1) {
        NSInteger lastRowNumber = [self.mTableView numberOfRowsInSection:0] - 1;
        NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
        [self.mTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}


#pragma makr HPGrowingTextViewDelegate
- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height{
    float diff = (growingTextView.frame.size.height - height);
    
    CGRect r = self.inputBarBack.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    self.inputBarBack.frame = r;
}

- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self sendFeedback:nil];
        return NO;
    }
    return YES;
}

- (void)dealloc {
    [feedbackClient get:^(NSError *error) {
        
    }];
    feedbackClient.delegate = nil;
}

@end
