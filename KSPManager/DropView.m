//
//  DropView.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/21/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "DropView.h"


@implementation DropView


@synthesize delegate = _delegate;

- (void)awakeFromNib
{
    [self registerForDraggedTypes:@[NSURLPboardType, NSFilenamesPboardType]];
}

#pragma mark -
#pragma mark Delegate Validation and Invocation

- (void)invokeDelegateWithURL:(NSURL *)url
{

    if( self.delegate == nil )
        return ;
    
    if( [self.delegate respondsToSelector:@selector(handleURL:fromDropView:)] == NO )
        return ;
    
    [self.delegate performSelector:@selector(handleURL:fromDropView:)
                        withObject:url
                        withObject:self];
}

- (void) invokeDelegateWithPath:(NSString *)path
{
    [self invokeDelegateWithURL:[NSURL fileURLWithPath:path]];
}

#pragma mark -
#pragma mark Drag & Drop

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;

    sourceDragMask = [sender draggingSourceOperationMask];
    pboard = [sender draggingPasteboard];
    
    if ( [[pboard types] containsObject:NSURLPboardType] ) {
        if (sourceDragMask & NSDragOperationGeneric) {
            return NSDragOperationGeneric;
        }
    }

    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        NSLog(@"\tfound a Filenames: sourceDragMask %08lx",sourceDragMask);
        if (sourceDragMask & NSDragOperationCopy) {
            return NSDragOperationCopy;
        }
        if (sourceDragMask & NSDragOperationLink) {
            return NSDragOperationLink;
        }

    }
    return NSDragOperationNone;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
    
    NSPasteboard *pboard = [sender draggingPasteboard];
    
    if( [[pboard types] containsObject:NSURLPboardType] ) {

        NSURL *url = [NSURL URLFromPasteboard:pboard];
        if( url )
            [self invokeDelegateWithURL:url];
    }
 
#if 0
    if( [[pboard types] containsObject:NSFilenamesPboardType]) {
        NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
        for(NSString *path in files ) {
            [self invokeDelegateWithPath:path];
        }
    }
#endif
    
    return YES;
}

@end
