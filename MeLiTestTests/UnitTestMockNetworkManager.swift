@testable import MeLiTest
import Foundation
import Alamofire
import AlamofireImage

enum RequestApiResponse{
    case Success
    case NetworkError
    case ResponseError
    case EncodingError
}

enum DownloadImageResponse{
    case Success
    case NetworkError
    case OtherError
}

class UnitTestMockNetworkManager: NetworkManagerProtocol{
    
    var returnApiResponse: RequestApiResponse = .Success
    var returnDownloadImageResponse: DownloadImageResponse = .Success
    
    func downloadImage(imageURL: URL, onCompletion: @escaping ((UIImage) -> Void), onError: ((Error?) -> Void)?){
        
        switch returnDownloadImageResponse {
        case .Success:
            onCompletion(UIImage())
            break;
        case .NetworkError:
            let error = NSError(domain: "com.melitest.error.downloadimage", code: NSURLErrorCannotLoadFromNetwork, userInfo: [NSLocalizedDescriptionKey : "Failed to download image"])
            onError?(error)
            break;
        case .OtherError:
            let error = NSError(domain: "com.melitest.error.downloadimage", code: ErrorDownloadingImageServerOtherError, userInfo: [NSLocalizedDescriptionKey : "Failed to download image"])
            onError?(error)
            break;

        }
  
    }
    
    func requestAndDecodeType<T:Codable>(type: T.Type, endpoint: Endpoint, parameters: [String: String], onCompletion: @escaping ((T) -> Void), onError: ((Error?) -> Void)?){
        
        switch returnApiResponse {
            case .Success:
                switch endpoint{
                    case .PaymentMethods:
                        onCompletion([PaymentMethod(id: "id1", name: "Tarjeta 1", payment_type_id: "ptid1", secure_thumbnail: "https://testthumb")] as! T)
                        break;
                    case .CardIssuers:
                        onCompletion([CardIssuer(id: "id1", name: "Banco 1", secure_thumbnail: "https://testthumb")] as! T)
                        break;
                    case .Installments:
                        let cardIssuer = CardIssuer(id: "id1", name: "Banco 1", secure_thumbnail: "https://testthumb")
                        onCompletion([InstallmentResult(issuer: cardIssuer, payer_costs: [], payment_method_id: "pmid1", payment_type_id: "ptid1")] as! T)
                        break;
                }
                break;
            case .NetworkError:
                let error = NSError(domain: "com.melitest.error.request-and-decode", code: NSURLErrorCannotLoadFromNetwork, userInfo: [NSLocalizedDescriptionKey : "Failed to request"])
                onError?(error)
                break;
            case .ResponseError:
                let error = NSError(domain: "com.melitest.error.request-and-decode", code: ErrorRequestingServerResponseError, userInfo: [NSLocalizedDescriptionKey : "Failed to request"])
                onError?(error)
                break;
            case .EncodingError:
                let error = NSError(domain: "com.melitest.error.request-and-decode", code: ErrorRequestingServerEncodingError, userInfo: [NSLocalizedDescriptionKey : "Failed to request"])
                onError?(error)
                break;
                
        }
        
    }
    
   
    
}
