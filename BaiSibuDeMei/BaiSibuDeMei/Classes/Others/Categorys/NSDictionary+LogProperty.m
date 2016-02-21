

#import "NSDictionary+LogProperty.h"

@implementation NSDictionary (LogProperty)

- (void)logProperty
{
    
    NSMutableString *propertyString = [NSMutableString stringWithString:@"成功解析的对象属性\r\n\r\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        
        
        if ([[obj class] isSubclassOfClass:[NSString class]])
        {
            [propertyString appendString:[NSString stringWithFormat:@"@property (nonatomic, copy)   NSString *%@;\r\n",key]];
        }
        else if ([[obj class] isSubclassOfClass:[NSArray class]])
        {
            [propertyString appendString:[NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;\r\n",key]];
        }
        else if ([[obj class] isSubclassOfClass:[NSDictionary class]])
        {
            [propertyString appendString:[NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;\r\n",key]];
        }
        else if ([[obj class] isSubclassOfClass:NSClassFromString(@"__NSCFBoolean")])
        {
            [propertyString appendString:[NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;\r\n",key]];        }
        else if ([[obj class] isSubclassOfClass:[NSNumber class]])
        {
            [propertyString appendString:[NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;\r\n",key]];
        }
        else
        {
            NSLog(@"无法识别[%@]---%@\r\n",[obj class],key);
        }
        
    }];
    
    NSLog(@"%@",propertyString);
}

@end
