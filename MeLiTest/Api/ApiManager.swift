import Foundation
import Alamofire

class ApiManager {
    // MARK: - Private Properties
    var manager: NetworkManagerProtocol
    static var shared = ApiManager(manager:AlamoNetworkManager())
    
    // MARK: - Designated Initializer
    init(manager: NetworkManagerProtocol) {
        
        self.manager = manager
        
        //If we are UITesting, we want to use a mocked/seeded NetworkManager
        if CommandLine.arguments.contains("--uitesting"){
            self.manager = UITestMockNetworkManager()
        }

    }
    
    // MARK: - Funcs
  
    func getPaymentMethods(onCompletion: @escaping ((Array<PaymentMethod>) -> Void), onError: @escaping ((Error?) -> Void)){
        
        manager.requestAndDecodeType(type: [PaymentMethod].self, endpoint: .PaymentMethods, parameters:
            [:], onCompletion: { (paymentMethods) in
                onCompletion(paymentMethods)
        }) { (error) in
            onError(error)
        }
        
    }
    
    func getCardIssuers(paymentMethodId: String, onCompletion: @escaping ((Array<CardIssuer>) -> Void), onError: @escaping ((Error?) -> Void)){
        
        manager.requestAndDecodeType(type: [CardIssuer].self, endpoint: .CardIssuers, parameters:
            ["payment_method_id":paymentMethodId], onCompletion: { (cardIssuers) in
                onCompletion(cardIssuers)
        }) { (error) in
            onError(error)
        }
        
    }
    
    func getInstallments(amount: String, paymentMethodId: String, cardIssuerId: String, onCompletion: @escaping ((Array<InstallmentResult>) -> Void), onError: @escaping ((Error?) -> Void)){
        
        manager.requestAndDecodeType(type: [InstallmentResult].self, endpoint: .Installments, parameters:
            ["amount":amount, "payment_method_id":paymentMethodId, "issuer.id":cardIssuerId], onCompletion: { (installmentResults) in
                onCompletion(installmentResults)
        }) { (error) in
            onError(error)
        }
        
    }
    
    func downloadImage(imageURL: URL, onCompletion: @escaping ((UIImage) -> Void), onError: ((Error?) -> Void)?){
        manager.downloadImage(imageURL: imageURL, onCompletion: { (image) in
            onCompletion(image)
        }) { (error) in
            onError?(error)
        }
    }
}

