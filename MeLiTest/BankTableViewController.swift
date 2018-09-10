import UIKit

class BankTableViewController: UITableViewController {
    
    var apiManager = ApiManager.shared
    var payment: Payment!
    var banks: [CardIssuer] = []
    var downloadedImages = [String: DownloadedImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Banco"
        self.clearsSelectionOnViewWillAppear = false
        tableView.rowHeight = 50
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Siguiente", style: .done, target: self, action: #selector(nextButtonPressed(_:)))
        payment.card_issuer_id = nil
        getBanks()

    }
    
    func getBanks(){
        apiManager.getCardIssuers(paymentMethodId: payment.payment_method_id!, onCompletion: {(cardIssuers) in
            self.banks = cardIssuers
            self.tableView.reloadData()
        }) {(error) in
            let alert = UIAlertController(title: nil, message: error?.localizedDescription ??
                "Hubo un error al cargar los bancos", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @objc func nextButtonPressed(_ sender: Any) {
        guard payment.card_issuer_id != nil else{
            let alert = UIAlertController(title: nil, message: "Debe seleccionar un banco", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true)
            return;
        }
        self.performSegue(withIdentifier: "ShowInstallmentsTableViewController", sender: nil)
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
        return banks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankCell", for: indexPath) as! ImageAndNameTableViewCell
        let bank = banks[indexPath.row]
        cell.nameLabel.text = bank.name
        setCellImage(imageView: cell.cellImageView, urlString: bank.secure_thumbnail)
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
        
        let bank = banks[indexPath.row]
        payment.card_issuer_id = bank.id
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowInstallmentsTableViewController" {
            let installmentsTableViewController = segue.destination as! InstallmentsTableViewController
            installmentsTableViewController.payment = self.payment
            
        }
    }
    
}
