//
//  JsonHelper.h
//  ndExtension
//
//  Created by crl on 13-8-23.
//
//

#import <Foundation/Foundation.h>

@interface JsonHelper : NSObject


-(void) addItem:(NSString *)key
          value:(id) value;

-(BOOL) remove:(NSString *)key;


-(id) getValue:(NSString *)key;


-(BOOL) clear;

- (void)decode:(NSString *) value;


-(NSString *) toJson;

@end
