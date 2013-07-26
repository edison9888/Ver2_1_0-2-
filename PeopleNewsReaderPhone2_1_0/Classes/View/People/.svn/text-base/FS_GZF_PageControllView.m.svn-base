//
//  FS_GZF_PageControllView.m
//  PeopleNewsReaderPhone
//
//  Created by ganzf on 12-11-29.
//
//

#import "FS_GZF_PageControllView.h"

@implementation FS_GZF_PageControllView

@synthesize CurrentPage = _CurrentPage;
@synthesize PageNumber = _PageNumber;
@synthesize NonFocusColor = _NonFocusColor;
@synthesize FocusColor = _FocusColor;
@synthesize Radius = _Radius;
@synthesize Spacing = _Spacing;

@synthesize position_kind = _position_kind;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.position_kind = Position_kind_right;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
	
	//CGFloat rgba[] = {1.0,0.0,0.0,1.0};
    
    CGContextSetRGBStrokeColor(context, 255, 100, 100, 0);
    //self.PageNumber
    
    CGFloat beginX = self.Spacing;
    if (self.position_kind == Position_kind_right) {
        beginX= self.frame.size.width - (self.Spacing+self.Spacing*self.PageNumber);
    }
    
    if (self.position_kind == Position_kind_left) {
        beginX= self.Spacing;
    }
    
    if (self.position_kind == Position_kind_middle) {
        beginX= (self.frame.size.width - (self.Spacing+self.Spacing*self.PageNumber))/2;
    }
    
    
    
    for (int i=0; i<self.PageNumber; i++) {
       
        if (i==self.CurrentPage) {
            CGContextSetFillColor(context, CGColorGetComponents(self.FocusColor.CGColor));
            CGContextMoveToPoint(context, beginX+self.Spacing+self.Spacing*i, self.frame.size.height/2);
            CGContextAddArc(context, beginX+self.Spacing+self.Spacing*i, self.frame.size.height/2, self.Radius, M_PI, -M_PI, 1);
            CGContextClosePath(context);
            CGContextDrawPath(context, kCGPathFillStroke);
        }
        else{
            CGContextSetFillColor(context, CGColorGetComponents(self.NonFocusColor.CGColor));
            CGContextMoveToPoint(context, beginX+self.Spacing+self.Spacing*i, self.frame.size.height/2);
            CGContextAddArc(context, beginX+self.Spacing+self.Spacing*i, self.frame.size.height/2, self.Radius, M_PI, -M_PI, 1);
            CGContextClosePath(context);
            CGContextDrawPath(context, kCGPathFillStroke);
        }
    }
}



-(void)doSomethingAtDealloc{
    [_FocusColor release];
    [_NonFocusColor release];
}

-(void)doSomethingAtInit{
    
}

-(void)doSomethingAtLayoutSubviews{
    
}



-(void)setPageNumber:(NSInteger)number{
    _PageNumber = number;
}


-(void)setCurrentPage:(NSInteger)number{
    _CurrentPage = number;
    [self setNeedsDisplay];
    
}

@end
