//
//  MyButton.m
//  TestInteractiveApp
//
//  Created by Alexander on 19.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton
{
    UIColor *normalBGColor;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    normalBGColor = self.backgroundColor;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.backgroundColor = self.highlithedColor;
    } else {
        self.backgroundColor = normalBGColor;
    }
}

@end
