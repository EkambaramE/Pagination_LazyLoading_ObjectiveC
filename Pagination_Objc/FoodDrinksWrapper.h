//
//  FoodDrinksWrapper.h
//  Pagination_Objc
//
//  Created by EkambaramE on 20/07/16.
//  Copyright © 2016 Ekambaram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodDrinksFields.h"
#import "FoodDrink.h"

@class FoodDrinksFields;
@interface FoodDrinksWrapper : NSObject

@property(nonatomic, strong) NSMutableArray<FoodDrink *> *foodDrinks;
@property(readwrite, assign) NSInteger count;
@property(assign) NSUInteger *pageNumber;
@property(assign) NSString *next;

@end