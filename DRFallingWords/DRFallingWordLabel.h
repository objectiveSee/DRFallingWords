//
//  DRFallingWordLabel.h
//  DRFallingWords
//
//  Created by Danny Ricciotti on 1/10/14.
//  Copyright (c) 2014 Danny Ricciotti. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const NSTimeInterval kDRWordDelayPerCharacter;
extern const NSTimeInterval kDRDelayPerSpace;

@interface DRFallingWordLabel : UILabel

- (void)setMasked:(BOOL)isMasked animated:(BOOL)animated;

@end
