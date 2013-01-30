//
//  ExpertCell.m
//  LiteMetting
//
//  Created by hong pai on 13-1-24.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "ExpertCell.h"
#import "UIColor+expanded.h"

@implementation ExpertCell

@synthesize lab_summary,lab_titleName,image_poster;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - 设置 表格里面的 数据 -
-(void)ee_setContentdata:(NSMutableDictionary *)dictionary{
    track();
    [super ee_setContentdata:dictionary];
    
    
    NSString *title = [dictionary objectForKey:@"SpeakerName"];
    NSString *summary = [dictionary objectForKey:@"SpeakerSummery"];
    NSString *poster = [dictionary objectForKey:@"SpeakerImage"];
    
    lab_titleName.text = title;
    lab_summary.text = summary;
    
    image_poster.contentMode = UIViewContentModeScaleAspectFit;
    image_poster.imageURL = [NSURL URLWithString:poster];
    
    BOOL isReaded = [[dictionary objectForKey:@"IsReaded"] boolValue];
    if (isReaded) {
        [self ee_setCellContentColor_Readed];
    }else{
        [self ee_setCellContentColor_Noraml];
    }
    
    //是否需要重新刷新位置
    if (poster==nil || [poster isEqualToString:@""]) {
        [self refreshUIControlerPosition:lab_titleName];
        [self refreshUIControlerPosition:lab_summary];
    }
}


#pragma mark - 设置 颜色 -
-(void)ee_setCellContentColor_Noraml{
    self.lab_titleName.textColor             = [UIColor colorWithRGBHex:color_noraml_black];
    self.lab_titleName.highlightedTextColor  = [UIColor colorWithRGBHex:color_noraml_black];
    
    self.lab_summary.textColor               = [UIColor colorWithRGBHex:color_noraml_gray];
    self.lab_summary.highlightedTextColor    = [UIColor colorWithRGBHex:color_noraml_gray];
}


-(void)ee_setCellContentColor_Readed{
    self.lab_titleName.textColor             = [UIColor colorWithRGBHex:color_noraml_gray];
    self.lab_titleName.highlightedTextColor  = [UIColor colorWithRGBHex:color_noraml_gray];
    
    self.lab_summary.textColor               = [UIColor colorWithRGBHex:color_noraml_gray];
    self.lab_summary.highlightedTextColor    = [UIColor colorWithRGBHex:color_noraml_gray];
}


#pragma mark - 调整位置 -
-(void)refreshUIControlerPosition:(UIView *)targetview{
    CGRect tRect = targetview.frame;
    tRect.origin.x = ee_CellLeftSpace;
    tRect.size.width = self.frame.size.width - ee_CellLeftSpace *2;
    
    [targetview setFrame:tRect];
}


-(void)dealloc{
    track();
    [image_poster release];
    [lab_summary release];
    [lab_titleName release];
    
    
    [super dealloc];
}
@end
