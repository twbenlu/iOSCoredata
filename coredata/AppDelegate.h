//
//  AppDelegate.h
//  coredata
//
//  Created by benlu on 2/6/14.
//  Copyright (c) 2014 benlu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    //增加 Core Data 的成員變數
    NSManagedObjectContext *m_managedObjectContext;
    NSManagedObjectModel *m_managedObjectModel;
    NSPersistentStoreCoordinator *m_persistentCoordinator;
}

@property (strong, nonatomic) UIWindow *window;
//增加Core Data的成員變數property定義
@property (nonatomic, retain) NSManagedObjectContext *m_managedObjectContext;
@property (nonatomic, retain) NSManagedObjectModel *m_managedObjectModel;
@property (nonatomic, retain) NSPersistentStoreCoordinator *m_persistentCoordinator;

//這是用來取得資料庫實體位置，Sqlite實體位置會被放置在這個路徑之下 ~/library/Application Support/iPhone Simulator/版本/Applications/你的App/Documents/
-(NSURL *)applicationDocumentsDirectory;


//傳回這個APP的物件本文管理，用來作物件同步
//Managed Object Context參與對數據對象進行各種操作的全過程，並監測資料對象的變化，以提供對undo/redo的支持及更新綁定到資料的UI。
-(NSManagedObjectContext*)managedObjectContext;

//傳回這個APP中管理資料庫的persistent store coordinator 物件
//Persistent Store Coordinator相當於資料文件管理器，處理底層的對資料文件的讀取與寫入。一般我們無需與它打交道。
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator;

//傳回這個APP中的物件模型管理員，負責讀取Data Model
//Managed Object Model是描述應用程序的資料模型，這個模型包含實體（Entity），特性（Property），讀取請求（Fetch Request ）等。
-(NSManagedObjectModel*)managedObjectModel;






@end
