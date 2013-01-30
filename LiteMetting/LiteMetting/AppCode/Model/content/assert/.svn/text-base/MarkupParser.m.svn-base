//
//  MarkupParser.m
//  CoreTextMag
//
//  Created by hong pai on 13-1-15.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "MarkupParser.h"
#import <CoreText/CoreText.h>
#import "RegexKitLite.h"

@implementation MarkupParser

@synthesize imageYPositions;


- (id)init
{
    self = [super init];
    if (self) {
        NSMutableArray *array = [NSMutableArray array];
        imageYPositions = array;
    }
    return self;
}

-(NSMutableAttributedString *)ee_parserContent:(NSString *)content width:(int)contentWidth{
    
    int contentFontSize = 18;
    CTFontRef fontContent = CTFontCreateWithName((CFStringRef)@"", contentFontSize, NULL);

    CTFontRef boldFont = CTFontCreateCopyWithSymbolicTraits(fontContent, 0.0, NULL, 0, 0);
    
    NSMutableAttributedString *attriString = [[[NSMutableAttributedString alloc] init] autorelease];
    
    //加一个换行符
    
    NSString *newContent = [content stringByReplacingOccurrencesOfRegex:@"</p>" withString:@"</p>\n"];
    
    //得到所有段落的数组
    NSString *paragraphRegexStr = @"<p>[^\n]*</p>|<!--IMG#[0-9]+-->";
    NSMutableArray *paragraphArray = [NSMutableArray arrayWithArray:[newContent arrayOfCaptureComponentsMatchedByRegex:paragraphRegexStr]] ;
    
    if (paragraphArray == nil || [paragraphArray count]==0) {
        paragraphArray = [NSMutableArray array];
        [paragraphArray addObject:([NSArray arrayWithObjects:@"<p>  </p>", nil])];
    }
    
    NSLog(@"%@",paragraphArray);
    
    //初始化图片数组
    NSMutableArray *images = [NSMutableArray array];
    [images addObject:@"123.png"];
    [images addObject:@"124.png"];
    
    int len = [paragraphArray count];
    for (int i=0; i<len; i++) {
        NSString *oneElement = [[paragraphArray objectAtIndex:i] objectAtIndex:0];
        NSLog(@"%@",oneElement);
        if ([oneElement hasPrefix:@"<p>"]) {//文字
            NSString *regex = @"<[/]*p>";
            NSString *pText = [oneElement stringByReplacingOccurrencesOfRegex:regex withString:@""];
            //NSLog(@"%@",pText);
            
            CGFloat contentLineheadIndent = contentFontSize*2;
            CTParagraphStyleSetting pSeeting[1] = {{kCTParagraphStyleSpecifierFirstLineHeadIndent,sizeof(contentFontSize*2),&contentLineheadIndent}};
            
            CTParagraphStyleRef paragraphStyle1 = CTParagraphStyleCreate(pSeeting, sizeof(pSeeting));
            
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
            [dictionary setValue:(id)boldFont forKey:(NSString *)kCTFontAttributeName];
            [dictionary setValue:(id)paragraphStyle1 forKey:(NSString *)kCTParagraphStyleAttributeName];
            
            NSAttributedString *addAtrriStr = [[NSAttributedString alloc] initWithString:pText attributes:dictionary];
            [attriString appendAttributedString:addAtrriStr];
            
            
            NSAttributedString *addBlankNextLine = [[NSAttributedString alloc] initWithString:@"\n" attributes:nil];
            [attriString appendAttributedString:addBlankNextLine];
            
        }else if([oneElement hasPrefix:@"<!--IMG"]){//图片
            int Y = [self getAttributedStringHeightWithString:attriString WidthValue:contentWidth];
            NSLog(@"%d",Y);
            
            NSNumber *yyy = [NSNumber numberWithInt:Y];
            [self.imageYPositions addObject:yyy];
            
            
            NSAttributedString *addBlankNextLine = [[NSAttributedString alloc] initWithString:@"\n\n\n\n\n\n\n\n" attributes:nil];
            [attriString appendAttributedString:addBlankNextLine];
        }
    }
    
    NSLog(@"%@",self.imageYPositions);
    
    contentHeight = [self getAttributedStringHeightWithString:attriString WidthValue:contentWidth];

    //第二部分
//    CTFontRef fontref = CTFontCreateWithName((CFStringRef)@"fsadf", 28.0f, NULL);
//    //段落样式
////    CTParagraphStyleSetting linerBreakMode;
////    linerBreakMode.
//    CTTextAlignment alignment = kCTTextAlignmentCenter;
//    CTParagraphStyleSetting alignmentStyle;
//    alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;
//    alignmentStyle.value = &alignment;
//    alignmentStyle.valueSize = sizeof(alignment);
//    //kCTParagraphStyleSpecifierFirstLineHeadIndent   // 缩进？
//    
//    CTParagraphStyleSetting setting[] = {alignmentStyle};
//    
//    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(setting, sizeof(setting));
//    
//    NSMutableDictionary *stringAttributes = [NSMutableDictionary dictionary];
//    [stringAttributes setValue:(id)fontref forKey:(NSString *)kCTFontAttributeName];
//    [stringAttributes setValue:(id)paragraphStyle forKey:(NSString *)kCTParagraphStyleAttributeName];
//    NSAttributedString *aString = [[NSAttributedString alloc] initWithString:@"\n\r戮戮九州浑天黑地中万佛归宗" attributes:stringAttributes];
//    
//    [attriString appendAttributedString:aString];

    return attriString;
}














- (int)getAttributedStringHeightWithString:(NSAttributedString *)  string  WidthValue:(int) width
{
    int total_height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);    //string 为要计算高度的NSAttributedString
    CGRect drawingRect = CGRectMake(0, 0, width, 10000);  //这里的高要设置足够大
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int) origins[[linesArray count] -1].y;  //最后一行line的原点y坐标
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    total_height = 10000 - line_y + (int) descent +1;    //+1为了纠正descent转换成int小数点后舍去的值
    
    CFRelease(textFrame);
    
    return total_height;
    
}

-(int)getContentHeight{
    return contentHeight;
}


-(void)dealloc{
    self.imageYPositions = nil;
    
    [super dealloc];
}
@end
