
#define DEBUG 1
#ifdef DEBUG
#define trace(format,...) NSLog(format,##__VA_ARGS__)
#else
#define trace(format,...)
#endif

#define DEBUGX 1

#define DEBUG 1
#ifdef DEBUG
#define track() NSLog(@"%s",__FUNCTION__)
#else
#define track()
#endif

//是否是iphone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define EE_JsonDetailFilePath [NSString stringWithFormat:@"%@/Library/Caches/detail",NSHomeDirectory()]

#define EE_APP_Types_Path [[NSBundle mainBundle] pathForResource:@"config_app_modal_types" ofType:@"plist"]
//#define EE_SqlitePath [[NSBundle mainBundle] pathForResource:@"litemeeting" ofType:@"sqlite"]
#define EE_SqlitePath [NSString stringWithFormat:@"%@/Library/Caches/litemeeting.sqlite",NSHomeDirectory()]

#define EE_APP_Infor_Path [NSString stringWithFormat:@"%@/Library/Caches/config_appinfor.plist",NSHomeDirectory()]

#define EE_TableRefreshHistory [NSString stringWithFormat:@"%@/Library/Caches/refresh_history.plist",NSHomeDirectory()]

#define ee_AppSize [[UIScreen mainScreen] bounds].size
#define ee_AppStatusHeight 20
#define ee_AppDetailControllerHeight 44

#define ee_CellLeftSpace 15
#define ee_DetailTitleHeight 100

typedef enum{
    MarkID_None,
    MarkID_MeetSchedul,
    MarkID_Expert,
    MarkID_News,
    MarkID_Notice,
    MarkID_Map,
    MarkID_Around,
    MarkID_Partners,
    MarkID_ImageWall,
    MarkID_OtherInfor,
    MarkID_MySchedul,
    MarkID_TableModal1,
    
}MarkID;

typedef enum{
    Cell_Type_General = 0,//普通的  cell：ListGeneralCell.m
}Cell_Type;


typedef enum{
    DataResource_Type_News = 0,//普通的  cell：ListGeneralCell.m
    DataResource_Type_Schedul,
    DataResource_Type_Expert,
    DataResource_Type_Favorite,
    DataResource_Type_Map,
    DataResource_Type_Notice,
    DataResource_Type_ImagesWall,
    DataResource_Type_Partners,
    DataResource_Type_OtherInfor,
    DataResource_Type_Setting,
}DataResource_Type;








//list 视图可移动的方向
typedef enum{
    AppListPanDirect_None,
    AppListPanDirect_OnlyShowLeft,
    AppListPanDirect_OnlyShowRight,
    AppListPanDirect_LeftAndRight,
}AppListPanDirect;






#pragma mark - 颜色值

#define color_noraml_black         0x121212
#define color_noraml_gray         0x808080

#define color_pageControl_circle 0x4F494C;






