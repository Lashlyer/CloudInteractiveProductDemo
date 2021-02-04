//
//  SecondCollectionViewCell.swift
//  CloudInteractiveProductDemo
//
//  Created by Alvin on 2021/2/1.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    fileprivate var data: DecodableModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initView()
    }
    
    
    private func initView() {
        
        self.idLabel.textAlignment = .center
        self.titleLabel.textAlignment = .center
    }
    
    func updateValue(model: DecodableModel) {
        self.data = model
        self.idLabel.text = "\(model.id)"
        self.titleLabel.text = model.title
        
        self.itemImageView.image = UIImage(named: "noimage")
        
        NetworkController.shared.fetchImage(url: model.thumbnailUrl) { [weak self] (image) in
            guard let self = `self` else { return }
            DispatchQueue.main.async {
                if model.id == self.data?.id {
                    self.itemImageView.image = image
                }
            }
        }
    }
}
