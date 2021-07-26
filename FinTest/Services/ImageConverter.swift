//
//  ImageConverter.swift
//  FinTest
//
//  Created by Илья Тюрин on 26.07.2021.
//

import UIKit

class ImageConverter {
    
    private init() {}
    
    static func convertImageToData(imageName: String) -> Data? {
        guard let image = UIImage(named: imageName) else { return nil }
        guard let data = image.pngData() else { return nil }
        return data
    }
    
}
