//
//  BBGQrCodeViewController_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGQrCodeViewController_iPhone.h"
#import "BBGQRContentViewController_iPhone.h"
#import "BBGGoodsDetailViewController_iPhone.h"
#import "BBGNavigationController.h"
#import "BBGSpecialWebViewController_iPhone.h"
@interface BBGQrCodeViewController_iPhone ()

@end

@implementation BBGQrCodeViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"扫描二维码";
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WIDTH / 2 - 50, 0, 100, 44)] ;
    label.text = @"扫描二维码" ;
    label.font = APP_FONT_DEMI_LIGHT(18.0f) ;
    label.textColor = [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    self.navigationItem.titleView = label ;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //打开二维码扫码
    [self reStartScan];
}


- (void)scanCodeSuccessWithOutputMetadataObjects:(NSArray *)metadataObjects{

    NSString *content = nil;
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        content = obj.stringValue;
        NSLog(@"扫码内容：%@",content);
        
        //H5地址模板：http://m.yunhou.com/item/9580000248.html
        //PC地址模板：http://item.yunhou.com/9801000229.html
        NSString *trialString = @"m.yunhou.com/item";
        NSString *productId = nil;
        
        if ([content rangeOfString:trialString].location != NSNotFound) {
            NSArray *contentArray = [content componentsSeparatedByString:@"/"];
            if (contentArray.count > 0) {
                NSString *productContentString = [contentArray lastObject];
                NSArray *productArray = [productContentString componentsSeparatedByString:@"."];
                productId = [productArray ARRAY_OBJ_AT(0)];
            }
        }
        
        if (productId) {
            NSLog(@"%@",productId);
            BBGGoodsDetailViewController_iPhone *goodsDetailViewController = [[BBGGoodsDetailViewController_iPhone alloc] init];
            goodsDetailViewController.productId = productId;
            BBGNavigationController *nav = [[BBGNavigationController alloc] initWithRootViewController:goodsDetailViewController];
            [self presentViewController:nav animated:YES completion:nil];
        }else{
            
            NSRange findUrl =[content rangeOfString:@"http://" options:NSCaseInsensitiveSearch];
            NSRange findUrls =[content rangeOfString:@"https://" options:NSCaseInsensitiveSearch];
            BOOL find = findUrls.length>0 || findUrl.length>0;
            
            NSURL *url = [NSURL URLWithString:content];
            if (find>0 && url) {
                BBGSpecialWebViewController_iPhone *specialWebViewController = [[BBGSpecialWebViewController_iPhone alloc] initWithURL:url];
                specialWebViewController.title = @"二维码地址";
                [self.navigationController pushViewController:specialWebViewController animated:YES];
            }else{
                BBGQRContentViewController_iPhone *qrContentViewController = [[BBGQRContentViewController_iPhone alloc] init];
                qrContentViewController.showQrcontent = content;
                [self.navigationController pushViewController:qrContentViewController animated:YES];
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
