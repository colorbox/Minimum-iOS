//
//  AppDelegate.h
//  CoreData
//
//  Created by merge on 2015/05/14.
//  Copyright (c) 2015年 merge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property(nonatomic,strong)NSManagedObjectContext *context;
@property(nonatomic,strong)NSManagedObjectModel *model;
@property(nonatomic,strong)NSPersistentStoreCoordinator *coordinator;



@end

