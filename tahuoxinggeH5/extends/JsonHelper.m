//
//  JsonHelper.m
//  ndExtension
//
//  Created by crl on 13-8-23.
//
//

#import "JsonHelper.h"

@implementation JsonHelper

NSMutableDictionary* dict;


-(JsonHelper *)init
{
    self=[super init];
    
    if (self!=NULL) {
        dict=[[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(void) addItem:(NSString *)key
          value:(id) value
{
    
    [dict setObject:value forKey:key];

    
}

-(id) getValue:(NSString *)key
{
    return [dict objectForKey:key];
}

-(BOOL) remove:(NSString *)key
{
    [dict removeObjectForKey:key];
    
    return YES;
}

-(BOOL) clear{
    [dict removeAllObjects];
    
    return YES;
}


- (void)decode:(NSString *) value
{
    
    if([value rangeOfString: @"{" ].location == 0){
        value=[value substringWithRange:NSMakeRange(1,value.length-2)];
    }
    
    
    NSArray *temp =[value componentsSeparatedByString:@","];
    
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"\'\""];
    
    for (NSString *keyValuePair in temp)
    {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@":"];
        
        
        if (pairComponents.count !=2) {
            continue;
        }
        
        NSString *key = [pairComponents objectAtIndex:0];
        NSString *value = [pairComponents objectAtIndex:1];
        
        
        
        key = [[key componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
        value = [[value componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
        
        
        [dict setObject:value forKey:key];
    }
    
}


-(NSString *) toJson
{
    NSMutableString *json=[[NSMutableString alloc] init];
    
    
    NSArray *keys = [dict allKeys]; // values in  foreach loop
    for (NSString *key in keys) {
        [json appendFormat:@"\"%@\":\"%@\",",key,[dict objectForKey:key]];
    }
    
    NSString * result;
    
    NSUInteger len=json.length;
    if(len>0){
        result=[json substringToIndex:len-1];
    }else{
        result=json;
    }
    
    return [NSString stringWithFormat:@"%@%@%@",@"{",result,@"}"];
}

@end
