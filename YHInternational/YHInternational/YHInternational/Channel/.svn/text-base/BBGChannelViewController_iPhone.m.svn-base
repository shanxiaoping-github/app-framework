//
//  BBGChannelViewController_iPhone.m
//  BuBuGao
//
//  Created by elvis.peng on 14-8-26.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGChannelViewController_iPhone.h"
#import "BBGContentFactory_iPhone.h"

@interface BBGChannelViewController_iPhone ()
@end

@implementation BBGChannelViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIViewController<BBGContentProtocol> *)buildContentByMenuItem:(BBGMenuItem *)item{
    
    return [[BBGContentFactory_iPhone sharedInstance] buildContentByMenuItem:item];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
