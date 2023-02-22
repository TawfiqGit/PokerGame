//
//  CarpetCell.swift
//  PokerGame
//
//  Created by admin on 20/02/2023.
//

import UIKit

class CarpetCell: UICollectionViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    @IBOutlet weak var uiImgViewCard: UIImageView!
    
    var cellViewModel: Carpet? {
        didSet {
            let url = URL(string: cellViewModel?.card ?? "")!
            downloadImage(from: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    func initView() {
        backgroundColor = .clear
        preservesSuperviewLayoutMargins = false
        layoutMargins = UIEdgeInsets.zero
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
        
    private func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            //print(response?.suggestedFilename ?? url.lastPathComponent)
            //print("Download Finished")
                
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.uiImgViewCard.image = UIImage(data: data)
            }
        }
    }
}
