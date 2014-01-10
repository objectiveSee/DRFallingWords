//
//  DRFallingWordLabel.m
//  DRFallingWords
//
//  Created by Danny Ricciotti on 1/10/14.
//  Copyright (c) 2014 Danny Ricciotti. All rights reserved.
//

#import "DRFallingWordLabel.h"

const NSTimeInterval kDRWordDelayPerCharacter = 0.035;
const NSTimeInterval kDRDelayPerSpace = kDRWordDelayPerCharacter * 3;

@interface DRFallingWordLabel()
@property (nonatomic) UIView *maskView;
@end

@implementation DRFallingWordLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setFont:[UIFont systemFontOfSize:30]];
        self.backgroundColor = [UIColor whiteColor];

        self.maskView = [[UIView alloc] initWithFrame:CGRectZero];
        self.maskView.backgroundColor = self.backgroundColor;   // doesn't work if background alpha is not 100%
        [self addSubview:self.maskView];
        [self setMasked:NO animated:NO];
        
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.maskView.frame = self.bounds;
}

#pragma mark - Public

- (void)setMasked:(BOOL)isMasked animated:(BOOL)animated
{
    if ( !animated ) {
        [self _positionMask:isMasked];
        return;
    }
    
    NSTimeInterval duration = MAX(kDRWordDelayPerCharacter*2,kDRWordDelayPerCharacter * self.text.length);
    
    [UIView animateWithDuration:duration animations:^{
        
        [self _positionMask:isMasked];

    } completion:^(BOOL finished) {
    }];
}

- (void)_positionMask:(BOOL)isMasked
{
    self.maskView.frame = isMasked ? self.bounds : CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
    self.maskView.alpha = isMasked ? 1 : 0;
    
    CGAffineTransform transform;
    transform = CGAffineTransformIdentity;
    if ( isMasked ) {
        transform = CGAffineTransformScale(transform, .9, .9);
        transform = CGAffineTransformTranslate(transform, 0, 15);
        
    }
    self.transform = transform;
}

@end
