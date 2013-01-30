//
//  ExpertCell.m
//  LiteMetting
//
//  Created by hong pai on 13-1-9.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "ExpertCell.h"
#import "UIColor+expanded.h"

@implementation ExpertCell

@synthesize imageICO,lab_expertDetail,lab_expertName;


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        imageICO.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}
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
    

    NSString *expertName = [dictionary objectForKey:@"title"];
    NSString *expertSummary = [dictionary objectForKey:@"summary"];
    NSString *expertPortrait = [dictionary objectForKey:@"portrait"];
    
    lab_expertName.text = expertName;
    
    imageICO.contentMode = UIViewContentModeScaleAspectFit;
    imageICO.image = [UIImage imageNamed:expertPortrait];
    
    lab_expertDetail.text = expertSummary;
    
//    [select release];
    [self ee_setCellContentColor_Noraml];
}


#pragma mark - 设置 颜色 -
-(void)ee_setCellContentColor_Noraml{
    lab_expertName.textColor = [UIColor colorWithRGBHex:color_noraml_black];
    lab_expertDetail.textColor = [UIColor colorWithRGBHex:color_noraml_gray];
}

-(void)ee_setCellContentColor_Readed{
    lab_expertName.textColor = [UIColor colorWithRGBHex:color_noraml_gray];
    lab_expertDetail.textColor = [UIColor colorWithRGBHex:color_noraml_gray];
}


-(void)dealloc{
    track();
    [imageICO release];
    [lab_expertDetail release];
    [lab_expertName release];
    
    [super dealloc];
}






@end
