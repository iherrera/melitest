@testable import MeLiTest
import XCTest

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}

class ApiManagerTests: XCTestCase {
    
    var mockManager: UnitTestMockNetworkManager?
    
    override func setUp() {
        super.setUp()
        
        //We will use a mocked network manager to simulate successful and failed calls
        
        let apiManager = ApiManager.shared
        mockManager = UnitTestMockNetworkManager()
        apiManager.manager = mockManager!
    }
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    // MARK: - getPaymentMethods

    func testGetPaymentMethodsWithSuccess(){
        mockManager?.returnApiResponse = .Success
        ApiManager.shared.getPaymentMethods(onCompletion: { (paymentMethods) in
            
        }) { (error) in
            XCTFail("Should succeed")
        }
        
    }
    
    func testGetPaymentMethodsWithNetworkError(){
        mockManager?.returnApiResponse = .NetworkError
        ApiManager.shared.getPaymentMethods(onCompletion: { (paymentMethods) in
            XCTFail("Request should fail")
        }) { (error) in
            if let theError = error{
                XCTAssertEqual(theError.code, NSURLErrorCannotLoadFromNetwork, "Error code not correct")
            }else{
                XCTFail("No error returned")
            }
        }
        
    }
    
    func testGetPaymentMethodsWithResponseError(){
        mockManager?.returnApiResponse = .ResponseError
        ApiManager.shared.getPaymentMethods(onCompletion: { (paymentMethods) in
            XCTFail("Request should fail")
        }) { (error) in
            if let theError = error{
                XCTAssertEqual(theError.code, ErrorRequestingServerResponseError, "Error code not correct")
            }else{
                XCTFail("No error returned")
            }
        }
        
    }
    
    func testGetPaymentMethodsWithEncodingError(){
        mockManager?.returnApiResponse = .EncodingError
        ApiManager.shared.getPaymentMethods(onCompletion: { (paymentMethods) in
            XCTFail("Request should fail")
        }) { (error) in
            if let theError = error{
                XCTAssertEqual(theError.code, ErrorRequestingServerEncodingError, "Error code not correct")
            }else{
                XCTFail("No error returned")
            }
        }
        
    }
    
    // MARK: - getCardIssuers
    
    func testGetCardIssuersWithSuccess(){
        mockManager?.returnApiResponse = .Success
        ApiManager.shared.getCardIssuers(paymentMethodId: "pmid1", onCompletion: { (cardIssuers) in
            
        }) { (error) in
            XCTFail("Should succeed")
        }
    }
    
    func testGetCardIssuersWithNetworkError(){
        mockManager?.returnApiResponse = .NetworkError
        ApiManager.shared.getCardIssuers(paymentMethodId: "pmid1", onCompletion: { (cardIssuers) in
            XCTFail("Request should fail")
        }) { (error) in
            if let theError = error{
                XCTAssertEqual(theError.code, NSURLErrorCannotLoadFromNetwork, "Error code not correct")
            }else{
                XCTFail("No error returned")
            }
        }
        
    }
    
    func testGetCardIssuersWithResponseError(){
        mockManager?.returnApiResponse = .ResponseError
        ApiManager.shared.getCardIssuers(paymentMethodId: "pmid1", onCompletion: { (cardIssuers) in
            XCTFail("Request should fail")
        }) { (error) in
            if let theError = error{
                XCTAssertEqual(theError.code, ErrorRequestingServerResponseError, "Error code not correct")
            }else{
                XCTFail("No error returned")
            }
        }
        
    }
    
    func testGetCardIssuersWithEncodingError(){
        mockManager?.returnApiResponse = .EncodingError
        ApiManager.shared.getCardIssuers(paymentMethodId: "pmid1", onCompletion: { (cardIssuers) in
            XCTFail("Request should fail")
        }) { (error) in
            if let theError = error{
                XCTAssertEqual(theError.code, ErrorRequestingServerEncodingError, "Error code not correct")
            }else{
                XCTFail("No error returned")
            }
        }
        
    }
    
    // MARK: - getInstallments
    
    func testGetInstallmentsWithSuccess(){
        mockManager?.returnApiResponse = .Success
        ApiManager.shared.getInstallments(amount: "400", paymentMethodId: "pmid1", cardIssuerId: "iid1", onCompletion: { (installmentResults) in
            
        }) { (error) in
            XCTFail("Should succeed")
        }
    }
    
    func testGetInstallmentsWithNetworkError(){
        mockManager?.returnApiResponse = .NetworkError
        ApiManager.shared.getInstallments(amount: "400", paymentMethodId: "pmid1", cardIssuerId: "iid1", onCompletion: { (installmentResults) in
            XCTFail("Request should fail")
        }) { (error) in
            if let theError = error{
                XCTAssertEqual(theError.code, NSURLErrorCannotLoadFromNetwork, "Error code not correct")
            }else{
                XCTFail("No error returned")
            }
        }
        
    }
    
    func testGetInstallmentsWithResponseError(){
        mockManager?.returnApiResponse = .ResponseError
        ApiManager.shared.getInstallments(amount: "400", paymentMethodId: "pmid1", cardIssuerId: "iid1", onCompletion: { (installmentResults) in
            XCTFail("Request should fail")
        }) { (error) in
            if let theError = error{
                XCTAssertEqual(theError.code, ErrorRequestingServerResponseError, "Error code not correct")
            }else{
                XCTFail("No error returned")
            }
        }
        
    }
    
    func testGetInstallmentsWithEncodingError(){
        mockManager?.returnApiResponse = .EncodingError
        ApiManager.shared.getInstallments(amount: "400", paymentMethodId: "pmid1", cardIssuerId: "iid1", onCompletion: { (installmentResults) in
            XCTFail("Request should fail")
        }) { (error) in
            if let theError = error{
                XCTAssertEqual(theError.code, ErrorRequestingServerEncodingError, "Error code not correct")
            }else{
                XCTFail("No error returned")
            }
        }
        
    }
    
    // MARK: - downloadImage
    
    func testDownloadImageWithSuccess(){
        mockManager?.returnDownloadImageResponse = .Success
        ApiManager.shared.downloadImage(imageURL: URL(string: "http://something")!, onCompletion: { (image) in
            
        }) { (error) in
            XCTFail("Should succeed")
        }
 
    }
    
    func testDownloadImageWithNetworkError(){
        mockManager?.returnDownloadImageResponse = .NetworkError
        ApiManager.shared.downloadImage(imageURL: URL(string: "http://something")!, onCompletion: { (image) in
            XCTFail("Request should fail")
        }) { (error) in
            if let theError = error{
                XCTAssertEqual(theError.code, NSURLErrorCannotLoadFromNetwork, "Error code not correct")
            }else{
                XCTFail("No error returned")
            }
            
        }
        
    }
    
    func testDownloadImageWithOtherError(){
        mockManager?.returnDownloadImageResponse = .OtherError
        ApiManager.shared.downloadImage(imageURL: URL(string: "http://something")!, onCompletion: { (image) in
            XCTFail("Request should fail")
        }) { (error) in
            if let theError = error{
                XCTAssertEqual(theError.code, ErrorDownloadingImageServerOtherError, "Error code not correct")
            }else{
                XCTFail("No error returned")
            }
            
        }
        
    }
    
    
    
}
