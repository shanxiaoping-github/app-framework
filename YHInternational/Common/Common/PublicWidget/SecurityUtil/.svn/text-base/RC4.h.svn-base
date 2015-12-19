//
//  RC4.h
//  Enigma
//
//  Created by le grand fromage on 9/3/09.
//  Copyright 2009 WildMouse Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface RC4 : NSObject{
	//data members
	int i;
	int j;
	unsigned char s[256];
    NSString* key;
}

//properties
@property (nonatomic,retain) NSString* key;

- (void)initialize;
- (unsigned char)KSA;
- (void)swap:(int)iFirstArgument swap2:(int)iSecondArgument;
- (id)initWithKey:(NSString *)initKey;
- (NSString *)encryptString:(NSString *)sToEncrypt;
- (NSString *)decryptString:(NSString *)sToDecrypt;

@end