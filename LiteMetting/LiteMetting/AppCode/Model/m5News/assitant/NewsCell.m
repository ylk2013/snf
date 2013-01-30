//
//  NewsCell.m
//  LiteMetting
//
//  Created by hong pai on 13-1-13.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

@synthesize imageICO;//,lab_expertDetail,lab_expertName;
@synthesize lab_newsTitle,lab_newsSummary;


@synthesize dataDictionary = _dataDictionary;

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
    self.dataDictionary = dictionary;
    
    NSString *newsName = [dictionary objectForKey:@"title"];
    NSString *newsSummary = [dictionary objectForKey:@"summary"];
    NSString *newsPortrait = [dictionary objectForKey:@"portrait"];
    
    lab_newsTitle.text = newsName;
    lab_newsSummary.text = newsSummary;
    
    imageICO.contentMode = UIViewContentModeScaleAspectFit;
    imageICO.image = [UIImage imageNamed:newsPortrait];
    
    //    //UIImage *nimg = [UIImage imageNamed:@"listbtn1.png"];
    //    UIImage *simg = [UIImage imageNamed:@"listbtn2.png"];
    //
    //    //UIImageView *normal = [[UIImageView alloc] initWithImage:nimg];
    //    UIImageView *select = [[UIImageView alloc] initWithImage:simg];
    //
    //    //self.backgroundView = normal;
    //    self.selectedBackgroundView = select;
    self.selectionStyle = UITableViewCellSelectionStyleGray;
}



-(void)dealloc{
    [self.imageICO release];
    
    [self.lab_newsSummary release];
    [self.lab_newsTitle release];
    
    [self.dataDictionary release];
    
    [super dealloc];
}



@end