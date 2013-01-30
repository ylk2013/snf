//
//  MapModal.m
//  LiteMetting
//
//  Created by hong pai on 13-1-23.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "MapModal.h"
#import "MapLineViewController.h"
#import "BMapKit.h"
#import "LiteMettingViewController.h"



#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]


BOOL isRetina = FALSE;

@interface RouteAnnotation : BMKPointAnnotation
{
	int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘
	int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end

@interface UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;

@end

@implementation UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
	CGSize rotatedSize = self.size;
	if (isRetina) {
		rotatedSize.width *= 2;
		rotatedSize.height *= 2;
	}
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	CGContextRotateCTM(bitmap, degrees * M_PI / 180);
	CGContextRotateCTM(bitmap, M_PI);
	CGContextScaleCTM(bitmap, -1.0, 1.0);
	CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

@end


NSMutableString* _startCityText;
NSMutableString* _startAddrText;
float _startCoordainateXText;
float _startCoordainateYText;
NSMutableString* _endCityText;
NSMutableString* _endAddrText;
float _endCoordainateXText;
float _endCoordainateYText;
@implementation MapModal
@synthesize lineArr,titleLabel;

@synthesize busBtn=_busBtn,driveBtn=_driveBtn,walkBtn=_walkBtn;

- (NSString*)getMyBundlePath1:(NSString *)filename
{
	
	NSBundle * libBundle = MYBUNDLE ;
	if ( libBundle && filename ){
		NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
		NSLog ( @"%@" ,s);
		return s;
	}
	return nil ;
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBtn];
    
    [self initData];
	
    [_mapView setShowsUserLocation:YES];//显示定位的蓝点儿
//    [self onClickGeocode];
}

-(void)initBtn
{
    [self.busBtn setBackgroundImage:[UIImage imageNamed:@"bus1.png"] forState:UIControlStateNormal];
    [self.walkBtn setBackgroundImage:[UIImage imageNamed:@"walk1.png"] forState:UIControlStateNormal];
    [self.driveBtn setBackgroundImage:[UIImage imageNamed:@"drive1.png"] forState:UIControlStateNormal];
    
    [self.busBtn setBackgroundImage:[UIImage imageNamed:@"bus2.png"] forState:UIControlStateSelected];
    [self.walkBtn setBackgroundImage:[UIImage imageNamed:@"walk2.png"] forState:UIControlStateSelected];
    [self.driveBtn setBackgroundImage:[UIImage imageNamed:@"drive2.png"] forState:UIControlStateSelected];
}

-(void)resetBtn
{
    self.busBtn.selected = NO;
    self.walkBtn.selected = NO;
    self.driveBtn.selected = NO;
}

-(void)initData
{
    _search = [[BMKSearch alloc]init];
    lineArr = [[NSMutableArray alloc] init];
    titleLabel = [[NSMutableString alloc] init];
    
	_startCityText = [[NSMutableString alloc] initWithString:@"上海"];
	_startAddrText = [[NSMutableString alloc] initWithString:@"当前位置"];
	_startCoordainateXText = 116.403981;
	_startCoordainateYText = 39.915101;
	_endCityText = [[NSMutableString alloc] initWithString:@"上海"];
	_endAddrText = [[NSMutableString alloc] initWithString:@"上海安达仕酒店"];
    _endCoordainateXText = 121.482274;
    _endCoordainateYText = 31.228040;
    
	CGSize screenSize = [[UIScreen mainScreen] currentMode].size;
	if (((screenSize.width >= 639.9f))
		&& (fabs(screenSize.height >= 959.9f)))
	{
		isRetina = TRUE;
	}
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _mapView.delegate = self;
    _search.delegate = self;
    [self cleanMap];
    
}

-(void)cleanMap
{
    [_mapView removeOverlays:_mapView.overlays];
    //[_mapView removeAnnotations:_mapView.annotations];
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _mapView.delegate = nil;
    _search.delegate = nil;
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    lineArr = nil;
    titleLabel = nil;
    _startCityText = nil;
    _startAddrText = nil;
    _endCityText = nil;
    _endAddrText = nil;
    [self setBusBtn:nil];
    [self setDriveBtn:nil];
    [self setWalkBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    track();
    [lineArr release];
    [titleLabel release];
    [_startCityText release];
    [_startAddrText release];
    [_endCityText release];
    [_endAddrText release];
    [_busBtn release];
    [_driveBtn release];
    [_walkBtn release];
    [super dealloc];
}

- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
	BMKAnnotationView* view = nil;
	switch (routeAnnotation.type) {
		case 0:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 1:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 2:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 3:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 4:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
				view.canShowCallout = TRUE;
			} else {
				[view setNeedsDisplay];
			}
			
			UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
			view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
			view.annotation = routeAnnotation;
			
		}
			break;
		default:
			break;
	}
	
	return view;
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[RouteAnnotation class]]) {
		return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
	}
    //	return nil;
    
    
    static NSString *AnnotationViewID = @"annotationViewID";
    
    BMKAnnotationView *annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID] autorelease];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorGreen;
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
//    if((RouteAnnotation*)annotation.type==0){
//        
//    }
    annotationView.canShowCallout = TRUE;
    return annotationView;
    
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
	if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[[BMKPolylineView alloc] initWithOverlay:overlay] autorelease];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
//        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
	return nil;
}

//选中标注
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
}

- (void)onGetTransitRouteResult:(BMKPlanResult*)result errorCode:(int)error
{
	NSLog(@"onGetTransitRouteResult:error:%d", error);
	if (error == BMKErrorOk) {
		BMKTransitRoutePlan* plan = (BMKTransitRoutePlan*)[result.plans objectAtIndex:0];
		
		RouteAnnotation* item = [[RouteAnnotation alloc]init];
		item.coordinate = plan.startPt;
        item.title = [NSString stringWithFormat:@"起点：%@",_startAddrText];
        [lineArr addObject:item.title];
		item.type = 0;
		[_mapView addAnnotation:item];
		[item release];
		
		
		int size = [plan.lines count];
		int index = 0;
		for (int i = 0; i < size; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				index += len;
			}
			BMKLine* line = [plan.lines objectAtIndex:i];
			index += line.pointsCount;
			if (i == size - 1) {
				i++;
				route = [plan.routes objectAtIndex:i];
				for (int j = 0; j < route.pointsCount; j++) {
					int len = [route getPointsNum:j];
					index += len;
				}
				break;
			}
		}
		
		BMKMapPoint* points = new BMKMapPoint[index];
		index = 0;
		
		for (int i = 0; i < size; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
				memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
				index += len;
			}
			BMKLine* line = [plan.lines objectAtIndex:i];
			memcpy(points + index, line.points, line.pointsCount * sizeof(BMKMapPoint));
			index += line.pointsCount;
			
			item = [[RouteAnnotation alloc]init];
			item.coordinate = line.getOnStopPoiInfo.pt;
			item.title = line.tip;
            [lineArr addObject:item.title];
			if (line.type == 0) {
				item.type = 2;
			} else {
				item.type = 3;
			}
			
			[_mapView addAnnotation:item];
			[item release];
			route = [plan.routes objectAtIndex:i+1];
			item = [[RouteAnnotation alloc]init];
			item.coordinate = line.getOffStopPoiInfo.pt;
			item.title = route.tip;
            [lineArr addObject:item.title];
			if (line.type == 0) {
				item.type = 2;
			} else {
				item.type = 3;
			}
			[_mapView addAnnotation:item];
			[item release];
			if (i == size - 1) {
				i++;
				route = [plan.routes objectAtIndex:i];
				for (int j = 0; j < route.pointsCount; j++) {
					int len = [route getPointsNum:j];
					BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
					memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
					index += len;
				}
				break;
			}
		}
        item = [[RouteAnnotation alloc]init];
		item.coordinate = plan.endPt;
		item.type = 1;
		item.title = [NSString stringWithFormat:@"终点：%@",_endAddrText];
        [lineArr addObject:item.title];
		[_mapView addAnnotation:item];
		[item release];
		
		BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
		[_mapView addOverlay:polyLine];
		delete []points;
	}
}


- (void)onGetDrivingRouteResult:(BMKPlanResult*)result errorCode:(int)error
{
	NSLog(@"onGetDrivingRouteResult:error:%d", error);
	if (error == BMKErrorOk) {
		BMKRoutePlan* plan = (BMKRoutePlan*)[result.plans objectAtIndex:0];
		
		
		RouteAnnotation* item = [[RouteAnnotation alloc]init];
		item.coordinate = result.startNode.pt;
        item.title = [NSString stringWithFormat:@"起点：%@",_startAddrText];
        [lineArr addObject:item.title];
		item.type = 0;
		[_mapView addAnnotation:item];
		[item release];
		
		int index = 0;
		int size = [plan.routes count];
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				index += len;
			}
		}
		
		BMKMapPoint* points = new BMKMapPoint[index];
		index = 0;
		
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
				memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
				index += len;
			}
			size = route.steps.count;
			for (int j = 0; j < size; j++) {
				BMKStep* step = [route.steps objectAtIndex:j];
				item = [[RouteAnnotation alloc]init];
				item.coordinate = step.pt;
				item.title = step.content;
                [lineArr addObject:item.title];
				item.degree = step.degree * 30;
				item.type = 4;
				[_mapView addAnnotation:item];
				[item release];
			}
			
		}
		
		item = [[RouteAnnotation alloc]init];
		item.coordinate = result.endNode.pt;
		item.type = 1;
		item.title = [NSString stringWithFormat:@"终点：%@",_endAddrText];
        [lineArr addObject:item.title];
		[_mapView addAnnotation:item];
		[item release];
		BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
		[_mapView addOverlay:polyLine];
		delete []points;
	}
	
}

- (void)onGetWalkingRouteResult:(BMKPlanResult*)result errorCode:(int)error
{
	NSLog(@"onGetWalkingRouteResult:error:%d", error);
	if (error == BMKErrorOk) {
		BMKRoutePlan* plan = (BMKRoutePlan*)[result.plans objectAtIndex:0];
        
		RouteAnnotation* item = [[RouteAnnotation alloc]init];
		item.coordinate = result.startNode.pt;
		item.title = [NSString stringWithFormat:@"起点：%@",_startAddrText];
        [lineArr addObject:item.title];
		item.type = 0;
		[_mapView addAnnotation:item];
		[item release];
		
		int index = 0;
		int size = [plan.routes count];
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				index += len;
			}
		}
		
		BMKMapPoint* points = new BMKMapPoint[index];
		index = 0;
		
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
				memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
				index += len;
			}
			size = route.steps.count;
			for (int j = 0; j < size; j++) {
				BMKStep* step = [route.steps objectAtIndex:j];
				item = [[RouteAnnotation alloc]init];
				item.coordinate = step.pt;
				item.title = step.content;
                [lineArr addObject:item.title];
				item.degree = step.degree * 30;
				item.type = 4;
				[_mapView addAnnotation:item];
				[item release];
			}
			
		}
		
		item = [[RouteAnnotation alloc]init];
		item.coordinate = result.endNode.pt;
        NSLog(@"终点：%f,%f",item.coordinate.latitude,item.coordinate.longitude);
		item.type = 1;
        item.title = [NSString stringWithFormat:@"终点：%@",_endAddrText];
        [lineArr addObject:item.title];
		[_mapView addAnnotation:item];
		[item release];
		BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
		[_mapView addOverlay:polyLine];
		delete []points;
	}
}

- (void)onGetPoiResult:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error
{
}



-(IBAction)onClickBusSearch
{
    [self resetBtn];
    self.busBtn.selected = YES;
	NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	CLLocationCoordinate2D startPt = (CLLocationCoordinate2D){0, 0};
	CLLocationCoordinate2D endPt = (CLLocationCoordinate2D){0, 0};
	if (_startCoordainateXText != 0 && _startCoordainateYText != 0) {
		startPt = (CLLocationCoordinate2D){_startCoordainateYText, _startCoordainateXText};
	}
	if (_endCoordainateXText != 0 && _endCoordainateYText != 0) {
		endPt = (CLLocationCoordinate2D){_endCoordainateYText, _endCoordainateXText};
	}
	BMKPlanNode* start = [[BMKPlanNode alloc]init];
	start.pt = startPt;
	start.name = _startAddrText;
	BMKPlanNode* end = [[BMKPlanNode alloc]init];
	end.name = _endAddrText;
	BOOL flag = [_search transitSearch:_startCityText startNode:start endNode:end];
	if (!flag) {
		NSLog(@"search failed");
	}else{
        [lineArr removeAllObjects];
        [titleLabel setString:@"公交路线"];
    }
	[start release];
	[end release];
}

-(IBAction)onClickDriveSearch
{
    [self resetBtn];
    self.driveBtn.selected = YES;
	NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	CLLocationCoordinate2D startPt = (CLLocationCoordinate2D){0, 0};
	CLLocationCoordinate2D endPt = (CLLocationCoordinate2D){0, 0};
	if (_startCoordainateXText != 0 && _startCoordainateYText != 0) {
		startPt = (CLLocationCoordinate2D){_startCoordainateYText, _startCoordainateXText};
	}
	if (_endCoordainateXText != 0 && _endCoordainateYText != 0) {
		endPt = (CLLocationCoordinate2D){_endCoordainateYText, _endCoordainateXText};
	}
	BMKPlanNode* start = [[BMKPlanNode alloc]init];
	start.pt = startPt;
	start.name = _startAddrText;
	BMKPlanNode* end = [[BMKPlanNode alloc]init];
	end.name = _endAddrText;
	BOOL flag = [_search drivingSearch:_startCityText startNode:start endCity:_endCityText endNode:end];
	if (!flag) {
		NSLog(@"search failed");
	}else{
        [lineArr removeAllObjects];
        [titleLabel setString:@"自驾路线"];
    }
	[start release];
	[end release];
	
}

-(IBAction)onClickWalkSearch
{
    [self resetBtn];
    self.walkBtn.selected = YES;
	NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	CLLocationCoordinate2D startPt = (CLLocationCoordinate2D){0, 0};
	CLLocationCoordinate2D endPt = (CLLocationCoordinate2D){0, 0};
	if (_startCoordainateXText != 0 && _startCoordainateYText != 0) {
		startPt = (CLLocationCoordinate2D){_startCoordainateYText , _startCoordainateXText };
	}
	if (_endCoordainateXText != 0 && _endCoordainateYText != 0) {
		endPt = (CLLocationCoordinate2D){_endCoordainateYText , _endCoordainateXText };
	}
	BMKPlanNode* start = [[BMKPlanNode alloc]init];
	start.pt = startPt;
	start.name = _startAddrText;
	BMKPlanNode* end = [[BMKPlanNode alloc]init];
	end.name = _endAddrText;
	BOOL flag = [_search walkingSearch:_startCityText startNode:start endCity:_endCityText endNode:end];
	if (!flag) {
		NSLog(@"search failed");
	}else{
        [lineArr removeAllObjects];
        [titleLabel setString:@"步行路线"];
    }
	[start release];
	[end release];
	
}

- (IBAction)onClickLookLine:(id)sender {
    MapLineViewController *mapline = [[MapLineViewController alloc] initWithArray:lineArr WithTitle:titleLabel WithNibName:@"MapLineViewController" bundle:nil];
    [[Global shareGlobel].rootController.view addSubview:mapline.view];
    [mapline ee_contentIn];
//    [self.view addSubview:mapline.view];
}

- (IBAction)onClickShowMe:(id)sender {
    [self resetBtn];
    [_mapView setShowsUserLocation:YES];//显示定位的蓝点儿
}




//安达仕的坐标
-(void)onClickGeocode
{
	NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
    _searchIndex = 1;
//	BOOL flag = [_search geocode:_endAddrText withCity:_endCityText];
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
	if (_startCoordainateXText != 0 && _startCoordainateYText != 0) {
		pt = (CLLocationCoordinate2D){_endCoordainateYText , _endCoordainateXText };
	}
    NSLog(@"%f---%f",_endCoordainateYText,_endCoordainateXText);
    _searchIndex = 1;
	BOOL flag = [_search reverseGeocode:pt];
	if (!flag) {
		NSLog(@"search failed!");
	}
}
//- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
//{
//	static NSString *AnnotationViewID = @"annotationViewID";
//
//    BMKAnnotationView *annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
//    if (annotationView == nil) {
//        annotationView = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID] autorelease];
//		((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
//		((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
//    }
//
//	annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
//    annotationView.annotation = annotation;
//	annotationView.canShowCallout = TRUE;
//    return annotationView;
//}


- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
{
	if (error == 0) {
		BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
		item.coordinate = result.geoPt;
		item.subtitle = result.strAddr;
        
//        NSMutableString *temp;
        if(_searchIndex ==1){
//           temp = [NSMutableString stringWithFormat:@"%f",item.coordinate.latitude];
//            [_endCoordainateYText release];
//            _endCoordainateYText = [temp retain];
            _endCoordainateYText = item.coordinate.latitude;
//            temp = [NSMutableString stringWithFormat:@"%f",item.coordinate.longitude];
//            [_endCoordainateXText release];
//            _endCoordainateXText = [temp retain];
            _endCoordainateXText = item.coordinate.longitude;
            NSLog(@"%f %f",item.coordinate.latitude,item.coordinate.longitude );
            [_mapView addAnnotation:item];
            item.title = @"上海安达仕酒店";
            [item release];
            BMKCoordinateSpan span;
            BMKCoordinateRegion region;
            span.latitudeDelta=0.020;
            span.longitudeDelta=0.020;
            region.span=span;
            region.center=item.coordinate;
            [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
//            [_mapView setShowsUserLocation:YES];//显示定位的蓝点儿
        }
        
        if (_searchIndex ==2) {
            //        _startCityText = [NSString stringWithFormat:@"%@",result.city];
//            temp = [NSString stringWithFormat:@"%@",result.strAddr];
//            _startAddrText = [temp retain];
            item.title = @"我的位置";
            [_startAddrText setString:result.strAddr];
            [_mapView addAnnotation:item];
            [_mapView setShowsUserLocation:NO];//显示定位的蓝点儿
            userLocationIndex++;
            if(userLocationIndex==1){
                [self onClickGeocode];
            }
        }
	}
    
}

//自己的位置
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
	if (userLocation != nil) {
		NSLog(@"%f %f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
       _startCoordainateYText = userLocation.location.coordinate.latitude;//获取经度
        _startCoordainateXText = userLocation.location.coordinate.longitude;//获取纬度
        [self onClickReverseGeocode];
        
        if(userLocationIndex==0)return;
        BMKCoordinateSpan span;
        BMKCoordinateRegion region;
        
        span.latitudeDelta=0.010;
        span.longitudeDelta=0.010;
        region.span=span;
        region.center=[userLocation coordinate];
        
        [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
        //        [_mapView setShowsUserLocation:NO];
        
        //        CLGeocoder *Geocoder=[[CLGeocoder alloc]init];//CLGeocoder用法参加之前博客
        //
        //        CLGeocodeCompletionHandler handler = ^(NSArray *place, NSError *error) {
        //
        //            for (CLPlacemark *placemark in place) {
        //
        //                _startAddrText=placemark.thoroughfare;
        //
        //                _startCityText=placemark.locality;
        //
        //                NSLog(@"city %@",_startCityText);//获取街道地址
        //                NSLog(@"cityName %@",_startCityText);//获取城市名
        //
        //                break;
        //
        //            }
        //
        //        };
        //
        //        CLLocation *loc = [[CLLocation alloc] initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
        //
        //        [Geocoder reverseGeocodeLocation:loc completionHandler:handler];
        
    }
}

-(void) centerMap {
    //
    //	BMKCoordinateRegion region;
    //
    //	CLLocationDegrees maxLat = -90;
    //	CLLocationDegrees maxLon = -180;
    //	CLLocationDegrees minLat = 90;
    //	CLLocationDegrees minLon = 180;
    //	for(int idx = 0; idx < routes.count; idx++)
    //	{
    //		CLLocation* currentLocation = [routes objectAtIndex:idx];
    //		if(currentLocation.coordinate.latitude > maxLat)
    //			maxLat = currentLocation.coordinate.latitude;
    //		if(currentLocation.coordinate.latitude < minLat)
    //			minLat = currentLocation.coordinate.latitude;
    //		if(currentLocation.coordinate.longitude > maxLon)
    //			maxLon = currentLocation.coordinate.longitude;
    //		if(currentLocation.coordinate.longitude < minLon)
    //			minLon = currentLocation.coordinate.longitude;
    //	}
    //	region.center.latitude     = (maxLat + minLat) / 2;
    //	region.center.longitude    = (maxLon + minLon) / 2;
    //	region.span.latitudeDelta  = maxLat - minLat + 0.018;
    //	region.span.longitudeDelta = maxLon - minLon + 0.018;
    //
    //	[_mapView setRegion:region animated:YES];
}


-(void)onClickReverseGeocode
{
	NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
	if (_startCoordainateXText != 0 && _startCoordainateYText != 0) {
		pt = (CLLocationCoordinate2D){_startCoordainateYText , _startCoordainateXText };
	}
    NSLog(@"%f---%f",_startCoordainateYText,_startCoordainateXText);
    _searchIndex = 2;
	BOOL flag = [_search reverseGeocode:pt];
	if (!flag) {
		NSLog(@"search failed!");
	}
}

@end

