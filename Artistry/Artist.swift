import UIKit

struct Artist {
  let name: String
  let bio: String
  let image: UIImage
  var works: [Work]
  
  init(name: String, bio: String, image: UIImage, works: [Work]) {
    self.name = name
    self.bio = bio
    self.image = image
    self.works = works
  }
  
  static func artistsFromBundle() -> [Artist] {
    
    var artists = [Artist]()
    
    guard let path = NSBundle.mainBundle().pathForResource(
      "artists", ofType: "json"), data = NSData(contentsOfFile: path) else {
        return artists
    }
    
    do {
      let rootObject = try NSJSONSerialization.JSONObjectWithData(
        data, options: NSJSONReadingOptions.AllowFragments)
      
      guard let artistObjects = rootObject["artists"] as?
        [[String: AnyObject]] else {
        return artists
      }
      
      for artistObject in artistObjects {
        if let name = artistObject["name"] as? String,
          bio = artistObject["bio"]  as? String,
          imageName = artistObject["image"] as? String,
          image = UIImage(named: imageName),
          worksObject = artistObject["works"] as? [[String : String]]{
          var works = [Work]()
          for workObject in worksObject {
            if let workTitle = workObject["title"],
              workImageName = workObject["image"],
              workImage = UIImage(named: workImageName + ".jpg"),
              info = workObject["info"] {
              works.append(Work(title: workTitle,image: workImage,info: info, isExpanded: false))
            }
          }
          
          let artist = Artist(name: name, bio: bio, image: image, works: works)
          artists.append(artist)
        }
      }
      
    } catch {
      return artists
    }
    
    return artists
  }
  
}