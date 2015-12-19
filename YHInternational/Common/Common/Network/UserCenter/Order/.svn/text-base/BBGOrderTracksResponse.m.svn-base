//
//  BBGOrderTracksResponse.m
//  Common
//
//  Created by elvis.peng on 15-5-14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderTracksResponse.h"

@implementation BBGOrderTracksResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *data;
        DATA_FOR_KEY(data, @"data");
        STRING_FOR_KEY_DATA(self.orderId, @"orderId", data)
        
        BBGResponseData *trackListData;
        DATA_FOR_KEY_DATA(trackListData, @"tracks", data)
        if (trackListData && [trackListData count]>0) {
            
            self.trackList = [NSMutableArray arrayWithCapacity:[trackListData count]];
            
            for (int i = 0; i<[trackListData count]; i++) {
                
                BBGResponseData *trackData;
                DATA_FOR_INDEX_DATA(trackData, i, trackListData)
                BBGOrderTrack *track = [[BBGOrderTrack alloc] initWithHandler:self responseData:trackData];
                [self.trackList addObject:track];
            }
            
        }
        
        
    }
    return self;
}
@end
