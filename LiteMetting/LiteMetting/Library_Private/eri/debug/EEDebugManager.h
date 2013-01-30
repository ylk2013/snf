//
//  DebugManager.h
//  GETExceptionTest
//
//  Created by pai hong on 12-10-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EEDebugManager : NSObject{
    UIWindow *_mainWindow;
    
    UISwipeGestureRecognizer *recog1;
    UISwipeGestureRecognizer *recog2;
    BOOL isSuccess;
}

-(void)initDebugManager:(UIWindow *)mainWindow;

@end

void initDebugManager1(UIWindow *mainWindow);
//void InstallUncaughtExceptionHandler(void);
