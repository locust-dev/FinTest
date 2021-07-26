//
//  DetailConfigurator.swift
//  FinTest
//
//  Created by Илья Тюрин on 25.07.2021.
//

protocol DetailConfiguratorInputProtocol {
    func configure(with view: DetailViewController, and info: InfoData)
}

class DetailConfigurator: DetailConfiguratorInputProtocol {
    func configure(with view: DetailViewController, and info: InfoData) {
        let presenter = DetailPresenter(view: view)
        let interactor = DetailInteractor(presenter: presenter, info: info)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
