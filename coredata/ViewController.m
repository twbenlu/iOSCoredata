//
//  ViewController.m
//  coredata
//
//  Created by benlu on 2/6/14.
//  Copyright (c) 2014 benlu. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Country.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.mytable.dataSource = self;
    self.mytable.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//寫資料到Sqlite的事件
- (IBAction)mybtn:(id)sender {
    NSLog(@"準備寫資料進入資料庫");
    Country *country =(Country*)[NSEntityDescription insertNewObjectForEntityForName:@"Country" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    country.pk = self.mylabel1.text;
    country.name = self.mylabel2.text;
    NSError* error = nil;

    //
    if(![appDelegate.m_managedObjectContext save:&error]){
        NSLog(@"新增資料遇到錯誤");
    }
}


//讀取資料的事件
- (IBAction)get_btn:(id)sender {
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Country" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetch setEntity:entity];
    data = [appDelegate.managedObjectContext executeFetchRequest:fetch error:nil];
    
    [self.mytable reloadData];
    NSLog(@"讀取資料庫完畢");
}



//這個方法是用來指定有多少的Section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

//這個方法是用來指定每個Section裡面有多少Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return 1;
    return [data count];
}

//劃出Cell 事件
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //轉型
    Country* currentdata = [data objectAtIndex:[indexPath row]];
    cell.textLabel.text = currentdata.name;

    return cell;
}





@end
