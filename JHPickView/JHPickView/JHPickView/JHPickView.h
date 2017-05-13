//
//  JHPickView.h
//  SmallCityStory
//
//  Created by Jivan on 2017/5/8.
//  Copyright © 2017年 Jivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JHPickerDelegate <NSObject>

@optional

- (void)PickerSelectorIndixString:(NSString *)str;

@end

typedef NS_ENUM(NSInteger, ARRAYTYPE) {
    GenderArray,
    HeightArray,
    weightArray,
    DeteArray,
    AreaArray
    
};

@interface JHPickView : UIView

@property (nonatomic, assign) ARRAYTYPE arrayType;

@property (nonatomic, strong) NSArray *customArr;

@property (nonatomic,strong)UILabel *selectLb;

@property (nonatomic,weak)id <JHPickerDelegate> delegate;


@end
