//
//  FoodDrinksWrapper.m
//  Pagination_Objc
//
//  Created by EkambaramE on 20/07/16.
//  Copyright © 2016 Ekambaram. All rights reserved.
//

#import "FoodDrinksWrapper.h"

@interface FoodDrinksWrapper()

@end


@implementation FoodDrinksWrapper

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.foodDrinks = [[NSMutableArray alloc]init];
    }
    return self;
}

@end