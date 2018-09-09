import UIKit

class Payment: NSObject {
    var amount: Double?
    var payment_method_id: String?
    var card_issuer_id: String?
    var installments: Int?
    
    func amountString() -> String?{
        guard let theAmount = amount else{
            return nil
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.usesGroupingSeparator = false;
        formatter.locale = Locale(identifier: "en_US")
        
        return formatter.string(from: NSNumber(value: theAmount))
        
    }
}
