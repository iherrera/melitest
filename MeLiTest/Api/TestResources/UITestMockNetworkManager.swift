import Foundation
import Alamofire
import AlamofireImage


class UITestMockNetworkManager: NetworkManagerProtocol{

    func downloadImage(imageURL: URL, onCompletion: @escaping ((UIImage) -> Void), onError: ((Error?) -> Void)?){
        
        if imageURL.absoluteString == "https://thumbimage"{
            onCompletion(UIImage(named: "testThumb")!)
        }else{
            let error = NSError(domain: "com.melitest.error.downloadimage", code: ErrorDownloadingImageServerOtherError, userInfo: [NSLocalizedDescriptionKey : "Failed to download image"])
            onError?(error)
        }
    }
    
    
    func requestAndDecodeType<T:Codable>(type: T.Type, endpoint: Endpoint, parameters: [String: String], onCompletion: @escaping ((T) -> Void), onError: ((Error?) -> Void)?){
        
        switch endpoint{
            case .PaymentMethods:
                onCompletion([PaymentMethod(id: "id1", name: "Tarjeta 1", payment_type_id: CreditCardTypeId, secure_thumbnail: "https://thumbimage")] as! T)
                break;
            case .CardIssuers:
                onCompletion([CardIssuer(id: "id1", name: "Banco 1", secure_thumbnail: "https://thumbimage")] as! T)
                break;
            case .Installments:
                let cardIssuer = CardIssuer(id: "id1", name: "Banco 1", secure_thumbnail: "https://thumbimage")
                let installment = Installment(installments: 1, recommended_message: "1 cuota de $400", total_amount: 400)
                onCompletion([InstallmentResult(issuer: cardIssuer, payer_costs: [installment], payment_method_id: "pmid1", payment_type_id: "ptid1")] as! T)
                break;
        }
        
    }
    
    
    
}
