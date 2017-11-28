
#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>



@interface InAppPurchasesManager : NSObject <UIAlertViewDelegate,SKProductsRequestDelegate, SKPaymentTransactionObserver> {
    NSDictionary *gameData;
    NSString *errorMsg;
}

@property (nonatomic,strong)NSString *orderID;

+ (InAppPurchasesManager *)sharedInAppPurchasesManager;
- (void)requestProductData:(NSArray *) v;
- (void)loadStore;
- (BOOL)canMakePurchases;
- (void)purchase:(NSString *)productID jsonHelper:(NSDictionary *)json;
- (void)serverComit:(NSString *)productIdentifier receipt:(NSString *)receipt;

@end
