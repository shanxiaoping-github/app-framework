//
//  BBGGoodsTimeCell.m
//  YHInternational
//
//  Created by 彭腾 on 15-5-6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsTimeCell.h"
#import "BBGGoodsPlaceDetailCell.h"
#import "BBGGoodsTip.h"

@implementation BBGGoodsTimeCell

- (void)awakeFromNib {
    // Initialization code
//    _bottomBorder = [CALayer layer] ;
//    _bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height-0.5f, IPHONE_WIDTH, 0.5f) ;
//    _bottomBorder.backgroundColor = [UIColorFromHexadecimalRGB(0xcccccc) CGColor] ;
//    [self.layer addSublayer:_bottomBorder] ;
    self.contentView.backgroundColor = UICOLOR_BACKGROUND_GRAYLIGHT ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 27 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView registerNib:[UINib nibWithNibName:@"BBGGoodsPlaceDetailCell" bundle:nil] forCellReuseIdentifier:@"BBGGoodsPlaceDetail"] ;
    BBGGoodsPlaceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGoodsPlaceDetail"] ;
    BBGGoodsTip *goodsTip = [self.dataArr objectAtIndex:indexPath.row] ;
    cell.timeLab.text = [NSString stringWithFormat:@"%@: %@",goodsTip.tipTitle,goodsTip.titContent] ;
    return cell ;
}

@end
