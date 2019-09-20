//
//  LoginJsonModel.m
//  YanFarmwork
//
//  Created by HG on 2019/9/19.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "LoginJsonModel.h"

@implementation LoginJsonModel

+ (instancetype) infoWithDictionary:(NSDictionary *)infoDic
{
    id info = [[self alloc] initWithDictionary:infoDic];
    return info;
}
- (instancetype) initWithDictionary:(NSDictionary *)infoDic
{
    self = [super init];
    if (self)
    {
        [infoDic enumerateKeysAndObjectsUsingBlock:
         ^(id key, id obj, BOOL *stop)
         {
             id value = obj;
             if ([obj isKindOfClass:[NSNumber class]])
             {
                 if (strcmp([obj objCType], @encode(BOOL)) != 0)
                 {
                     @try
                     {
                         value = [NSString stringWithFormat:@"%@",[obj stringValue]];
                     }
                     @catch (NSException * e)
                     {
                         if ([[e name] isEqualToString:NSInvalidArgumentException])
                         {
                             NSNumber *temp =[NSNumber numberWithBool:[obj boolValue]];
                             value =  [NSString stringWithFormat:@"%@",[temp stringValue]];
                         }
                     }
                 }
             }
             else if([obj isKindOfClass:[NSNull class]])
             {
                 value = @"";
             }
             [self setValue:value forKey:key];
         }];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
