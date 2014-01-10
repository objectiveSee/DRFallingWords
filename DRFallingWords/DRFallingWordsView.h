//
//  DRFallingWordsView.h
//  DRFallingWords
//
//  Created by Danny Ricciotti on 1/10/14.
//  Copyright (c) 2014 Danny Ricciotti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRFallingWordsView : UIScrollView

- (void)showWords:(NSString *)words;
- (void)clear;
- (void)clearWithCompletion:(void (^)(BOOL finished))completion;

@end
