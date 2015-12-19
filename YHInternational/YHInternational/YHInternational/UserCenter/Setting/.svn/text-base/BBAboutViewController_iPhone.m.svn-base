//
//  BBAboutViewController_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBAboutViewController_iPhone.h"
#import "BBGURLManagerViewController_iPhone.h"
#import "UIView+HideFunction.h"
#import "BBGTopicExplainView.h"
@interface BBAboutViewController_iPhone ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *logoImg;
@property (strong, nonatomic) IBOutlet UILabel *aboutInfo;
@property (strong, nonatomic) IBOutlet UILabel *versionLbl;
@end

@implementation BBAboutViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title = @"关于我们";
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"关于" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;

    self.versionLbl.text = [NSString stringWithFormat:@"V%@",APPOUTVERSION];
    
    #ifdef TEST
    NSRange range = [SERVER_URL rangeOfString:@"global.api.yunhou.com/yunhou-global-api"];
    if (range.location == NSNotFound) {
        WS(ws)
        [self.view addHideFunction:^{
            BBGURLManagerViewController_iPhone *con = [[BBGURLManagerViewController_iPhone alloc] init];
            con.title = @"切换环境";
            [ws.navigationController pushViewController:con animated:YES];
        }];
    }
    #endif
    
    UIButton *bu  =[[UIButton alloc]initWithFrame:CGRectMake(100, 100, 80, 40)];
    [bu setTitle:@"点我吧" forState:UIControlStateNormal];
    [bu setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bu];

    
    temp =568;
    topic = [[BBGTopicExplainView alloc]initWithFrame:CGRectMake(0, temp, 0, 0)];
    topic.dataArray =@[@"真漂亮",@"美美的",@"萌萌哒萌萌哒萌萌哒萌萌",@"卡哇伊",@"色彩缤纷",@"人生",@"本性",@"真漂亮",@"美美的",@"萌萌哒萌萌哒萌萌哒萌萌",@"卡哇伊",@"色彩缤纷",@"人生",@"本性",@"大海",@"天空灰",@"赞",@"大赞",@"真心赞",@"啦啦啦",@"嘿嘿嘿"];
    [topic reloadSubViews];
    [self.view addSubview:topic];
    topic.backgroundColor = [UIColor colorWithRed:247.0f/255 green:248.0f/255 blue:249.0f/255 alpha:1.0f];
    
    

    UITextField *text  = [[UITextField alloc]init];
    [self.view addSubview:text];
    text.delegate=self;
    text.backgroundColor = [UIColor whiteColor];
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
    
    
}
-(void)Clicked:(UIButton *)sender{
    [topic reloadSubViews];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [topic moveViewWithDistance:IPHONE_HEIGHT-346 animationTime:0.4];
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [topic moveViewWithDistance:IPHONE_HEIGHT animationTime:0.4];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
