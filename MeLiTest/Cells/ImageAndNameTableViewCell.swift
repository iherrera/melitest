import UIKit

class ImageAndNameTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            self.accessoryType = .checkmark
        }else{
            self.accessoryType = .none
        }
    }

}
