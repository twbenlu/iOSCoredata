//
//  Country.h
//  coredata
//
//  Created by benlu on 2/6/14.
//  Copyright (c) 2014 benlu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Country : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * pk;

@end
