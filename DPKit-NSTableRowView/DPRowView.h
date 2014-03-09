//
// Created by Dani Postigo on 3/8/14.
//

#import <Foundation/Foundation.h>
#import "NSBezierPath+RoundedCorners.h"

@interface DPRowView : NSTableRowView {
    CGFloat cornerRadius;
    AFCornerOptions cornerOptions;

    NSColor *highlightColor;
}

@property(nonatomic) AFCornerOptions cornerOptions;
@property(nonatomic) CGFloat cornerRadius;
@property(nonatomic, strong) NSColor *highlightColor;
@end