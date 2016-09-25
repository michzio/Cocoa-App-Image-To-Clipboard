//
//  main.m
//  image_to_clipboard
//
//  Created by Michal Ziobro on 25/09/2016.
//  Copyright © 2016 Michal Ziobro. All rights reserved.
//
#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    
    if(argc != 2) {
        printf("-1");
        exit(1);
    }
    
    @autoreleasepool {
        
        // URL to image file
        NSString *CachesDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *appCachesDirectoryPath = [CachesDirectoryPath stringByAppendingPathComponent: @"com.remote-controller.server"];
        NSString *imageFileName = [NSString stringWithUTF8String:argv[1]];
        NSString *imagePath = [appCachesDirectoryPath stringByAppendingPathComponent:imageFileName];
        NSURL *imageURL = [NSURL fileURLWithPath:imagePath];
        
        // image object from URL
        NSImage *image = [[NSImage alloc] initWithContentsOfURL:imageURL];
        if(!image) {
            printf("-1");
            exit(1);
        }
        
        // remove image from filesystem
        [[NSFileManager defaultManager] removeItemAtURL: imageURL error: NULL];
        
        // paste image object to clipboard
        NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
        [pasteboard clearContents];
        NSArray *objectsToPaste = [NSArray arrayWithObject: image];
        if(![pasteboard writeObjects:objectsToPaste]) {
            printf("-1");
            exit(1);
        }
    
    }
    
    printf("0"); 
    return 0;
}
