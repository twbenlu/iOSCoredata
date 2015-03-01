//
//  AppDelegate.m
//  coredata
//
//  Created by benlu on 2/6/14.
//  Copyright (c) 2014 benlu. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

//synthesize 這三個變數
@synthesize m_managedObjectContext;
@synthesize m_persistentCoordinator;
@synthesize m_managedObjectModel;


-(NSURL *)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
}


/**
 NSManagedObjectContext參與對資料進行各種操作的整個過程，它持有Managed Object。
 我們通過它來監測Managed Object。監測資料對象有兩個作用：支持undo/redo以及資料綁定。這個類是最常被用到的。
 
 Managed Object Context這類別記載了我們的App在記憶體中所有的Entity，當你要求Core Data載入物件時，你必須先向Managed Object Context提出要求。
 假如Entity不存在記憶體中的話，Managed Object Context會向Persistent Store Coordinator發出請求，試著嘗試尋找它。
 Persistent Store Coordinator的任務是追蹤Persistent Object Store，而Persistent Object Store實際知道如何讀寫資料。
 **/
-(NSManagedObjectContext *)managedObjectContext{
    
    if(m_managedObjectContext != nil){
        return m_managedObjectContext;
    }
    //在managedObjectContext裡面會對persistentStoreCoordinator發出資料庫操作的請求，所以在此可以看到這邊去建立了一個NSPersistentStoreCoordinator 實例
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if(coordinator != nil){
        m_managedObjectContext = [[NSManagedObjectContext alloc] init];
        [m_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return m_managedObjectContext;
}


/**
 2.
 NSPersistentStoreCoordinator負責從資料文件(xml、sqlite、二進製文件等)中讀取資料生成Managed Object，或保存Managed Object寫入數據文件。
 **/
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (m_persistentCoordinator != nil){
        return m_persistentCoordinator;
    }
    //指定實際存放資料庫的位置，這邊會呼叫applicationDocumentsDirectory方法取得資料庫的實體路徑
    NSURL *storeURL = [[self applicationDocumentsDirectory]URLByAppendingPathComponent:@"data.sqlite"];
    NSError *error = nil;
    //呼叫managedObjectModel，經由managedObjectModel讀取資料模型來生成被管理的物件Managed object
    m_persistentCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    if(![m_persistentCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        NSLog(@"讀取資料時發生錯誤 %@,%@",error,[error userInfo]);
        abort();
    }
    return m_persistentCoordinator;
}


/**
 3.
 在 Ｏbjective-c中，一筆筆的資料會被視為被管理的物件(Managed Object)。
應用程序先建立或讀取模型文件（副檔名為xcdatamodeld的檔案）生成NSManagedObjectModel。
Document應用程序是一般是通過NSDocument或其子類NSPersistentDocument）從模型文件（副檔名為xcdatamodeld的檔案）讀取。
從Data Model檔案中建立 NSManagedObjectModel物件如果已經建立過就直接回傳
 
CoreDataDemo.sqlite：連結檔案系統，所有Entity最終會被儲存在這個SQLite資料庫檔案內。
CoreDataDemo.momd：儲存物件模型的檔案。
在專案中找不到上述兩個檔案，原因在於它們都是在編譯過後才產生的檔案，其中CoreDataDemo.momd是編譯後的物件模型，其原始檔為CoreDataDemo.xcdatamodel。
 

 
 **/
-(NSManagedObjectModel *)managedObjectModel{
    if(m_managedObjectModel != nil){
        return m_managedObjectModel;
    }
    //讀取資料模型來生成被管理的物件Managedobject
    NSURL *modelURL = [[NSBundle mainBundle]URLForResource:@"country" withExtension:@"momd"];
    m_managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
    return m_managedObjectModel;
}



/**
 2.
然後生成NSManagedObjectContext和NSPersistentStoreCoordinator對象，前者對用戶透明地調用後者對資料文件進行讀寫。
 **/











//-(NSPersistentStoreCoordinator *)persistentStoreCoordinator2 {
//    if (persistentStoreCoordinator != nil) {
//        return persistentStoreCoordinator;
//    }
//    NSString *storePath = [[self applicationDocumentsDirectory]stringByAppendingPathComponent:@”CoreData.sqlite”];
//    /*
//     Set up the store.
//     For the sake of illustration, provide a pre-populated default store.
//     */
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    // If the expected store doesn’t exist, copy the default store.
//    if (![fileManager fileExistsAtPath:storePath]) {
//        NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@”CoreData” ofType:@”sqlite”];
//        if (defaultStorePath) {
//            [fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
//        }
//    }
//    NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
//    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
//                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
//    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
//    NSError *error;
//    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
//        // Update to handle the error appropriately.
//        NSLog(@”Unresolved error %@, %@”, error, [error userInfo]);
//        exit(-1);  
//        // Fail
//    }
//    return persistentStoreCoordinator;
//}








- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    // Override point for customization after application launch.
//    NSLog(@"Appdelegate didFinish 完成");
//    
//    //複製資料庫到Document資料夾下
//    //將資料庫檔案複製到具有寫入權限的目錄
//        NSFileManager *fm = [[NSFileManager alloc]init];
//        NSString *src = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"sqlite"];
//        NSString *dst = [NSString stringWithFormat:@"%@/Documents/data.sqlite",NSHomeDirectory()];
//    
//    //    //APP啓用的時候在@/Documents 沒有資料庫
//    //    //從APP裡面把tjmb資料庫拷貝到 @/Documents/ 資料夾下
//    //    //拷貝完資料庫後,刪除掉App裡面的資料庫
////        [fm removeItemAtPath:dst error:nil];
//        [fm copyItemAtPath:src toPath:dst error:nil];
//        NSLog(@"拷貝資料庫完成");
    
    //檢查目的地的檔案是否存在，如果不存在則複製資料庫
    //    if(![fm fileExistsAtPath:dst]){
    //        [fm copyItemAtPath:src toPath:dst error:nil];
    //        [fm removeItemAtPath:src error:nil];
    //    }
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
