//
//  MapModal.h
//  LiteMetting
//
//  Created by hong pai on 13-1-23.
//  Copyright (c) 2013年 hong pai qq:454077256  tel:18621592830. All rights reserved.
//

#import "PModal.h"
#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface MapModal : PModal<BMKMapViewDelegate, BMKSearchDelegate> {
	IBOutlet BMKMapView* _mapView;

	BMKSearch* _search;
    int _searchIndex;
    
    NSMutableArray *lineArr;
    NSMutableString *titleLabel;
    int userLocationIndex;
}

-(IBAction)onClickBusSearch;
-(IBAction)onClickDriveSearch;
-(IBAction)onClickWalkSearch;
- (IBAction)onClickLookLine:(id)sender;
- (IBAction)onClickShowMe:(id)sender;

@property(nonatomic,retain) NSMutableArray *lineArr;
@property(nonatomic,retain) NSMutableString *titleLabel;

@property (retain, nonatomic) IBOutlet UIButton *busBtn;
@property (retain, nonatomic) IBOutlet UIButton *driveBtn;
@property (retain, nonatomic) IBOutlet UIButton *walkBtn;


@end

