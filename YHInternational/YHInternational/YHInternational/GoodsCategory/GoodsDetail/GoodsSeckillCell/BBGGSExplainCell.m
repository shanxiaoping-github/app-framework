//
//  BBGGSExplainCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/10/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGSExplainCell.h"
#import "BBGGSExplainDetailCell.h"

@interface BBGGSExplainCell ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) BBGGSSeckillModel *seckillModel;

@end

@implementation BBGGSExplainCell

+ (CGFloat)cellHeight:(BBGGSSeckillModel *)model {
    NSString *string = model.desc;
    CGSize size = [string sizeWithStringFont:APP_FONT(13.0f) constrainedToSize:CGSizeMake(IPHONE_WIDTH-14, 10000)];
    return size.height + 8 + 35.0f;
}

- (void)updateCellWith:(BBGGSSeckillModel *)seckillModel {
    self.seckillModel = seckillModel;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView registerNib:[UINib nibWithNibName:@"BBGGSExplainDetailCell" bundle:nil] forCellReuseIdentifier:@"BBGGSExplainDetail"];
    BBGGSExplainDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGSExplainDetail"];
    [cell updateCellWith:self.seckillModel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([BBGGSExplainDetailCell cellHeight:self.seckillModel]>20) {
        return [BBGGSExplainDetailCell cellHeight:self.seckillModel];
    }else {
        return 20.0f;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
