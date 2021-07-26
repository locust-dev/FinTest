//
//  InfoData.swift
//  FinTest
//
//  Created by Илья Тюрин on 25.07.2021.
//

import UIKit

protocol DetailViewInputProtocol: AnyObject {
    func displayTitle(title: String)
    func displaySubtitle(subtitile: String)
    func dispayImage(imageData: Data)
}

protocol DetailViewOutputProtocol: AnyObject {
    init(view: DetailViewInputProtocol)
    func showDetails()
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var presenter: DetailViewOutputProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showDetails()
    }
}

// MARK: - DetailViewInputProtocol
extension DetailViewController: DetailViewInputProtocol {
    func displayTitle(title: String) {
        mainTitle.text = title
    }
    
    func displaySubtitle(subtitile: String) {
        subtitle.text = subtitile
    }
    
    func dispayImage(imageData: Data) {
        image.image = UIImage(data: imageData)
    }
}
