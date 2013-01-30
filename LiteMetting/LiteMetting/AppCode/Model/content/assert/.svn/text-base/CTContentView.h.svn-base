//
//  CTContentView.h
//  LiteMetting
//
//  Created by hong pai on 13-1-26.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "MarkupParser.h"

@interface CTContentView : UIView{
    NSString *drawContent;
    int selfWidth;
    
    NSMutableArray *imageYPositions;
    
    CGPoint selfPosition;
    
    MarkupParser *attriParser;
    NSMutableAttributedString *attriString;
}

- (id)initWithContent:(NSString *)content position:(CGPoint)position width:(int)width;

@end
