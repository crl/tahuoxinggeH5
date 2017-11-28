
#import "InAppPurchasesManager.h"
#import "IOSGate.h"


@implementation InAppPurchasesManager

+ (InAppPurchasesManager *)sharedInAppPurchasesManager{
    if (!instance) {
        instance = [[super allocWithZone:NULL] init];
    }
    return instance;
}

static InAppPurchasesManager *instance = nil;

NSMutableDictionary* productDic;

- (id)copyWithZone:(NSZone *)zone {
    return self;
}



- (id)init {
    if (self == [super init]) {
        productDic=[[NSMutableDictionary alloc] init];
        return self;
    }
    
    return nil;
}

#pragma mark - product identifiers
- (void)requestProductData:(NSArray*) v {
    NSSet * set = [NSSet setWithArray:v];
    SKProductsRequest * request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];

    request.delegate = self;
    [request start];
 
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *products = response.products;
    
    if (products.count == 0) {
        NSLog(@"无法获取产品信息");
        
        for (NSString* invalidProductId in response.invalidProductIdentifiers) {
            NSLog(@"Invalid: %@", invalidProductId);
        }
        return;
    }
    
    for (SKProduct *product in products) {
        
         NSLog(@"the product key: %@ is have",product.productIdentifier);
        
        [productDic setObject:product forKey:product.productIdentifier];
    }
    
    for (NSString *key in response.invalidProductIdentifiers) {
        NSLog(@"the product key: %@ is error",key);
    }
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    [self showAlert:@"The In-App Store is currently unavailable, please try again later."];
}

#pragma -
#pragma Public methods

//
// call this method once on startup
//
- (void)loadStore {
    // restarts any purchases if they were interrupted last time the app was open
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

//
// call this before making a purchase
//
- (BOOL)canMakePurchases {
    return [SKPaymentQueue canMakePayments];
}

//
// kick off the upgrade transaction
//
- (void)purchase:(NSString *)productID jsonHelper:(NSDictionary *)json{
    gameData=[[NSDictionary alloc] initWithDictionary:json copyItems:TRUE];
    
    //NSString *postURL=[gameData objectForKey:@"sid"];
    SKProduct *product =[productDic objectForKey:productID];
    
    if(product==nil){
        NSString *msg=[[NSString alloc] initWithFormat:@"%@ not exist!",productID];
        [self showAlert:msg];
        return;
    }
    
    SKPayment *payment=[SKPayment paymentWithProduct:product];
    
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

//
// removes the transaction from the queue and posts a notification with the transaction result
//
- (void)finishTransaction:(SKPaymentTransaction *)transaction wasSuccessful:(BOOL)wasSuccessful {
    // remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    NSString *productIdentifier = transaction.payment.productIdentifier;
    NSData *data=transaction.transactionReceipt;
    NSString *receipt =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    //向自己的服务器验证购买凭证
    NSString *postURL=[gameData objectForKey:@"vurl"];
    
    if ([postURL length]>5) {
        [self serverComit:productIdentifier receipt:receipt];
    }else{
        NSLog(@"%@",productIdentifier);
    }
    
}

-(void)serverComit:(NSString *)productIdentifier receipt:(NSString *)receipt
{
    if ([productIdentifier length] > 0) {
        // 向自己的服务器验证购买凭证
        NSString *postURL=[gameData objectForKey:@"vurl"];
        
        //test;
        //postURL=@"http://192.168.2.163:9001/charge/apple/pay.aspx";
        
        NSLog(@"postURL:%@",postURL);
        
        NSURL *serverURL = [[NSURL alloc] initWithString: postURL];
        NSString *userInfo=[gameData objectForKey:@"userInfo"];
        NSString *productID=[gameData objectForKey:@"productID"];
        NSString *appID=[gameData objectForKey:@"appID"];
        
        
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        long long now = [[NSNumber numberWithDouble:time] longLongValue];
        NSString *orderID=[[NSString alloc] initWithFormat:@"lingyu_%lld",now];
        
        NSString *post=[[NSString alloc] initWithFormat:@"receipt=%@&userInfo=%@&orderID=%@&productID=%@&appID=%@",receipt,userInfo,orderID,productID,appID];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:serverURL];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        NSURLConnection *connection = [[NSURLConnection alloc]
                                       initWithRequest:request
                                       delegate:self];
        
        connection=nil;
        
        
    }else{
        [self showAlert:@"产品id为空"];
    }
    //[self finishTransaction:transaction wasSuccessful:YES];
}


- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    [self finishTransaction:transaction wasSuccessful:NO];
    
    if(transaction.error.code == SKErrorPaymentCancelled) {
        NSLog(@"用户取消交易");
        return;
    }
    
    NSString * productIdentifier =transaction.payment.productIdentifier;
    NSMutableString *v = [[NSMutableString alloc] initWithString:@""];
    if ([productIdentifier length]>0) {
        [v appendString:productIdentifier];
    }
    
    [v appendString:@"购买失败!"];
    [v appendFormat:@"ErrorCode:%ld",transaction.error.code];
    
    if ([errorMsg isEqualToString:v]) {
        return;
    }
    errorMsg=v;
    [self showAlert:errorMsg];
    NSLog(@"Error: %@", transaction.error);
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    // 对于已购商品，处理恢复购买的逻辑
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

#pragma mark -
#pragma mark SKPaymentTransactionObserver methods

//
// called when the transaction status is updated
//
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        NSString *msg=[[NSString alloc] initWithFormat:@"Transaction state: %ld",(long)transaction.transactionState];
        NSLog(@"%@",msg);
        
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                //dispatchEvent(g_ctx,@"msg01",msg);
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                //dispatchEvent(g_ctx,@"msg02",msg);
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                //dispatchEvent(g_ctx,@"msg03",msg);
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    }
}


- (void)showAlert:(NSString *)msg {
    
    UIAlertController* alert=[[UIAlertController alloc] init];
    
    UIAlertAction *sure=[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:sure];
    
    UIViewController* rootViewController=  [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    [rootViewController presentViewController:alert animated:true completion:nil];
}

#pragma mark connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSDictionary *json=nil;
    NSString *msg=nil;
    
    NSString *jsonString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([jsonString length]<3) {
        return;
    }
    
    NSData* jsonData;
    jsonData = [jsonString dataUsingEncoding: NSUTF8StringEncoding];
    
    NSError *error;
    json= [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    
    IOSGate* gate=[IOSGate sharedInstance];
    if (json == nil) {
        NSLog(@"json parse failed:%@ \r\n",jsonString);
        
        msg=[[NSString alloc] initWithFormat:@"0|支付失败:%@",jsonString];
        [gate send:@"pay_back" Value:msg];
        return;
    }
    
    int code=[[json objectForKey:@"code"] intValue];
    NSString *remoteData=[json objectForKey:@"data"];
    
    
    
    if (code==1) {
        NSString *productName=[gameData objectForKey:@"productName"];
        msg=[[NSString alloc] initWithFormat:@"1|成功购买:%@",productName];
    }else{
        msg=@"0|支付失败!";
        if([remoteData length]>0){
            msg=[[NSString alloc] initWithFormat:@"0|支付失败:%@",remoteData];
        }
    }
    
    [gate send:@"pay_back" Value:msg];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSInteger code=[(NSHTTPURLResponse *)response statusCode];
	switch(code) {
		case 200:
		case 206:
			break;
		case 304:
			break;
		case 400:
			break;
		case 404:
            break;
		case 416:
			break;
		case 403:
			break;
		case 401:
		case 500:
			break;
		default:
			break;
	}
    NSString *msg=[[NSString alloc] initWithFormat:@"验证服务器状态返回:%ld",(long)code];
    NSLog(@"%@",msg);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSString *msg=[[NSString alloc] initWithFormat:@"验证服务器错误返回:%@",[error localizedDescription]];
    [self showAlert:msg];
}


@end
