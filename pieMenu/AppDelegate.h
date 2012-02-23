//
//  AppDelegate.h
//  pieMenu
//
//  Created by Tommaso Piazza on 2/16/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pieMenuViewController.h"
#import "MSSCommunicationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    pieMenuViewController* _pieController;
    MSSCommunicationController *_surfaceComController;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) pieMenuViewController* pieController;
@property (strong, nonatomic) MSSCommunicationController* surfaceComController;

@end
