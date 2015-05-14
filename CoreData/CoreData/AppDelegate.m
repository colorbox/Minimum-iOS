//
//  AppDelegate.m
//  CoreData
//
//  Created by merge on 2015/05/14.
//  Copyright (c) 2015年 merge. All rights reserved.
//

#import "AppDelegate.h"

#import "Entity.h"

@interface AppDelegate ()

@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    // モデルオブジェクトの準備
    NSURL *modelURL = [[NSBundle mainBundle]URLForResource:@"Minimum"
                                             withExtension:@"momd"];
    _model = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
    
    // コーディネータの準備
    _coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
    
    NSArray *urls = [[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    
    NSURL *url = urls[[urls count] - 1];
    NSURL *storeURL = [url URLByAppendingPathComponent:@"minimini.sqlite"];
    
    NSError *error = nil;
    [_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error];
    
    // コンテキストの準備
    _context = [[NSManagedObjectContext alloc]init];
    [_context setPersistentStoreCoordinator:_coordinator];
    


    // エンティティからデータを新規作成
    Entity *data = [NSEntityDescription insertNewObjectForEntityForName:@"Entity"
                                                 inManagedObjectContext:_context];
    
    [data setNumber:arc4random()%256];

    [_context save:&error];
    
    
    
    // 作成したデータを取得してみる
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entity"
                                              inManagedObjectContext:_context];
    [request setEntity:entity];
    
    [request setFetchBatchSize:5];

    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"number"
                                                               ascending:NO];
    [request setSortDescriptors:@[descriptor]];
    
    

    NSFetchedResultsController *result = [[NSFetchedResultsController alloc]initWithFetchRequest:request
                                                                            managedObjectContext:_context
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:nil];
    // 実際に取得
    [result performFetch:&error];
    

    // 取得した値を検証
    for (Entity *entity in result.fetchedObjects) {
        NSLog(@"%d",entity.number);
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
