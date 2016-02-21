#import "NSArray+Log.h"

@implementation NSArray (Log)

//- (NSString *)descriptionWithLocale:(id)locale
//{
//    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
//    
//    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        [strM appendFormat:@"\t%@,\n", obj];
//    }];
//    
//    [strM appendString:@")"];
//    
//    return strM;
//}

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"@["];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        if ([[obj class] isSubclassOfClass:[NSValue class]] )
        {
            
            obj = [NSString stringWithFormat:@"@(%@)",obj];
        }
       
        
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@"]"];
    
    return strM;
}

@end

@implementation NSDictionary (Log)

//- (NSString *)descriptionWithLocale:(id)locale
//{
//    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
//    
//    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
//    }];
//    
//    [strM appendString:@"}\n"];
//    
//    return strM;
//}

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"\n@{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(NSString * key, id obj, BOOL *stop) {
        
//        if ([key  isEqual: @"geo"] ) {
//            NSLog(@"czljcb%@---%@",obj,[obj class]);
//        }
        
        if ([[obj class] isSubclassOfClass:[NSValue class]]) {
            [strM appendFormat:@"\t@\"%@\" : @(%@),\n", key, obj];
        }
        else if ([[obj class] isSubclassOfClass:[NSString class]])
        {
             [strM appendFormat:@"\t@\"%@\" : @\"%@\",\n", key, [obj stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""]];
        }
        else
        {
            if([obj class] == [NSNull class]) obj = @"[NSNull null]";
            [strM appendFormat:@"\t@\"%@\" : %@,\n", key, obj];
        }
        
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}


//[@"<a href=\"http://weibo.com/\" rel=\"nofollow\">微博 weibo.com</a>" stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
@end