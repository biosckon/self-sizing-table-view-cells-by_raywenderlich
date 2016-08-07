import UIKit

class ArtistDetailViewController:
UIViewController {
  
  var selectedArtist: Artist!
  let moreInfoText = "Select For More Info >"
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    NSNotificationCenter.defaultCenter().addObserverForName(
      UIContentSizeCategoryDidChangeNotification,
      object: nil, queue: NSOperationQueue.mainQueue()) {
        [weak self] _ in self?.tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = selectedArtist.name
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 300
  }
}

extension ArtistDetailViewController:
UITableViewDataSource {
  
  func tableView(
    tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
    return selectedArtist.works.count
  }
  
  func tableView(
    tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier(
      "Cell", forIndexPath: indexPath) as! WorkTVCell
    
    let work = selectedArtist.works[indexPath.row]
    
    cell.workTitleLabel.text = work.title
    cell.workImageView.image = work.image
    
    cell.workTitleLabel.backgroundColor = UIColor(
      red: 204 / 255, green: 204 / 255, blue: 204 / 255, alpha: 1.0)
    cell.workTitleLabel.textAlignment = .Center
    cell.moreInfoTextView.textColor = UIColor(
      red: 114 / 255, green: 114 / 255, blue: 114 / 255, alpha: 1.0)
    
    cell.selectionStyle = .None
    
    cell.workTitleLabel.font = UIFont.preferredFontForTextStyle(
      UIFontTextStyleHeadline)
    cell.moreInfoTextView.font = UIFont.preferredFontForTextStyle(
      UIFontTextStyleFootnote)
    
    return cell
  }
}

extension ArtistDetailViewController:
UITableViewDelegate {
  
  func tableView(
    tableView: UITableView,
    didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    guard let cell = tableView.cellForRowAtIndexPath(indexPath) as?
      WorkTVCell else {return}
    
    var work = selectedArtist.works[indexPath.row]
    
    work.isExpanded = !work.isExpanded
    selectedArtist.works[indexPath.row] = work
    
    cell.moreInfoTextView.text = work.isExpanded ? work.info : moreInfoText
    cell.moreInfoTextView.textAlignment = work.isExpanded ? .Left : .Center
    
    UIView.animateWithDuration(0.3) {
      cell.contentView.layoutIfNeeded()
    }
    
    tableView.beginUpdates()
    tableView.endUpdates()
    
    tableView.scrollToRowAtIndexPath(
      indexPath, atScrollPosition: .Top, animated: true)
  }
}


