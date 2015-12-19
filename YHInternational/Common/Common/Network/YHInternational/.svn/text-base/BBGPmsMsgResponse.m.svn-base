//
//  BBGPmsMsgResponse.m
//  Common
//
//  Created by elvis.peng on 15-5-19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPmsMsgResponse.h"

@implementation BBGPmsMsgResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        
        /*!
         *  公告
         */
        BBGResponseData *responseData;
        DATA_FOR_KEY(responseData, @"data");

        NSMutableArray * announcementArray = [NSMutableArray array];
        for (int i = 0; i < [responseData count]; i++) {
            BBGResponseData * announcementData;
            DATA_FOR_INDEX_DATA(announcementData, i, responseData)
            NSString * announcementInfo;
            STRING_FOR_KEY_DATA(announcementInfo, @"info", announcementData)
            [announcementArray addObject:announcementInfo];
        }
        self.pmsList = announcementArray;
        
//        BBGResponseData *responseData;
//        if (data && [data count]>0) {
//            
//            self.pmsList = [NSMutableArray arrayWithCapacity:[data count]];
//            for (int i =0 ; i<[data count]; i++) {
//                BBGResponseData *pmsData;
//                DATA_FOR_INDEX_DATA(pmsData, i, data);
//                BBGPmsMessage *pmsMsg = [[BBGPmsMessage alloc] initWithHandler:self responseData:pmsData];
//                [self.pmsList addObject:pmsMsg];
//            }
//            
//        }
        
        
    }
    return self;
}
@end
