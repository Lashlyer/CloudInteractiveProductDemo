//
//  LoadingView.swift
//  CloudInteractiveProductDemo
//
//  Created by Alvin on 2021/2/2.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    var loadingView = UIView()
    var indicator: UIActivityIndicatorView?
    
    init(uiview: UIView, color: UIColor, alpha: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.frame = uiview.frame
        self.center = uiview.center
        self.backgroundColor = color
        self.alpha = alpha
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiview.center
        loadingView.backgroundColor = .white
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator?.style = UIActivityIndicatorView.Style.large
        indicator?.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        indicator?.startAnimating()
        loadingView.addSubview(indicator ?? UIActivityIndicatorView())
        self.addSubview(loadingView)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
