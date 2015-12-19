//
//  BBGRegionManager.m
//  Common
//
//  Created by Damon on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRegionManager.h"
#import "BBGLaunchManager.h"
#import "BBGRegionRequest.h"
#import "BBGRegionCache.h"
#import "BaiduMap.h"
#import "BBGMacro.h"
@interface BBGRegionManager ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
@property (nonatomic,copy)BBGLaunchTaskFinished finished;

@property (nonatomic, strong) BBGRegionRequest * request;

@property (nonatomic, strong) BMKLocationService * locationService;

@property (nonatomic, strong) BMKGeoCodeSearch * geoSearch;
@end

@implementation BBGRegionManager

DECLARE_SINGLETON(BBGRegionManager)

-(void)startLocation{
    if (!SIMULATOR) {
        
        self.locationSuccess = NO;
        _locationService = [[BMKLocationService alloc] init];
        _locationService.delegate = self;
        [_locationService startUserLocationService];
        [[NSUserDefaults standardUserDefaults]setObject:@(1) forKey:@"location"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)endLocation{
    [_locationService stopUserLocationService];
    self.locationService = nil;
}



- (void)loadLocalRegion{
//    if (!SIMULATOR) {
//        [self startLocation];
//    }
    
    /**
     *  @author Damon, 15-03-11 10:03:59
     *
     *  处理打开的数据
     *
     */
    if (![[BBGLaunchManager sharedInstance].areaVersion  isEqualToString:[BBGConfiguration sharedInstance].areaVersion] && [BBGLaunchManager sharedInstance].areaVersion.intValue >= 0) {
        TICK_START

        NSString * documentsPath = @"";
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        documentsPath = [documentsPath stringByAppendingPathComponent:[paths objectAtIndex:0]];
        
        ZipArchive* zip = [[ZipArchive alloc] init];
        
        NSString * zipFile = [[NSBundle mainBundle]pathForResource:@"AddressResource" ofType:@"zip"];
        NSString* unZipTo = documentsPath ;
        if( [zip UnzipOpenFile:zipFile] ){
            BOOL result = [zip UnzipFileTo:unZipTo overWrite:YES];
            if( NO==result ){
                //添加代码
                if (self.finished) {
                    self.finished(NO);
                }
            }else{
                NSData * data = [[NSData alloc]initWithContentsOfFile:[[zip unzippedFiles] objectAtIndex:0]];
                NSError * error;
                NSFileManager *fileManager = [NSFileManager defaultManager];
                [fileManager removeItemAtPath:[[zip unzippedFiles] objectAtIndex:0] error:&error];
                if (error) {
                    if (self.finished) {
                        self.finished(NO);
                    }
                }else{
                    BBGRegionResponse * regionResponse = [[BBGRegionResponse alloc]initWithData:data format:ResponseDataFormatJson];
                    if (regionResponse.isError) {
                        if (self.finished) {
                            self.finished(NO);
                        }
                    }else{
                        if (regionResponse.regionList && [regionResponse.regionList count]>0) {


                            [BBGConfiguration sharedInstance].areaVersion = [BBGLaunchManager sharedInstance].areaVersion;
                            
                            [BBGCache removeCacheForKey:KEYREGIONS];
                            [BBGCache addCache:KEYREGIONS obj:regionResponse.regionList type:BBGCacheTypeRegions];
                            [BBGRegionManager sharedInstance].regionList = regionResponse.regionList;
                            [BBGConfiguration sharedInstance].areaVersion = [BBGLaunchManager sharedInstance].areaVersion;
                            self.regionTask = YES;
                            if (self.finished) {
                                self.finished(self.regionTask);
                            }
                        }else{
                            if (self.finished) {
                                self.finished(NO);
                            }
                        }
                    }
                }
            }
            [zip UnzipCloseFile];
        }
        TICK_END

    }
    
    
    
//    if ([BBGCache queryCache:KEYREGIONS]) {
//        [BBGRegionManager sharedInstance].regionList = [BBGCache queryCache:KEYREGIONS];
//        self.regionTask = YES;
        if (self.finished) {
            self.finished(YES);
        }
    
    
//    }
    
}

- (void)loadDBRegion{
    
    WS(weakSelf)
    
    if (![[BBGLaunchManager sharedInstance].areaVersion isEqualToString:[BBGConfiguration sharedInstance].areaVersion] && [BBGLaunchManager sharedInstance].areaVersion.intValue > 0) {
        //版本不同，进行更新
        
        _request = [[BBGRegionRequest alloc] init];
        _request.version = [BBGConfiguration sharedInstance].areaVersion;
        [_request sendWithSuccessBlock:^(AFHTTPRequestOperation *operation, BBGResponse *responseData) {
            
            BBGRegionResponse * response = (BBGRegionResponse *)responseData;
            
            BOOL isComplete = [BBGRegionCache updateDB:response.operatorList];
            if (isComplete) {
                [BBGConfiguration sharedInstance].areaVersion = [BBGLaunchManager sharedInstance].areaVersion;
                weakSelf.finished(YES);
            }
            
            return;
        } failure:^(AFHTTPRequestOperation *operation, NSString *errorMsg, NSString *errorCode) {
            //更新请求失败
            weakSelf.finished(YES);
            return;
        }];
        
        
    }
    
    if ([BBGLaunchManager sharedInstance].areaVersion.intValue == 0) {
        //首页请求失败
        self.finished(YES);
        return;
    }
    
    self.finished(YES);
}

#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
//    CLGeocoder *_coder = [[CLGeocoder alloc] init];
//    CLLocation *loc = [[CLLocation alloc] initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
//    [_coder reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        for (CLPlacemark *mark in placemarks) {
//
//            [self endLocation];
//            NSLog(@"本地定位:%@",mark.name);
////            self.currentPositionLabel.text = mark.name;
//        }
//    }];
    
    BMKReverseGeoCodeOption * reverseGeo = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeo.reverseGeoPoint = userLocation.location.coordinate;
    
    _geoSearch = [[BMKGeoCodeSearch alloc]init];
    _geoSearch.delegate = self;
        
    if ([_geoSearch reverseGeoCode:reverseGeo]) {
        NSLog(@"定位成功");
    }else{
        NSLog(@"定位失败");
    }
    
    
    //NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

#pragma mark - BMKGeoCodeSearchDelegate
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{    
    self.province = result.addressDetail.province;
    self.city = result.addressDetail.city;
    self.district = result.addressDetail.district;
    
    self.locationSuccess = YES;
    
    [self endLocation];
    
}

#pragma mark - BBGLaunchTask
- (void)launchTask:(BBGLaunchTaskFinished)finished{
    //处理地址数据
    self.finished = finished;
    self.regionTask = YES;
    [self loadDBRegion];
}

- (NSString *)taskName{
    return @"地址库管理";
}

- (void)dealloc{
    self.geoSearch.delegate = nil;
}

@end
