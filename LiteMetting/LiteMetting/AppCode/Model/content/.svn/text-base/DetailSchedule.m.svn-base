//
//  DetailSchedule.m
//  LiteMetting
//
//  Created by hong pai on 13-1-13.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "DetailSchedule.h"
#import "ScheduleCell.h"

@interface DetailSchedule ()

@end

@implementation DetailSchedule


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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawContent{
    [super drawContent];
    
    trace(@"%@",contentDictionary);
    NSArray *speakers = [contentDictionary objectForKey:@"spe"];
    
    int curContentHeight = [(UIScrollView *)self.view contentSize].height;
    
    if (speakers!=nil) {
        int len = [speakers count];
        for (int i=0; i<len; i++) {
            NSDictionary *oneSpeaker = [speakers objectAtIndex:i];
            ScheduleCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ScheduleCell" owner:nil options:nil] objectAtIndex:0];
            
        }
    }
    
    trace(@"speakers:%@",speakers);
    trace(@"123333");

}



#pragma mark - 回收 -
-(void)dealloc{
    track();
    [super dealloc];
}


@end
