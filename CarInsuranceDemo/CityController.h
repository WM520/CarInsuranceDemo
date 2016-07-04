//
//  CityController.h
//  CarInsuranceDemo
//
//  Created by David on 16/7/4.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CityControllerDelegate <NSObject>

- (void)goBackWithCity:(NSString *)city;

@end

@interface CityController : UIViewController

@property (nonatomic, weak) id<CityControllerDelegate> delegate;

@end
