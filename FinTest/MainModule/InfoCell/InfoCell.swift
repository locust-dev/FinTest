//
//  InfoCell.swift
//  FinTest
//
//  Created by Илья Тюрин on 25.07.2021.
//

import UIKit

protocol InfoCellModel {
    var viewModel: CellIdentifiable? { get set }
}

class InfoCell: UITableViewCell, InfoCellModel {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    var viewModel: CellIdentifiable? {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        guard let viewModel = viewModel as? InfoCellViewModel else { return }
        mainTitle.text = viewModel.mainTitle
        subtitle.text = viewModel.subtitle
        
        if let imageData = viewModel.image {
            cellImage.image = UIImage(data: imageData)
        } else {
            cellImage.image = UIImage(named: "nullImage")
        }
    }
    
}
