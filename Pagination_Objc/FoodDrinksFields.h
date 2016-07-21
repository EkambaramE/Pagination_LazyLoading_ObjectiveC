//
//  FoodDrinksFields.h
//  Pagination_Objc
//
//  Created by EkambaramE on 20/07/16.
//  Copyright © 2016 Ekambaram. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "FoodDrinksWrapper.h"

@class FoodDrinksWrapper;
@interface FoodDrinksFields : NSObject

-(void) fetchRequest:(NSString *) url completionAction:(void (^)(NSArray *result))completionHandler;
-(void) parseDataFromResponseObject : (NSString *) url completionAction: (void (^)(FoodDrinksWrapper *result))completionHandler;

@end
