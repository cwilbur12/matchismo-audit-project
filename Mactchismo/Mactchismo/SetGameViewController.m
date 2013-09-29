//
//  SetGameViewController.m
//  Mactchismo
//
//  Created by Cory Wilbur on 9/27/13.
//  Copyright (c) 2013 Cory Wilbur. All rights reserved.
//


#import "SetGameViewController.h"
#import "SetGame.h"
#import "SetGameCard.h"

@interface SetGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) SetGame *game;

@end

@implementation SetGameViewController

- (IBAction)flipCard:(UIButton *)sender {

    NSAttributedString *contents = [self.game runGame];
    
    [sender setAttributedTitle:contents forState:UIControlStateNormal];
}

- (SetGame *)game{
    if (!_game){
        _game = [[SetGame alloc]initWithCardCount:[self.cardButtons count]];
    }
    return _game;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    for(UIButton *cardButton in self.cardButtons){
        SetGameCard *card = (SetGameCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setAttributedTitle:[card attContents] forState:UIControlStateNormal];
    }
}


@end
