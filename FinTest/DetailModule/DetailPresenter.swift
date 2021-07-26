//
//  DetailPresenter.swift
//  FinTest
//
//  Created by Илья Тюрин on 25.07.2021.
//

import Foundation

struct InfoDetailData {
    let mainTitle: String
    let subtitle: String
    let imageData: Data?
}

class DetailPresenter: DetailViewOutputProtocol {
    unowned let view: DetailViewInputProtocol
    var interactor: DetailInteractorInputProtocol!
    
    required init(view: DetailViewInputProtocol) {
        self.view = view
    }
    
    func showDetails() {
        interactor.provideInfoDetails()
    }
}

// MARK: - DetailInteractorOutputProtocol
extension DetailPresenter: DetailInteractorOutputProtocol {
    func receiveInfoDetails(with info: InfoDetailData) {
        view.displayTitle(title: info.mainTitle)
        view.displaySubtitle(subtitile: info.subtitle)
        
        guard let imageData = info.imageData else { return }
        view.dispayImage(imageData: imageData)
    }
    
}
