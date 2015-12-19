//
//  BBGUserRegion.m
//  Common
//
//  Created by elvis.peng on 14-8-21.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGUserRegion.h"

@implementation BBGUserRegion
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.province = [aDecoder decodeObjectForKey:@"province"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.district = [aDecoder decodeObjectForKey:@"district"];
        self.street = [aDecoder decodeObjectForKey:@"street"];
        self.provinceID = [aDecoder decodeObjectForKey:@"provinceID"];
        self.cityID = [aDecoder decodeObjectForKey:@"cityID"];
        self.districtID = [aDecoder decodeObjectForKey:@"districtID"];
        self.streetID = [aDecoder decodeObjectForKey:@"streetID"];
        self.selfName = [aDecoder decodeObjectForKey:@"selfName"];
        self.selfId = [aDecoder decodeObjectForKey:@"selfId"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.district forKey:@"district"];
    [aCoder encodeObject:self.street forKey:@"street"];
    [aCoder encodeObject:self.provinceID forKey:@"provinceID"];
    [aCoder encodeObject:self.cityID forKey:@"cityID"];
    [aCoder encodeObject:self.districtID forKey:@"districtID"];
    [aCoder encodeObject:self.streetID forKey:@"streetID"];
    [aCoder encodeObject:self.selfName forKey:@"selfName"];
    [aCoder encodeObject:self.selfId forKey:@"selfId"];
}

-(NSString *)defaultAreaInfo{
    
    NSString* address =[NSString stringWithFormat:@"%@%@%@%@",self.province,self.city,self.district,self.street];
    return address;

}

//--------团购地址数据-----------

-(NSString *)tgRequestArea{

    NSString * tg_area =[NSString stringWithFormat:@"%@_%@_%@_%@",
                        self.provinceID,self.cityID,self.districtID,self.streetID];
    return tg_area;
}

-(NSString *)tgAreaInfo{
    
    NSString * tg_area_info =[NSString stringWithFormat:@"%@_%@_%@_%@:%@_%@_%@_%@",
                              self.province,self.city,self.district,self.street,self.provinceID,self.cityID,self.districtID,self.streetID];
    return tg_area_info;
}

-(NSString *)tgArea{

    NSString * tg_area =[NSString stringWithFormat:@"mainland:%@/%@/%@/%@:%@", self.province,self.city,self.district,self.street,self.streetID];
    return tg_area;
}

-(NSString *)tgSelfText{
    NSString * tg_self_Text =[NSString stringWithFormat:@"%@_%@,%@,%@,%@",self.selfId,self.provinceID,self.cityID,self.districtID,self.streetID];
    return tg_self_Text;
}

-(NSString *)tgAddress{
    NSString* tg_address =[NSString stringWithFormat:@"%@%@%@%@%@",self.province,self.city,self.district,self.street,self.selfName];
    return tg_address;
}


@end
