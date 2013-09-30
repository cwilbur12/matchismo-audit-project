//
//  SetGameCard.m
//  Mactchismo
//
//  Created by Cory Wilbur on 9/27/13.
//  Copyright (c) 2013 Cory Wilbur. All rights reserved.
//

#import "SetGameCard.h"

@implementation SetGameCard


- (NSAttributedString *)attContents{
    
    NSArray *symbols = [SetGameCard validSymbols];
    
    NSArray *colors = [SetGameCard validColors];
    
    NSString *content = symbols[self.typeOfSymbol];
    
    NSMutableString *mutableContent = [[NSMutableString alloc]init];
    
    if(self.numOfSymbols != 0){
        for(int i = 0; i<=self.numOfSymbols;i++){
            [mutableContent appendString:content];
        }
        content = mutableContent;
    }

    
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc] initWithString:content];
    
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:20],
                                 NSForegroundColorAttributeName: (UIColor *) colors[self.colorOfSymbol],
                                 NSStrokeWidthAttributeName:@-5,
                                 NSStrokeColorAttributeName:(UIColor *) colors[self.colorOfSymbol]};
    NSRange r = [[contents string] rangeOfString:[contents string]];
    
    [contents setAttributes:attributes range:r];
    
    //add the shading attribute to the given attributes
    if(self.shadeOfSymbol != 2 ){
        [contents addAttributes:[self addShadingAttrbutes] range:r];
    }
    
    return contents;
}


+ (NSArray *)validSymbols{
    return @[@"▲",@"●",@"■"];
}

+ (NSArray *)validColors{
    return @[[UIColor blueColor], [UIColor greenColor], [UIColor orangeColor]];
}

+ (NSArray *)validShades{
    return @[];
}

+ (NSUInteger)maxSymbols{
    return 3;
}

- (NSDictionary *)addShadingAttrbutes{
    NSDictionary *attributes;
    if(self.shadeOfSymbol == 0){
        attributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    }else if (self.shadeOfSymbol == 1){
        NSArray *colors = [SetGameCard validColors];
        UIColor *color = colors[self.colorOfSymbol];
        UIColor *transparentColor = [color colorWithAlphaComponent:0.4];
        attributes = @{NSForegroundColorAttributeName: transparentColor};
    }else{
        attributes = nil;
    }

    return attributes;
}


- (NSUInteger)match:(NSArray *)selectedCards{
    NSUInteger score = 0;
    
    //for the particular match you know that if you are matching that there has to be 3 cards
    //you would not match if any other amount of cards in a set game
    //using that assumption, is the reason my match logic for set game is as so
    
    SetGameCard *cardOne = selectedCards[0];
    SetGameCard *cardTwo = selectedCards[1];
    SetGameCard *cardThree = selectedCards[2];
    
    if([self propsOfCardsMatchWithProp:cardOne.numOfSymbols And:cardTwo.numOfSymbols And:cardThree.numOfSymbols] ){
        if([self propsOfCardsMatchWithProp:cardOne.colorOfSymbol And:cardTwo.colorOfSymbol And:cardThree.colorOfSymbol]){
            if([self propsOfCardsMatchWithProp:cardOne.typeOfSymbol And:cardTwo.typeOfSymbol And:cardThree.typeOfSymbol]){
                if([self propsOfCardsMatchWithProp:cardOne.shadeOfSymbol And:cardTwo.shadeOfSymbol And:cardThree.shadeOfSymbol]){
                    //if they all match the criteria for a score then the score gets raised
                    score = 100;
                }else{//deduction
                    score = -10;
                }
            }else{//deduction
                score = -10;
            }
        }else{//deduction
            score = -10;
        }
    }else{//deduction
        score = -10;
    }

    return score;
}

//match in the case of this game would be that the properties are either all the same or all different
- (BOOL) propsOfCardsMatchWithProp:(NSUInteger)propOne And:(NSUInteger)propTwo And:(NSUInteger)propThree{
    BOOL success = NO;
    
    if(propOne == propTwo){
        if(propTwo == propThree){
            success = YES;
        }else{ // propTwo != propThree so propThree is different
            success = NO;
        }
    }else{//propOne != propTwo
        if((propOne != propThree) && propTwo != propThree){
            success = YES;
        }else{//one of the properties equal each other so they are not all different
            success = NO;
        }
    }
    return success;
    
}



@end
