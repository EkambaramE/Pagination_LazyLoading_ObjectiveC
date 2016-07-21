//
//  FoodDrinksFields.m
//  Pagination_Objc
//
//  Created by EkambaramE on 20/07/16.
//  Copyright © 2016 Ekambaram. All rights reserved.
//

#import "FoodDrinksFields.h"
#import "AFNetworking.h"
#import "FoodDrink.h"

@interface FoodDrinksFields()


@end


@implementation FoodDrinksFields

/**
 *  parseDataFromResponseObject
 *
 *  @param url               url description
 *  @param completionHandler completionHandler description
 */

-(void) parseDataFromResponseObject : (NSString *) url completionAction: (void (^)(FoodDrinksWrapper *result))completionHandler {

     [self fetchRequest:url completionAction:^(NSArray *result) {
         
        FoodDrinksWrapper *wrapper = [[FoodDrinksWrapper alloc]init];
        [wrapper.foodDrinks addObjectsFromArray:result];
        wrapper.next = url;
        wrapper.count = 140;
        completionHandler(wrapper);
    }];

}

/**
 *  fetchRequest
 *
 *  @param url               url description
 *  @param completionHandler completionHandler description
 */


-(void) fetchRequest:(NSString *) url completionAction:(void (^)(NSArray *result))completionHandler
{
   
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSArray *inventory = [NSArray arrayWithObjects:@"error", nil];
            completionHandler(inventory);
        } else {
            NSArray *data = [responseObject valueForKey:@"data"];
            completionHandler(data);
        }
    }];
    [dataTask resume];

}
    
    
@end

