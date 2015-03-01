//
//  ViewController.h
//  coredata
//
//  Created by benlu on 2/6/14.
//  Copyright (c) 2014 benlu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    AppDelegate* appDelegate;
    NSArray *data;
}

@property (weak, nonatomic) IBOutlet UITextField *mylabel1;
@property (weak, nonatomic) IBOutlet UITextField *mylabel2;
@property (weak, nonatomic) IBOutlet UITableView *mytable;

- (IBAction)mybtn:(id)sender;

- (IBAction)get_btn:(id)sender;

@end
