//
//  WipViewModel.swift
//  Wip_Assignment
//
//  Created by Abhijit on 06/01/22.
//

import Foundation
import UIKit


class ContactAPI: NSObject {
    
    var bindviewModelToViewControlller : (() -> Void) = { return }
    
    var contactApiData: ContactModal? {
        didSet {
            self.bindviewModelToViewControlller()
        }
    }
    
    override init() {
        super.init()
        self.getContacts()
    }
    
    
    func getContacts() {
        if let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") {
            URLSession.shared.dataTask(with: url) {
                data, response, err in
                if let data = data {
                    if let value = String(data: data, encoding: String.Encoding.ascii) {
                        if let jsonData = value.data(using: String.Encoding.utf8) {
                            do {
                                print(data)
                                self.contactApiData = try JSONDecoder().decode(ContactModal.self, from: jsonData)
                            } catch let jsonError as NSError {
                                print("JSON decode failed: \(jsonError.localizedDescription)")
                            }
                        }
                    }
                } else {
                    print("Data not found")
                }
            }.resume()
        }
    }
}

extension UIImageView {
    
    var cachedImage:UIImage? {
        return ImageCache.sharedCache.object(forKey: self.imageURL as AnyObject) as? UIImage
    }
    
    func load(withURL url: String, _ placeholder: UIImage?, placeholderFor imageViewType:String, completionHandler completion:((_ image:UIImage) -> Void)?) {
        if let url = URL(string: url) {
            self.image = placeholder
            
            loadImage(withURL: url.absoluteString, placeholderFor: imageViewType, completionHandler: completion)
        } else {
            //self.contentMode = .scaleAspectFit
            self.image = placeholder
        }
    }
    
    /**
     Loads the image from the given server URL
     
     - parameter url: image url to load
     */
    func loadImage(withURL url:String, placeholderFor imageViewType:String, completionHandler completion:((_ image:UIImage) -> Void)?) {
        
        if let URL = URL(string: url) {
            self.imageURL = url
            
            // If the cached image is found for the requested url, then just load the image from cache and exit
            if cachedImage != nil {
                //self.contentMode = .scaleAspectFit
                if completion != nil {
                    completion!(cachedImage!)
                } else {
                    self.setImage(image: cachedImage!, canAnimate: true)
                }
                
                self.imageURL = nil
                return
            }
            
            let request = URLRequest(url: URL)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if error == nil {
                    if let imageData = data {
                        if let myImage:UIImage = UIImage(data: imageData) {
                            if self.imageURL == url {
                                // cache the image
                                ImageCache.sharedCache.setObject(myImage, forKey: self.imageURL as AnyObject, cost: imageData.count)
                                
                                // update the ui with the downloaded image
                                DispatchQueue.main.async {
                                    // notify the completion handler if user wish to handle the downloaded image. Otherwise just load the image with alpha animation
                                    if completion != nil {
                                        completion!(myImage)
                                    } else {
                                        self.setImage(image: myImage, canAnimate: true)
                                    }
                                }
                            }
                        } else {
                            
                            if self.imageURL == url {
                                DispatchQueue.main.async {
                                    //self.contentMode = .scaleAspectFit
                                    let defaultImage = UIImage(named: imageViewType)!
                                    self.setImage(image: defaultImage, canAnimate: true)
                                }
                            }
                        }
                        
                        self.imageURL = nil
                    } else {
                        if self.imageURL == url {
                            DispatchQueue.main.async {
                                //self.contentMode = .scaleAspectFit
                                let defaultImage = UIImage(named: imageViewType)!
                                self.setImage(image: defaultImage, canAnimate: true)
                            }
                        }
                    }
                } else {
                    
                    if self.imageURL == url {
                        DispatchQueue.main.async {
                            //self.contentMode = .scaleAspectFit
                            let defaultImage = UIImage(named: imageViewType)!
                            self.setImage(image: defaultImage, canAnimate: true)
                        }
                    }
                }
            })
            
            task.resume()
        } else {
            print("Invalid image url given. The image url should be a server URL.")
        }
    }
    
    func setImage(image: UIImage, canAnimate animate: Bool) {
        self.alpha = 0
        //self.contentMode = .scaleAspectFit
        self.image = image
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        })
    }
    
    /**
     Resizes the given image to a best matching size to fit in the UIImageView
     
     - parameter image: iamge to resize
     
     - returns: resized image view
     */
    func resizeImage(image:inout UIImage) -> UIImage {
        var newImageSize: CGSize = self.frame.size
        if image.size.height > newImageSize.height || image.size.width > newImageSize.width {
            newImageSize = self.getSizeToFitInImageView(imageSize: image.size, imageViewSize: newImageSize)
            UIGraphicsBeginImageContextWithOptions(newImageSize, false, 0.0)
            image.draw(in: CGRect(x: 0, y: 0, width: newImageSize.width, height: newImageSize.height))
            image = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }
        return image
    }
    
    func getSizeToFitInImageView(imageSize: CGSize, imageViewSize: CGSize) -> CGSize {
        var requiredSize: CGSize = CGSize.zero
        let requiredHeight: CGFloat = (imageSize.height * imageViewSize.width) / imageSize.width
        requiredSize = CGSize(width: imageViewSize.width, height: requiredHeight)
        return requiredSize
    }
    
    private struct AssociatedKeys {
        static var DescriptiveName = "nsh_DescriptiveName"
    }
    
    var imageURL: String! {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? String
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.DescriptiveName,
                    newValue as NSString?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
}
class ImageCache {
    static let sharedCache = { () -> NSCache<AnyObject, AnyObject> in
        let cache = NSCache<AnyObject, AnyObject>()
        cache.name = "MyImageCache"
        cache.countLimit = 20 // Max 20 images in memory.
        cache.totalCostLimit = 10*1024*1024 // Max 10MB used.
        return cache
    }()
}
