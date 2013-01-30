//
//  CTContentView.m
//  LiteMetting
//
//  Created by hong pai on 13-1-26.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "CTContentView.h"
#import "MarkupParser.h"

@implementation CTContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithContent:(NSString *)content position:(CGPoint)position width:(int)width
{
    self = [super initWithFrame:CGRectMake(position.x, position.y, width, 100)];
    if (self) {
        // Initialization code
        drawContent = content;
        
        selfWidth = width;
        
        selfPosition = position;
        
        //得到NSMutableAttributedString
        if (content ==nil) {
            content = @"<p>无内容</p>";
        }
        MarkupParser *parser = [[MarkupParser alloc] init];
        attriString = [[parser ee_parserContent:drawContent width:selfWidth] retain];
        imageYPositions = [parser.imageYPositions retain];
        
        int selfHeight = [parser getContentHeight];
        
        [self setFrame:CGRectMake(selfPosition.x,selfPosition.y, selfWidth, selfHeight)];
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{

    
    
    [super drawRect:rect];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGRect drawSize = self.bounds;
    //    drawSize = CGRectMake(0,0,selfWidth, 300);
    CGPathAddRect(path, NULL, drawSize);
    
    
    CTFramesetterRef ctframesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attriString);
    
    CTFrameRef ctframe = CTFramesetterCreateFrame(ctframesetter, CFRangeMake(0, attriString.length), path, NULL);
    
    CTFrameDraw(ctframe, context);
    
    //
    CFRelease(ctframesetter);
    CFRelease(ctframe);
    CFRelease(path);
    
    //重新设置尺寸
    //[self setFrame:CGRectMake(selfPosition.x,selfPosition.y, selfWidth, selfHeight)];
    
    //加入图片
    [self inserImages];

}



-(void)inserImages{
    for (int i=0; i<[imageYPositions count]; i++) {
        int y = [[imageYPositions objectAtIndex:i] intValue];
        
        UIImageView *imgview = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"123.png"]] autorelease];
        imgview.contentMode = UIViewContentModeScaleAspectFit;
        
        [imgview setFrame:CGRectMake(0, y+11, selfWidth, 100)];
        [self addSubview:imgview];
        //[imgview setBackgroundColor:[UIColor redColor]];
        
    }
}


-(void)dealloc{
    track();

    [attriParser release];
    attriParser = nil;
    
    [attriString release];
    attriString = nil;
    
    [imageYPositions release];
    imageYPositions = nil;
    
    
    [super dealloc];
}
















@end
