//
// Created by Dani Postigo on 3/8/14.
//

#import <NSColor-BlendingUtils/NSColor+BlendingUtils.h>
#import <NSColor-Crayola/NSColor+Crayola.h>
#import "DPRowView.h"

@implementation DPRowView

@synthesize cornerOptions;
@synthesize cornerRadius;

@synthesize highlightColor;

- (id) initWithFrame: (NSRect) frameRect {
    self = [super initWithFrame: frameRect];
    if (self) {
        [self setup];
    }

    return self;
}

- (void) setup {
    cornerOptions = AFCornerLowerRight | AFCornerLowerLeft | AFCornerUpperLeft | AFCornerUpperRight;
}


- (void) drawBackgroundInRect: (NSRect) dirtyRect {
    [self drawBackgroundInRect2: dirtyRect];
}


- (void) drawBackgroundInRect2: (NSRect) dirtyRect {
    NSBezierPath *path;

    NSColor *midColor = [NSColor colorWithDeviceWhite: 0.97 alpha: 1.0];

    NSColor *darkColor = [midColor darken: 0.05];
    NSColor *lowColor = [NSColor colorWithDeviceWhite: 0.0 alpha: 0.2];
    NSColor *highColor = highlightColor == nil ? [NSColor colorWithDeviceWhite: 1.0 alpha: 0.4] : highlightColor;
    //    highColor = [NSColor blueColor];

    [NSGraphicsContext saveGraphicsState];

    {
        path = self.darkBezierPath;
        [darkColor set];
        [path fill];

        path = self.midBezierPath;
        [path addClip];
        [midColor set];
        [path fill];
    }

    [NSGraphicsContext restoreGraphicsState];

    [NSGraphicsContext saveGraphicsState];

    {
        path = self.boundsBezierPath;
        NSRectClip(NSMakeRect(0, dirtyRect.size.height - 1, dirtyRect.size.width, 1));
        [lowColor set];
        [path fill];
    }

    [NSGraphicsContext restoreGraphicsState];

    //    path = self.boundsBezierPath;
    //    path = self.insetBezierPath;
    //    NSRectClip(NSMakeRect(0, 1, dirtyRect.size.width, 1));
    path = self.highlightPath;
    [highColor setFill];
    [path fill];
}


- (void) drawBackgroundInRect1: (NSRect) dirtyRect {
    NSBezierPath *path;

    NSRect bounds = self.bounds;
    NSColor *fillColor = [NSColor blueColor];

    NSColor *midColor = [NSColor colorWithDeviceWhite: 0.97 alpha: 1.0];
    NSColor *darkColor = [midColor darken: 0.05];

    path = self.darkBezierPath;
    //    [path addClip];
    [darkColor set];
    [path fill];

    //
    path = [self bezierPathWithRect: NSInsetRect(dirtyRect, 0, 1)];
    //    path = [NSBezierPath bezierPathWithRect: NSMakeRect(0, 0, 20, 20)];
    //    //    path = self.darkBezierPath;
    [path addClip];
    [midColor set];
    [path fill];



    //    [[NSGraphicsContext currentContext] setCompositingOperation: NSCompositePlusLighter];
    //    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor: [NSColor colorWithDeviceWhite: 1.0 alpha: 0.3] endingColor: [NSColor clearColor]];
    //    [gradient drawInRect: midRect angle: 90];
    //    [[NSGraphicsContext currentContext] setCompositingOperation: NSCompositeSourceOver];
    //
    NSRect highlight = NSMakeRect(0, 1, dirtyRect.size.width, 1);
    path = [self bezierPathWithRect: highlight];
    [[NSColor colorWithDeviceWhite: 1.0 alpha: 0.4] setFill];
    [path fill];

    //    NSRectFill(highlight);
    //    //    NSRectFillUsingOperation(highlight, NSCompositeSourceOver);
    //    //
    NSRect lowLight = NSMakeRect(0, dirtyRect.size.height - 1, dirtyRect.size.width, 1);
    [[NSColor colorWithDeviceWhite: 0.0 alpha: 0.1] set];
    path = [self bezierPathWithRect: lowLight];
    [path fill];
    //    //    NSRectFill(lowLight);
    //    //    NSRectFillUsingOperation(lowLight, NSCompositeSourceOver);
    //
    //    [NSGraphicsContext restoreGraphicsState];

}

- (BOOL) isOpaque {
    return NO;
}


#pragma mark Colors


#pragma mark Paths

- (NSBezierPath *) bezierPathWithRect: (NSRect) rect {
    NSBezierPath *ret = nil;
    if (cornerRadius > 0) {
        if ((cornerOptions & AFCornerUpperLeft) &&
                (cornerOptions & AFCornerUpperRight) &&
                (cornerOptions & AFCornerLowerLeft) &&
                (cornerOptions & AFCornerLowerRight)) {
            ret = [NSBezierPath bezierPathWithRoundedRect: rect radius: cornerRadius];
        } else {
            ret = [NSBezierPath bezierPathWithRoundedRect: rect corners: cornerOptions radius: cornerRadius];
        }
    } else {
        ret = [NSBezierPath bezierPathWithRect: rect];
    }
    return ret;
}


- (NSBezierPath *) insetBezierPath {
    NSBezierPath *ret = [self bezierPathWithRect: NSInsetRect(self.bounds, 0, 1)];
    return ret;
}


- (NSBezierPath *) boundsBezierPath {
    NSBezierPath *ret = [self bezierPathWithRect: self.bounds];
    return ret;
}


- (NSBezierPath *) darkBezierPath {
    NSBezierPath *ret = [self bezierPathWithRect: self.bounds];
    NSBezierPath *removePath = [self bezierPathWithRect: NSInsetRect(self.bounds, 0, 1)];
    removePath = [removePath bezierPathByReversingPath];
    [ret appendBezierPath: removePath];
    return ret;
}

- (NSBezierPath *) midBezierPath {
    NSBezierPath *ret = [self bezierPathWithRect: self.bounds];
    NSBezierPath *removePath = self.darkBezierPath;
    removePath = [removePath bezierPathByReversingPath];
    [ret appendBezierPath: removePath];
    return ret;
}


- (NSBezierPath *) highlightPath {
    NSRect bounds = NSInsetRect(self.bounds, 0, 1);
    NSBezierPath *ret = [self bezierPathWithRect: bounds];

    bounds.origin.y += 1;
    bounds.size.height -= 1;

    NSBezierPath *removePath = [self bezierPathWithRect: bounds];
    //    NSBezierPath *removePath = [NSBezierPath bezierPathWithRect: bounds];
    removePath = [removePath bezierPathByReversingPath];
    [ret appendBezierPath: removePath];
    //    [ret setWindingRule: NSNonZeroWindingRule];
    //    [ret setWindingRule: NSEvenOddWindingRule];
    return ret;
}

@end