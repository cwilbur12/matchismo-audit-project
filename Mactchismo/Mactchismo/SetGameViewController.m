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
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) NSUInteger flipsCount;
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;

@end

@implementation SetGameViewController

- (IBAction)flipCard:(UIButton *)sender {
    //make the card that was just picked selected
    [self.game selectCardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    //increment flips count
    self.flipsCount++;
    
    [self updateUI];
}

- (SetGame *)game{
    if (!_game){
        _game = [[SetGame alloc]initWithCardCount:[self.cardButtons count]];
    }
    return _game;
}
- (IBAction)dealButton:(id)sender {
    self.flipsCount = 0;
    self.game = nil;
    self.informationLabel.text = @"";
    
    [self setUpCardsForGame];
    
    [self updateUI];
}

- (void) setUpCardsForGame{
    for(UIButton *cardButton in self.cardButtons){
        SetGameCard *card = (SetGameCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setAttributedTitle:[card attContents] forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpCardsForGame];
    [self updateUI];
}

- (void)updateUI{
    
    for(UIButton *cardButton in self.cardButtons){
        SetGameCard *card = (SetGameCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        if(card.isFaceUp && !card.isUnplayable){
            cardButton.selected = YES;
            
        }else{
            cardButton.selected = NO;
        }
        
        cardButton.enabled = !card.isUnplayable;

        cardButton.alpha = (card.isUnplayable ? 0.1 : 1.0);
    }
    //things that need to be updated after every click
    [self setButtonBorder:self.dealButton];
    [self.informationLabel setAttributedText:self.game.informationString];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipsCount];

}

- (void)setButtonBorder:(UIButton *)cardButton{
    cardButton.layer.BorderWidth = 1;
    cardButton.layer.CornerRadius = 4;
    cardButton.layer.borderColor = [cardButton titleColorForState: UIControlStateNormal].CGColor;
}


@end
