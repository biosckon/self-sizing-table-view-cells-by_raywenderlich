
import UIKit

class ArtistListViewController: UIViewController {
  
  let artists = Artist.artistsFromBundle()
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 140
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    NSNotificationCenter.defaultCenter().addObserverForName(
      UIContentSizeCategoryDidChangeNotification,
      object: nil, queue: NSOperationQueue.mainQueue()) {
        [weak self] _ in self?.tableView.reloadData()
    }
  }
  
  override func prepareForSegue(
    segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowArtist" {
      if let destination = segue.destinationViewController as?
        ArtistDetailViewController,
        indexPath = tableView.indexPathForSelectedRow {
        destination.selectedArtist = artists[indexPath.row]
      }
    }
  }
}

extension ArtistListViewController:
UITableViewDataSource {
  
  func tableView(
    tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
    return artists.count
  }
  
  func tableView(
    tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView
      .dequeueReusableCellWithIdentifier(
        "Cell", forIndexPath: indexPath) as! TVCell
    
    let artist = artists[indexPath.row]
    
    cell.bioLabel.text = artist.bio
    cell.artistImageView.image = artist.image
    cell.nameLabel.text = artist.name
    
    
    let txtColor = UIColor(
      red: 114/255, green: 114/255, blue: 114/255, alpha: 1.0)
    cell.bioLabel.textColor = txtColor
    
    let bgColor = UIColor(
      red: 255 / 255, green: 152 / 255, blue: 1 / 255, alpha: 1.0)
    cell.nameLabel.backgroundColor =  bgColor
    
    cell.nameLabel.textColor = UIColor.whiteColor()
    cell.nameLabel.textAlignment = .Center
    cell.selectionStyle = .None
    
    cell.nameLabel.font = UIFont.preferredFontForTextStyle(
      UIFontTextStyleHeadline)
    cell.bioLabel.font = UIFont.preferredFontForTextStyle(
      UIFontTextStyleBody)
    
    return cell
  }
}

