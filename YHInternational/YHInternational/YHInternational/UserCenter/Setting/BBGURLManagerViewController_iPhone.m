//
//  BBGURLManagerViewController_iPhone.m
//  YHInternational
//
//  Created by yangjie on 15/6/26.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGURLManagerViewController_iPhone.h"

@interface BBGURLManagerViewController_iPhone ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *urlArray;
@property (strong, nonatomic) UITableView *urlTableView;
@end

@implementation BBGURLManagerViewController_iPhone

- (void)viewDidLoad{
    _urlArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"93:9250" forKey:@"title"];
    [dict setObject:@"http://10.200.51.93:9250/bubugao-global-api" forKey:@"value"];
    [_urlArray addObject:dict];
    
    dict = [NSMutableDictionary dictionary];
    [dict setObject:@"104:8080" forKey:@"title"];
    [dict setObject:@"http://10.200.51.104:8080/bubugao-mobile-api" forKey:@"value"];
    [_urlArray addObject:dict];
    
    dict = [NSMutableDictionary dictionary];
    [dict setObject:@"113:8867" forKey:@"title"];
    [dict setObject:@"http://10.200.51.113:8867/bubugao-global-api" forKey:@"value"];
    [_urlArray addObject:dict];
    
    dict = [NSMutableDictionary dictionary];
    [dict setObject:@"113:9250" forKey:@"title"];
    [dict setObject:@"http://10.200.51.113:9250/bubugao-global-api" forKey:@"value"];
    [_urlArray addObject:dict];
    
    dict = [NSMutableDictionary dictionary];
    [dict setObject:@"158:8867" forKey:@"title"];
    [dict setObject:@"http://10.200.51.158:8867/bubugao-global-api" forKey:@"value"];
    [_urlArray addObject:dict];
    
    dict = [NSMutableDictionary dictionary];
    [dict setObject:@"168:9240" forKey:@"title"];
    [dict setObject:@"http://10.200.51.168:9240/bubugao-global-api" forKey:@"value"];
    [_urlArray addObject:dict];
    
    dict = [NSMutableDictionary dictionary];
    [dict setObject:@"168:9250" forKey:@"title"];
    [dict setObject:@"http://10.200.51.168:9250/bubugao-global-api" forKey:@"value"];
    [_urlArray addObject:dict];
    
    dict = [NSMutableDictionary dictionary];
    [dict setObject:@"181:8867" forKey:@"title"];
    [dict setObject:@"http://10.200.52.181:8867/yunhou-globao-api" forKey:@"value"];
    [_urlArray addObject:dict];
    
    dict = [NSMutableDictionary dictionary];
    [dict setObject:@"218.76.52.6:8885" forKey:@"title"];
    [dict setObject:@"http://218.76.52.6:8885/bubugao-global-api" forKey:@"value"];
    [_urlArray addObject:dict];
    
    dict = [NSMutableDictionary dictionary];
    [dict setObject:@"global.test" forKey:@"title"];
    [dict setObject:@"http://global.api.yunhou.com/bugao-global-apirvice" forKey:@"value"];
    [_urlArray addObject:dict];
    
    dict = [NSMutableDictionary dictionary];
    [dict setObject:@"global.api.yunhou.com" forKey:@"title"];
    [dict setObject:@"http://global.api.yunhou.com/yunhou-global-api" forKey:@"value"];
    [_urlArray addObject:dict];
    
    
    _urlTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [_urlTableView setDelegate:self];
    [_urlTableView setDataSource:self];
    [self.view addSubview:_urlTableView];
}



#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(BBGTableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(BBGTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_urlArray COUNT];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndex = @"urlManagertableCellIndex";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndex];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndex];
    }
    NSDictionary *dict = [_urlArray ARRAY_OBJ_AT(indexPath.row)];
    NSString *url = [dict DICT_OBJ_FOR_K(@"title")];
    NSString *value = [dict DICT_OBJ_FOR_K(@"value")];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell.textLabel setText:url];
    if ([value isEqualToString:SERVER_URL]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WS(ws)
    [BBGAlertView showWithTitle:nil message:@"确定要切换环境？" handler:^(BBGAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex==0) {
            
            NSDictionary *dict = [_urlArray ARRAY_OBJ_AT(indexPath.row)];
            NSString *url = [dict DICT_OBJ_FOR_K(@"value")];
            SERVER_URL = url;
            if ([BBGSession sharedInstance].isLogin) {
                [[BBGSessionManager sharedInstance] doLogout:^(BOOL successful) {
                    [BBGJumpManager sharedInstance].tabBarController.selectedIndex = 0;
                    [BBGCartManager sharedInstance].cartCount = @(0);
                    [ws dismissViewControllerAnimated:YES completion:nil];
                }];
            }else{
                [ws dismissViewControllerAnimated:YES completion:nil];
            }
            
        }
    } buttonTitles:@"确定", nil];
    
    
}


@end
