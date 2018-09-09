import UIKit

let FlowEndedNotification = "FlowEndedNotification"

class MainViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MeLiTest"
        NotificationCenter.default.addObserver(self, selector: #selector(self.flowEnded(notification:)), name: Notification.Name(FlowEndedNotification), object: nil)
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "ShowAmountViewController", sender: nil)
    }
    
    @objc func flowEnded(notification: Notification){
        if notification.name.rawValue == FlowEndedNotification{
            navigationController?.popToRootViewController(animated: true)
            if let payment = notification.userInfo?["payment"] as? Payment{
                let alert = UIAlertController(title: nil, message: "amount: \(payment.amountString()!)\npayment_method_id: \(payment.payment_method_id!)\ncard_issuer_id: \(payment.card_issuer_id!)\ninstallments: \(payment.installments!)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alert, animated: true)
            }
            
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAmountViewController" {
            let amountViewController = segue.destination as! AmountViewController
            amountViewController.payment = Payment()
            
        }
    }


}
