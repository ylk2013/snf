@interface NSData (Base64) 

+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (id)initWithBase64EncodedString:(NSString *)string;

- (NSString *)base64Encoding;
- (NSString *)base64EncodingWithLineLength:(unsigned int) lineLength;

+ (id)ee_dataWithBase64EncodedString:(NSString *)string;
- (NSString *)ee_base64Encoding;
@end