//
//  MainConfigurator.swift
//  FinTest
//
//  Created by Илья Тюрин on 25.07.2021.
//

protocol MainConfiguratorInputProtocol {
    func configure(with view: MainViewController)
}

class MainConfigurator : MainConfiguratorInputProtocol {
    func configure(with view: MainViewController) {
        let presenter = MainPresenter(view: view)
        let interactor = MainInteractor(presenter: presenter)
        let router = MainRouter(viewController: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
