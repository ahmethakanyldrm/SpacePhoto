//
//  ViewController.swift
//  SpacePhoto
//
//  Created by AHMET HAKAN YILDIRIM on 21.10.2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UI ELEMENTS
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var copyrightLabel: UILabel!
    
    
    // MARK: - PROPERTİES
    
    let networkController = NetworkController()
    
    
    // MARK: - LİFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = ""
        copyrightLabel.text = ""
        UIApplication.shared.isNetworkActivityIndicatorVisible = true 
        networkController.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
                self.updateUI(with: photoInfo)
            }
            
        }
    }
    
    // MARK: - FUNCTİONS
    
    func updateUI(with photoInfo:PhotoInfo) {
        networkController.fetchPhoto(from: photoInfo.url) { (image) in
            // NavigationBar ın Başlığını ayarlamak
            // arayüz elemanları hiçbir zaman main queue dışında değiştirilemez
            // öncelikle main queue ya dönülmesi gerekiyor. Bu işlemi de GCD fonksiyonları ile yapabiliriz
            DispatchQueue.main.async {
                // bu kod bloğu main queue de çalışacak
                self.imageView.image = image
                self.title = photoInfo.title
                self.descriptionLabel.text = photoInfo.description
                if let copyright = photoInfo.copyright {
                    self.copyrightLabel.text = copyright
                }else {
                    self.copyrightLabel.isHidden = true
                }
            }
        }
    }
    
    // MARK: - ACTİONS
    
    


}

