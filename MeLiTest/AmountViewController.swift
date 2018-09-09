import UIKit

class AmountViewController: UIViewController {
    
    @IBOutlet weak var amountTextField: UITextField!
    
    var payment: Payment!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Monto"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Siguiente", style: .done, target: self, action: #selector(nextButtonPressed(_:)))
        payment.amount = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        amountTextField.becomeFirstResponder()
    }
    
    @objc func nextButtonPressed(_ sender: Any) {
        guard let amount = amountTextField.text, amount.isValidDouble(maxDecimalPlaces: 2) else{
            let alert = UIAlertController(title: nil, message: "Ingrese un monto válido", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true)
            return;
        }
        payment.amount = Double(amount)
        self.performSegue(withIdentifier: "ShowCreditCardTableViewController", sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCreditCardTableViewController" {
            let creditCardTableViewController = segue.destination as! CreditCardTableViewController
            creditCardTableViewController.payment = self.payment
            
        }
    }

}
