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
    
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:30],
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
        UIColor *transparentColor = [color colorWithAlphaComponent:0.3];
        attributes = @{NSForegroundColorAttributeName: transparentColor};
    }else{
        attributes = nil;
    }

    return attributes;
}

@end
