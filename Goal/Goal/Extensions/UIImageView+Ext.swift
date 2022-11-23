//
//  UIImageView+Ext.swift
//  Goal
//
//  Created by Charlie Hoang on 11/23/22.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        self.addSubview(indicator)
        indicator.center = self.convert(self.center, from:self.superview)
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        indicator.removeFromSuperview()
                    }
                }
            }
        }
    }
}
