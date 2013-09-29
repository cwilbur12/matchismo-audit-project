//
//  SetGameViewController.m
//  Mactchismo
//
//  Created by Cory Wilbur on 9/27/13.
//  Copyright (c) 2013 Cory Wilbur. All rights reserved.
//


#import "SetGameViewController.h"
#import "SetGame.h"

@interface SetGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation SetGameViewController

- (IBAction)flipCard:(UIButton *)sender {
    SetGame *game = [[SetGame alloc]init];
    NSAttributedString *contents = [game runGame];
    
    [sender setAttributedTitle:contents forState:UIControlStateNormal];
}


@end
