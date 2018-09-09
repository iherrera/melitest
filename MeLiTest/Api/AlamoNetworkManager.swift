import Foundation
import Alamofire
import AlamofireImage


class AlamoNetworkManager: NetworkManagerProtocol{
    
    func downloadImage(imageURL: URL, onCompletion: @escaping ((UIImage) -> Void), onError: ((Error?) -> Void)?){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(imageURL).responseImage { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let image = response.result.value {
                onCompletion(image)
            }else{
                onError?(response.result.error)
            }
        }
        
    }

    //It is good idea to pass the model type as a parameter in order to reuse the same function with Codable and JSONDecoder
    func requestAndDecodeType<T:Codable>(type: T.Type, endpoint: Endpoint, parameters: [String: String], onCompletion: @escaping ((T) -> Void), onError: ((Error?) -> Void)?){
        
        var url = endpoint.url.absoluteString
        
        if parameters.count > 0{
            url += "&" + parameters.queryString
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(url).responseJSON { (responseObject) -> Void in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            guard responseObject.result.isSuccess else{
                let error : Error = responseObject.result.error!
                onError?(error)
                return
            }
            
            guard let dataResponse = responseObject.data else{
                let error = NSError(domain: "com.melitest.error.request-and-decode", code: ErrorRequestingServerEncodingError, userInfo: [NSLocalizedDescriptionKey : "Failed to request"])
                onError?(error)
                return
            }

            do {
                
                let decoder = JSONDecoder()
                let model = try decoder.decode(T.self, from: dataResponse) //Decode JSON Response Data
                
                onCompletion(model)
                
            } catch let parsingError {
                print("Error", parsingError)
                onError?(parsingError)
            }


        }
    }

}


