//
//  AppDelegate.h
//  pieMenu
//
//  Created by Tommaso Piazza on 2/16/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pieMenuViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    pieMenuViewController* _pieController;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) pieMenuViewController* pieController;

@end
