import Foundation
import Alamofire

enum Endpoint {

    case PaymentMethods
    case CardIssuers
    case Installments

    // MARK: - Public Properties
    
    var url: URL {
        let baseUrl = URL.getBaseUrl()
        switch self {
            case .PaymentMethods:
                return URL(string: baseUrl.appendingPathComponent("payment_methods?public_key=\(publicKey)").absoluteString.removingPercentEncoding!)!
            case .CardIssuers:
                return URL(string: baseUrl.appendingPathComponent("payment_methods/card_issuers?public_key=\(publicKey)").absoluteString.removingPercentEncoding!)!
            case .Installments:
                return URL(string: baseUrl.appendingPathComponent("payment_methods/installments?public_key=\(publicKey)").absoluteString.removingPercentEncoding!)!
        }
    }
    
    // MARK: - Private Properties
    
    private var publicKey: String{
        guard let info = Bundle.main.infoDictionary,
            let key = info["Public key"] as? String
            else {
                fatalError("Can not get public key from info.plist")
        }
        return key
    }
}

private extension URL {
    static func getBaseUrl() -> URL {
        guard let info = Bundle.main.infoDictionary,
            let urlString = info["Base url"] as? String,
            let url = URL(string: urlString) else {
            fatalError("Can not get base url from info.plist")
        }
        return url
    }
}
