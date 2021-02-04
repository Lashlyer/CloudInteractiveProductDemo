//
//  SecondViewController.swift
//  CloudInteractiveProductDemo
//
//  Created by Alvin on 2021/2/1.
//


import UIKit
import Alamofire
import AlamofireImage

class SecondViewController: UIViewController {
    
    private let detailViewModel = DetaiViewModel()
    
    fileprivate var loadingView: UIView?

    @IBOutlet weak var mainColleciotnView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailViewModel.prepareRequest()
        self.bindViewModel()
        self.initView()

        
    }
    
    
    private func bindViewModel() {
        
        detailViewModel.onRequestEnd = { [weak self] in
            
            guard let self = `self` else { return }
            
            DispatchQueue.main.async {
                
                self.mainColleciotnView.reloadData()
                
                UIView.animate(withDuration: 0.5) {
                    self.loadingView?.alpha = 0
                } completion: {_ in
                    self.loadingView?.isHidden = true
                    
                }
            }
        }
    }
    

    
    private func initView() {
        
        
        self.mainColleciotnView.delegate = self
        self.mainColleciotnView.dataSource = self
        self.mainColleciotnView.register(UINib(nibName: "SecondCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SecondCollectionViewCell")
        
        
        let layout = UICollectionViewFlowLayout()
        let width = Int(self.mainColleciotnView.bounds.size.width)
        layout.itemSize = CGSize(width: (width / 4), height: (width / 4))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.estimatedItemSize = .zero
        self.mainColleciotnView.collectionViewLayout = layout
        
        self.loadingView = LoadingView(uiview: self.view, color: .white, alpha: 1)
        self.view.addSubview(self.loadingView ?? UIView())
    }


}



extension SecondViewController: UICollectionViewDelegate {
    
    
}


extension SecondViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailViewModel.productData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCollectionViewCell", for: indexPath) as? SecondCollectionViewCell else { return UICollectionViewCell() }
        
        item.updateValue(model: self.detailViewModel.productData[indexPath.row])
        return item
    }
   
}

extension SecondViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.mainColleciotnView.bounds.size.width / 4), height: (self.mainColleciotnView.bounds.size.width / 4))
    }
}


