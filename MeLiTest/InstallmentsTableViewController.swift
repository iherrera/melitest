import UIKit

class InstallmentsTableViewController: UITableViewController {
    
    var apiManager = ApiManager.shared
    var payment: Payment!
    var installments: [Installment] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cuotas"
        self.clearsSelectionOnViewWillAppear = false
        tableView.rowHeight = 50
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finalizar", style: .done, target: self, action: #selector(endButtonPressed(_:)))
        payment.installments = nil
       
        apiManager.getInstallments(amount: payment.amountString()!, paymentMethodId: payment.payment_method_id!, cardIssuerId: payment.card_issuer_id!, onCompletion: { (installmentResults) in
            if installmentResults.count > 0{
                self.installments = installmentResults[0].payer_costs
                self.tableView.reloadData()
            }
            
        }) { (error) in
            let alert = UIAlertController(title: nil, message: error?.localizedDescription ??
                "Hubo un error al cargar las cuotas", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
    @objc func endButtonPressed(_ sender: Any) {
        guard payment.installments != nil else{
            let alert = UIAlertController(title: nil, message: "Debe seleccionar las cuotas deseadas", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true)
            return;
        }
        
        NotificationCenter.default.post(
            name: NSNotification.Name(FlowEndedNotification),
            object: self,
            userInfo: ["payment": payment])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return installments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstallmentCell", for: indexPath) as! NameTableViewCell
        let installment = installments[indexPath.row]
        cell.nameLabel.text = installment.recommended_message
        return cell
        
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let installment = installments[indexPath.row]
        payment.installments = installment.installments
        
    }

}
