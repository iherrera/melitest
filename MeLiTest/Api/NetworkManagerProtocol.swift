import UIKit

let ErrorRequestingServerEncodingError = -99920
let ErrorRequestingServerResponseError = -99921

let ErrorDownloadingImageServerOtherError = -99930

protocol NetworkManagerProtocol {
    
    func requestAndDecodeType<T:Codable>(type: T.Type, endpoint: Endpoint, parameters: [String: String], onCompletion: @escaping ((T) -> Void), onError: ((Error?) -> Void)?)
    func downloadImage(imageURL: URL, onCompletion: @escaping ((UIImage) -> Void), onError: ((Error?) -> Void)?)

}
