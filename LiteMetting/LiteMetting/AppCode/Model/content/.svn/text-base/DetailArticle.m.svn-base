//
//  ContentArticle.m
//  LiteMetting
//
//  Created by hong pai on 13-1-11.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "DetailArticle.h"
#import "LiteMettingViewController.h"
#import "UIView+EEExtras.h"
#import "Tools_DispatchWebRequest.h"
#import "NSDate+convenience.h"
#import "UIColor+expanded.h"
#import "NSString+EEExtras.h"
#import "CTContentView.h"
#import "SBJson.h"

@interface DetailArticle ()

@end

@implementation DetailArticle

int MarginX = 10;

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


#pragma mark - 设置内容 -
-(void)ee_questDetail_ByCellConfig:(NSDictionary *)_cellConfig modalconfig:(NSDictionary *)_modalconfig{
    track();

    [super ee_questDetail_ByCellConfig:_cellConfig modalconfig:_modalconfig];
    
    //本地是否存在
    NSString *localJsonFileName = [self checkJsonFileIsInSqliteDatebase];
    if (localJsonFileName) {
        BOOL isInDisk = [self checkJsonFileIsInLocalDisk:localJsonFileName];
        if (isInDisk) {
            //读取本地
            [self readLocalJsonFile:localJsonFileName];
        }else{
            //请求网络
            [self readWebJSonFile];
        }
    }else{
        //请求网络
        [self readWebJSonFile];
    }
}


#pragma mark - 本地 获取detail -
-(void)readLocalJsonFile:(NSString *)jsonFileName{
    track();

    //获取文本
    NSString *jsonfilecompath = [EE_JsonDetailFilePath stringByAppendingPathComponent:jsonFileName];
    NSString *jsonString = [[NSString stringWithContentsOfFile:jsonfilecompath encoding:NSUTF8StringEncoding error:nil] retain];
    //转成NSDictionary
    contentDictionary = [[jsonString JSONValue] retain];
    
    trace(@"%@",contentDictionary);
    
    //设置detail
    MarkID markId = [[modalConfig objectForKey:@"MarkID"] intValue];
    if (markId == MarkID_MeetSchedul) {
        detailString = [NSMutableString stringWithString:[((NSString *)[[contentDictionary objectForKey:@"sch"] objectForKey:@"scheduleDetail"]) ee_trim]];
        timeString = [[[contentDictionary objectForKey:@"sch"] objectForKey:@"scheduleBeginTime"] stringByAppendingFormat:@" - %@",[[contentDictionary objectForKey:@"sch"] objectForKey:@"scheduleEndTime"]];
    }else if(markId == MarkID_Expert){
        detailString = [NSMutableString stringWithString:[((NSString *)[[contentDictionary objectForKey:@"spe"] objectForKey:@"speakerDetail"]) ee_trim]];
        timeString = nil;
    }else{
        detailString = [NSMutableString stringWithString:[((NSString *)[[contentDictionary objectForKey:@"news"] objectForKey:@"newsContent"]) ee_trim]];
        timeString = [[contentDictionary objectForKey:@"news"] objectForKey:@"newsTime"];
    }
    
    if(![detailString hasPrefix:@"<p>"]) {
        [detailString insertString:@"<p>" atIndex:0];
    }
    if(![detailString hasSuffix:@"</p>"]){
        [detailString appendString:@"</p>"];
    }
    
    [detailString retain];
    
    //画文本
    [self drawContent];
}

-(NSString *)checkJsonFileIsInSqliteDatebase{
    
    int SID         = [[cellConfig objectForKey:@"SID"]  intValue];
    NSString *detailJsonFileName = [Tools_DispatchWebRequest ee_dispatchGetDetailJSonFile_modalConfig:modalConfig SID:SID];
    trace(@"%@",detailJsonFileName);
    
    if (detailJsonFileName == nil || [detailJsonFileName isEqualToString:@""]) {
        return nil;
    }
    return detailJsonFileName;
}

#pragma mark - 网络 获取detail -
-(void)readWebJSonFile{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    webServiceRequest = [Tools_DispatchWebRequest ee_dispatchGetWebDetailRequest:modalConfig cellConfig:cellConfig delegate:self finish:@selector(request_detail_success:) failed:@selector(request_detail_failed:)];
}

-(void)request_detail_success:(ASIHTTPRequest *)request{
    NSString *responseString = request.responseString;
    
    if ([responseString hasPrefix:@"{"] || [responseString hasPrefix:@"["]) {
        
        trace(@"%@",responseString);
        
        [self processWebDetailResult:responseString];
    }
    
    webServiceRequest = nil;
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)request_detail_failed:(ASIHTTPRequest *)request{
    trace(@"%d , %@",request.responseStatusCode,request.responseString);
    
    
    webServiceRequest = nil;
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


-(void)processWebDetailResult:(NSString *)responseString{
    NSString *newJsonFileName = [NSDate ee_getUniqueString];
    trace(@"%@",newJsonFileName);
    //1、保存进sqlite数据库
    int sid = [[cellConfig objectForKey:@"SID"] intValue];
    BOOL isSaveSuccess = [Tools_DispatchWebRequest ee_dispatch_updateDetalJsonFileName:modalConfig SID:sid jsonFileName:newJsonFileName];
    //2、保存到磁盘
    if (isSaveSuccess) {
        NSString *jsonfilecompath = [EE_JsonDetailFilePath stringByAppendingPathComponent:newJsonFileName];
        
        [self checkJsonFileIsInLocalDisk:newJsonFileName];
        
        BOOL aaa = [responseString writeToFile:jsonfilecompath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        trace(@"保存到本地磁盘 : %@",aaa?@"成功":@"失败");
    }
    
    //3、read and draw
    [self readLocalJsonFile:newJsonFileName];
}



#pragma mark - json文件检测 -
-(BOOL)checkJsonFileIsInLocalDisk:(NSString *)jsonFileName{
    BOOL isFolderExist = [[NSFileManager defaultManager] fileExistsAtPath:EE_JsonDetailFilePath];
    if (!isFolderExist) {
        BOOL isCreateSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:EE_JsonDetailFilePath withIntermediateDirectories:NO attributes:nil error:nil];
        trace(@"%@",isCreateSuccess?@"创建 Caches/detail 成功":@"创建 Caches/detail 失败");
    }
    
    NSString *compeletePath = [EE_JsonDetailFilePath stringByAppendingPathComponent:jsonFileName];
    trace(@"-------检测文件是否存在：%@",compeletePath);
    
    BOOL isJsonFileExist = [[NSFileManager defaultManager] fileExistsAtPath:compeletePath ];
    
    trace(@"-------%@",isJsonFileExist?@"存在":@"不存在");
    
    return isJsonFileExist;
}



#pragma mark - 画内容 -
-(void)drawContent{
    track();
    //ee_DetailTitleHeight
    //1A、标题
    NSString *title = [cellConfig objectForKey:[self titleKey]];
    titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(MarginX, 0, self.view.frame.size.width-MarginX*2, 60)] autorelease];
//    [titleLabel setBackgroundColor:[UIColor redColor]];
    titleLabel.numberOfLines = 0;
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor colorWithRGBHex:color_noraml_black]];
    titleLabel.text = [title ee_trim];
    [self.view addSubview:titleLabel];
    
    //1B、时间
    UILabel *timeLabel = nil;
    if (timeString) {
        timeLabel = [[[UILabel alloc] initWithFrame:CGRectMake(MarginX, titleLabel.frame.size.height, self.view.frame.size.width-MarginX*2, 20)] autorelease];
//        [timeLabel setBackgroundColor:[UIColor grayColor]];
        timeLabel.numberOfLines = 0;
        [timeLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [timeLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [timeLabel setTextAlignment:NSTextAlignmentCenter];
        [timeLabel setTextColor:[UIColor colorWithRGBHex:color_noraml_gray]];
        timeLabel.text = [timeString ee_trim];
        [self.view addSubview:timeLabel];
    }else{
        [titleLabel ee_viewToDown:10];
    }
    
    //1C、分割线
    int filledheight = titleLabel.frame.origin.y + titleLabel.frame.size.height + timeLabel.frame.size.height;
    
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detailseqlinebg.png"]];
    [imageview setFrame:CGRectMake(MarginX, filledheight+(ee_DetailTitleHeight-filledheight)*0.5, (self.view.frame.size.width-MarginX*2), 2)];
    [self.view addSubview:imageview];
//    
//    UIView *view1 = [[[UIView alloc] initWithFrame:CGRectMake(MarginX, filledheight+(ee_DetailTitleHeight-filledheight)*0.5, (self.view.frame.size.width-MarginX*2), 1)] autorelease];
//    [view1 setBackgroundColor:[UIColor colorWithRGBHex:0xCBCBCB]];
//    UIView *view2 = [[[UIView alloc] initWithFrame:CGRectMake(MarginX, filledheight+(ee_DetailTitleHeight-filledheight)*0.5+2, (self.view.frame.size.width-MarginX*2), 1)] autorelease];
//    [view2 setBackgroundColor:[UIColor colorWithRGBHex:0xFDFDFD]];
//    [self.view addSubview:view1];
//    [self.view addSubview:view2];
    
    //3、画内容
    ctContentView = [[CTContentView alloc] initWithContent:detailString position:CGPointMake(MarginX, ee_DetailTitleHeight) width:(self.view.frame.size.width-MarginX*2)];
    [self.view addSubview:ctContentView];
    [ctContentView setBackgroundColor:[UIColor clearColor]];
    
    //4、
    
    
    //计算容器高度
    [(UIScrollView *)self.view setContentSize:CGSizeMake(self.view.frame.size.width, ee_DetailTitleHeight+ctContentView.frame.size.height)];
}




-(NSString *)titleKey{
    MarkID markid = [[modalConfig objectForKey:@"MarkID"] intValue];
    NSString *key;
    if (markid == MarkID_Expert ) {//专家
        key = @"SpeakerName";
    }else if(markid == MarkID_MeetSchedul ){//日程
        key = @"ScheduleName";
    }else{
        key = @"NewsTitle";
    }
    
    return key;
}

#pragma mark - 回收 -
-(void)dealloc{
    track();
    
    
    if (webServiceRequest) {
        [webServiceRequest.request cancel];
        webServiceRequest._delegate = nil;
        webServiceRequest = nil;
    }

    
    [ctContentView removeFromSuperview];
    [ctContentView release];
    ctContentView = nil;
    
    [detailString release];
    detailString = nil;
    
    [contentDictionary release];
    contentDictionary = nil;
    
    
    [super dealloc];
}






















@end
