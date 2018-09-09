import UIKit

let CreditCardTypeId = "credit_card"

class CreditCardTableViewController: UITableViewController {
    
    var apiManager = ApiManager.shared
    var payment: Payment!
    var creditCards: [PaymentMethod] = []
    var downloadedImages = [String: DownloadedImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tarjeta de Crédito"
        self.clearsSelectionOnViewWillAppear = false
        tableView.rowHeight = 50
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Siguiente", style: .done, target: self, action: #selector(nextButtonPressed(_:)))
        payment.payment_method_id = nil

        apiManager.getPaymentMethods(onCompletion: {(paymentMethods) in
            self.creditCards = paymentMethods.filter{$0.payment_type_id == CreditCardTypeId} //We only want Credit Cards
            self.tableView.reloadData()
        }) {(error) in
            let alert = UIAlertController(title: nil, message: error?.localizedDescription ??
                "Hubo un error al cargar las tarjetas de crédito", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @objc func nextButtonPressed(_ sender: Any) {
        guard payment.payment_method_id != nil else{
            let alert = UIAlertController(title: nil, message: "Debe seleccionar una tarjeta de crédito", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true)
            return;
        }
        self.performSegue(withIdentifier: "ShowBankTableViewController", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        downloadedImages.removeAll()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreditCardCell", for: indexPath) as! ImageAndNameTableViewCell
        let creditCard = creditCards[indexPath.row]
        cell.nameLabel.text = creditCard.name
        setCellImage(imageView: cell.cellImageView, urlString: creditCard.secure_thumbnail)
        return cell
        
    }
    
    func setCellImage(imageView: UIImageView, urlString: String?){
        guard let theUrlString = urlString else{
            imageView.image = nil
            return
        }
        if let imageD = downloadedImages[theUrlString]{
            if imageD.status == .Downloaded{
                imageView.image = imageD.image
            }
        }else{
            imageView.image = nil
            let imageD = DownloadedImage()
            imageD.status = .Downloading
            downloadedImages[theUrlString] = imageD
            apiManager.downloadImage(imageURL: URL(string: theUrlString)!, onCompletion: { (image) in
                imageD.image = image
                imageD.status = .Downloaded
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }) { (error) in
                self.downloadedImages.removeValue(forKey: theUrlString)
            }
        }
        
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let creditCard = creditCards[indexPath.row]
        payment.payment_method_id = creditCard.id
        
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBankTableViewController" {
            let bankTableViewController = segue.destination as! BankTableViewController
            bankTableViewController.payment = self.payment
            
        }
    }

}
