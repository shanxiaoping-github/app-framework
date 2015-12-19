//
//  BBGConfigureResponse.m
//  Common
//
//  Created by Damon on 15/5/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGConfigureResponse.h"
@implementation BBGConfigureResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData * responseData;
        DATA_FOR_KEY(responseData, @"data")
        
        BBGResponseData * global;
        DATA_FOR_KEY_DATA(global, @"global", responseData)
        
        for (int i = 0; i < [global count]; i++) {
            BBGResponseData * globalItemData;
            DATA_FOR_INDEX_DATA(globalItemData, i, global)
            NSString * paramKey ;
            STRING_FOR_KEY_DATA(paramKey, @"paramKey", globalItemData)
            
            if ([paramKey isEqualToString:@"rongcloud_UId"]) {
                //融云Id
                STRING_FOR_KEY_DATA(self.rongCloudId, @"paramValue", globalItemData)

            }else if([paramKey isEqualToString:@"rongcloud_result"]){
                //融云token
                BBGResponseData * resultData;
                DATA_FOR_KEY_DATA(resultData, @"paramValue", globalItemData)
                NSString * resultStr = resultData.stringValue;
                NSArray * array = [resultStr componentsSeparatedByString:@"\\\""];
                NSString * token = array[9];
                self.token = token;
            }
        }
        
        /*!
         *  广告图
         */
        BBGResponseData * adData;
        DATA_FOR_KEY_DATA(adData, @"load", responseData)
        
        BBGLaunchModel * model;
        
        for(int i = 0; i < [adData count]; i++){
            BBGResponseData * adItemData;
            DATA_FOR_INDEX_DATA(adItemData, i, adData)
            model = [[BBGLaunchModel alloc]initWithHandler:self responseData:adItemData];

        }
        
        
        self.launchModel = model;
        
        /*!
         *  启动参数
         */
        BBGResponseData * bmmsData;
        DATA_FOR_KEY_DATA(bmmsData, @"bmms", responseData)
        
        for (int i = 0; i < [bmmsData count]; i++) {
            BBGResponseData * bmmsItemData;
            DATA_FOR_INDEX_DATA(bmmsItemData, i, bmmsData)
            BOOL isIos = NO;
            BOOL_FOR_KEY_DATA(isIos, @"isIos", bmmsItemData)
            if (isIos) {
                NSString * str ;
                STRING_FOR_KEY_DATA(str, @"name", bmmsItemData)
                
                if ([str isEqualToString:@"firstBenifitSwitch"]) {
                    NSInteger firstBenifitSwitch;
                    INTEGER_FOR_KEY_DATA(firstBenifitSwitch, @"value", bmmsItemData)
                    self.firstBenifitSwitch = firstBenifitSwitch;
                }
                if ([str isEqualToString:@"addressVersion"]) {
                    NSString * areaVer = @"";
                    STRING_FOR_KEY_DATA(areaVer, @"value", bmmsItemData)
                    self.areaVersion = areaVer.integerValue;
                }
                if ([str isEqualToString:@"openUpdateSwitch"]) {
                    NSInteger openUpdateSwitch;
                    INTEGER_FOR_KEY_DATA(openUpdateSwitch, @"value", bmmsItemData)
                    self.openUpdateSwitch = openUpdateSwitch;
                }
                if ([str isEqualToString:@"payBenifitSwitch"]) {
                    NSInteger payBenifitSwitch;
                    INTEGER_FOR_KEY_DATA(payBenifitSwitch, @"value", bmmsItemData)
                    self.payBenifitSwitch = payBenifitSwitch;
                }
                
                if ([str isEqualToString:@"URL_CONTACT"]) {
                    NSString *url;
                    STRING_FOR_KEY_DATA(url, @"value", bmmsItemData)
                    self.contactURL = url;
                }
                if ([str isEqualToString:@"URL_Diaper_area"]) {
                    NSString *url;
                    STRING_FOR_KEY_DATA(url, @"value", bmmsItemData)
                    self.diaperAreaURL = url;
                }
                if ([str isEqualToString:@"URL_Milk_powder_area"]) {
                    NSString *url;
                    STRING_FOR_KEY_DATA(url, @"value", bmmsItemData)
                    self.milkPowderAreaURL = url;
                }
                if ([str isEqualToString:@"URL_Domestic_sales"]) {
                    NSString *url;
                    STRING_FOR_KEY_DATA(url, @"value", bmmsItemData)
                    self.domesticSalesURL = url;
                }
                if ([str isEqualToString:@"URL_Free_sale"]) {
                    NSString *url;
                    STRING_FOR_KEY_DATA(url, @"value", bmmsItemData)
                    self.freeSaleURL = url;
                }
                if ([str isEqualToString:@"URL_Genuine_guarantee"]) {
                    NSString *url;
                    STRING_FOR_KEY_DATA(url, @"value", bmmsItemData)
                    self.genuineGuaranteeURL = url;
                }
                if ([str isEqualToString:@"URL_Global_direct_mining"]) {
                    NSString *url;
                    STRING_FOR_KEY_DATA(url, @"value", bmmsItemData)
                    self.globalDirectMiningURL = url;
                }
                if ([str isEqualToString:@"URL_Telecom_Flow"]) {
                    NSString *url;
                    STRING_FOR_KEY_DATA(url, @"value", bmmsItemData)
                    self.telecomFlowURL = url;
                }
                if ([str isEqualToString:@"THEME_RESOURCE_NAME"]) {
                    NSString *name;
                    STRING_FOR_KEY_DATA(name, @"value", bmmsItemData)
                    self.themeName = name;
                }
                if ([str isEqualToString:@"PAY_ACTIVITY_SWITCH"]) {
                    NSInteger payActivitySwitch;
                    INTEGER_FOR_KEY_DATA(payActivitySwitch, @"value", bmmsItemData)
                    self.payActivitySwitch = payActivitySwitch;
                }
                if ([str isEqualToString:@"PAY_ACTIVITY_TITLE"]) {
                    NSString *text;
                    STRING_FOR_KEY_DATA(text, @"value", bmmsItemData)
                    self.payActivityTitle = text;
                }
                if ([str isEqualToString:@"PAY_ACTIVITY_URL"]) {
                    NSString *url;
                    STRING_FOR_KEY_DATA(url, @"value", bmmsItemData)
                    self.payActivityURL = url;
                }
                if ([str isEqualToString:@"PAY_ACTIVITY_IMAGE"]) {
                    NSString *url;
                    STRING_FOR_KEY_DATA(url, @"value", bmmsItemData)
                    self.payActivityImage = url;
                }
                if ([str isEqualToString:@"URL_DOOR_SWITCH"]) {
                    NSInteger urlDoorSwitch;
                    INTEGER_FOR_KEY_DATA(urlDoorSwitch, @"value", bmmsItemData)
                    self.urlDoorSwitch = urlDoorSwitch;
                }
                if ([str isEqualToString:@"URL_DOOR_TITLE"]) {
                    NSString *text;
                    STRING_FOR_KEY_DATA(text, @"value", bmmsItemData)
                    self.urlDoorTitle = text;
                }
                if ([str isEqualToString:@"URL_DOOR"]) {
                    NSString *url;
                    STRING_FOR_KEY_DATA(url, @"value", bmmsItemData)
                    self.URL_DOOR = url;
                }
                if ([str isEqualToString:@"URL_DOOR_IMAGE"]) {
                    NSString *url;
                    STRING_FOR_KEY_DATA(url, @"value", bmmsItemData)
                    self.urlDoorImage = url;
                }
                if ([str isEqualToString:@"SEARCH_DIALOG_TXT"]) {
                    NSString *text;
                    STRING_FOR_KEY_DATA(text, @"value", bmmsItemData)
                    self.searchText = text;
                }
                
                if ([str isEqualToString:@"URL_CONTACT_ZHICHI"]) {
                    NSString *url;
                    STRING_FOR_KEY_DATA(url, @"value", bmmsItemData)
                    BOOL_FOR_KEY_DATA(self.isOpenContactURL, @"isIos", bmmsItemData)
                }
            }
        }
        
    }
    return self;
}


@end
