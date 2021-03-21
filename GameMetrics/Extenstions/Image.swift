//
//  Image.swift
//  GameMetrics
//
//  Created by Mortgy on 3/21/21.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        let urlMd5 = url.absoluteString.MD5()
        
        DispatchQueue.global().async { [weak self] in
            if let data: Data = DiskCacheManager().value(urlMd5, from: .images) {
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            } else if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        DiskCacheManager().add(data, for: url.absoluteString.MD5(), to: .images)
                    }
                }
            }
        }
    }
}

