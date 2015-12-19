//
//  BBGIDCardListViewController.m
//  Components
//
//  Created by holyjoy on 15/3/4.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGIDCardListViewController.h"
#import <Common.h>
@interface BBGIDCardListViewController ()
@property (nonatomic,strong)BBGIDCardListRequest *IDCardListRequest;
@property (nonatomic,strong)BBGDeleteIDCardRequest *deleteIDCardRequest;
@end

@implementation BBGIDCardListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)loadUserIDCard{
    
    if (!self.IDCardListRequest) {
        _IDCardListRequest = [[BBGIDCardListRequest alloc] init];
    }
    WS(weakSelf)
    [self.IDCardListRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        if (responseData.isError) {
            if (weakSelf.dataCallback) {
                weakSelf.dataCallback(GETALLIDCard,BBGResponseError);
            }
            return;
        }else{
            
            BBGIDCardListResponse *IDCardListResponse = (BBGIDCardListResponse *)responseData;
            weakSelf.userIDCardList = IDCardListResponse.userIDCardList;
            if (weakSelf.dataCallback) {
                weakSelf.dataCallback(GETALLIDCard,BBGResponseSuccess);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
        if (weakSelf.dataCallback) {
            weakSelf.dataCallback(GETALLIDCard,BBGResponseNetError);
        }
    }];
    
}

-(void)deleteIDCard:(NSInteger)IDCardID{
    self.deleteSuccessful = NO;
    if (!self.deleteIDCardRequest) {
        self.deleteIDCardRequest = [[BBGDeleteIDCardRequest alloc] init];
    }
    self.deleteIDCardRequest.IDCardId = IDCardID;
    
    WS(weakSelf)
    [self.deleteIDCardRequest sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
        
        if (responseData.isError) {
            if (weakSelf.dataCallback) {
                BBGDeleteIDCardResponse *deleteIDCardResponse = (BBGDeleteIDCardResponse *)responseData;
                weakSelf.deleteSuccessful = deleteIDCardResponse.deleteSuccessful;
                weakSelf.dataCallback(DELETEIDCard,BBGResponseSuccess);
            }
            return;
        }else{
            
            BBGDeleteIDCardResponse *deleteIDCardResponse = (BBGDeleteIDCardResponse *)responseData;
            
            weakSelf.deleteSuccessful = deleteIDCardResponse.deleteSuccessful;
            if (weakSelf.dataCallback) {
                weakSelf.dataCallback(DELETEIDCard,BBGResponseSuccess);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
        
        if (weakSelf.dataCallback) {
            weakSelf.dataCallback(DELETEIDCard,BBGResponseNetError);
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    self.IDCardListRequest= nil;
    self.deleteIDCardRequest = nil;
}


@end
