//
//  DetailInteractor.swift
//  FinTest
//
//  Created by Илья Тюрин on 25.07.2021.
//

import Foundation

protocol DetailInteractorInputProtocol: AnyObject {
    init(presenter: DetailInteractorOutputProtocol, info: InfoData)
    func provideInfoDetails()
}

protocol DetailInteractorOutputProtocol: AnyObject {
    func receiveInfoDetails(with info: InfoDetailData)
}

class DetailInteractor: DetailInteractorInputProtocol {
    unowned let presenter: DetailInteractorOutputProtocol
    private let info: InfoData

    required init(presenter: DetailInteractorOutputProtocol, info: InfoData) {
        self.presenter = presenter
        self.info = info
    }
    
    func provideInfoDetails() {
        //let imageData = ImageManager.shared.fetchImageData(from: course.imageUrl)
        let infoDetailsData = InfoDetailData(mainTitle: info.mainTitle, subtitle: info.subtitle, imageData: info.image)
        presenter.receiveInfoDetails(with: infoDetailsData)
    }
    
}
