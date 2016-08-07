import UIKit

class WorkTVCell: UITableViewCell {
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  @IBOutlet weak var workImageView: UIImageView!
  @IBOutlet weak var workTitleLabel: UILabel!
  @IBOutlet weak var moreInfoTextView: UITextView!
  
}
