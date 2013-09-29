//
//  MatchismoViewController.m
//  Mactchismo
//
//  Created by Cory Wilbur on 9/21/13.
//  Copyright (c) 2013 Cory Wilbur. All rights reserved.
//

#import "MatchismoViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface MatchismoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsCountLabel;
@property (nonatomic) int flipsCount;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;
@property (nonatomic)BOOL isThreeGameType;
@property (weak, nonatomic) IBOutlet UISegmentedControl *resetGameSwitcher;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;

@end

@implementation MatchismoViewController

- (IBAction)gameTypeSwitcher:(id)sender {
    int selectedSegment = [sender selectedSegmentIndex];
    
    if(selectedSegment == 0){
        self.isThreeGameType = NO;
        [self resetGame:sender];
    }else{
        [self resetGame:sender];
        [self.resetGameSwitcher setSelectedSegmentIndex:1];
        self.isThreeGameType = YES;
    }
    
}

- (void)setCardButtons:(NSArray *)cardButtons{
    _cardButtons = cardButtons;
    
    [self updateUI];
    
}
- (IBAction)resetGame:(id)sender {
    [self setFlipsCount:(NSUInteger)0];
    self.deck = [[PlayingCardDeck alloc]init];
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                 usingDeck:self.deck];
    
    self.resetGameSwitcher.userInteractionEnabled = YES;
    
    
    [self updateUI];
}

- (void)updateUI{
    self.game.cardsFaceUp = 0;
    for(UIButton *cardButton in self.cardButtons){
        Card *card =[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
        if(cardButton.selected && cardButton.enabled){
            if(!self.game.informationString){
                self.game.informationString = [NSString stringWithFormat:@"You flipped a %@",card.contents];
                [self setBackgroundColor:cardButton];
            }
        }
        [self setBackgroundColor:cardButton];
        [self setButtonBorder:cardButton];

        if(card.isFaceUp && !card.isUnplayable){
            self.game.cardsFaceUp++;
        }
    }
    [self setButtonBorder:self.dealButton];
    self.resetGameSwitcher.alpha = (self.resetGameSwitcher.userInteractionEnabled == NO ? 0.3: 1.0);
    self.informationLabel.text = self.game.informationString;
    self.game.informationString = nil;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void) setFlipsCount:(int)flipsCount{
    _flipsCount = flipsCount;
    self.flipsCountLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipsCount];
}



- (IBAction)flipCard:(UIButton *)sender {
    self.resetGameSwitcher.userInteractionEnabled = NO;
     if(self.isThreeGameType){
        if(self.game.cardsFaceUp == 2){
            [self.game flipCardAtIndexThreeGameThreeCard:[self.cardButtons indexOfObject:sender]];
        }else if(self.game.cardsFaceUp == 1){
            [self.game flipCardAtIndexThreeGameTwoCard:[self.cardButtons indexOfObject:sender]];
        }else{
            [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
        }
    }else{
        [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    }
    
    self.flipsCount++;
    [self updateUI];
    
}

- (CardMatchingGame *)game{
    if(!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                                        usingDeck:[[PlayingCardDeck alloc]init ]];
    
    return _game;
}

- (void)setButtonBorder:(UIButton *)cardButton{
    cardButton.layer.BorderWidth = 1;
    cardButton.layer.CornerRadius = 4;
    //cardButton.layer.borderColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor;
    cardButton.layer.borderColor = [cardButton titleColorForState: UIControlStateNormal].CGColor;
}

- (void)setBackgroundColor:(UIButton *)button{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [button setBackgroundImage:img forState:UIControlStateSelected];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.resetGameSwitcher setSelectedSegmentIndex:0];
    
    [self updateUI];
}



@end
