//
//  MainRouter.swift
//  FinTest
//
//  Created by Илья Тюрин on 26.07.2021.
//

protocol MainRouterInputProtocol {
    init(viewController: MainViewController)
    func openDetailScreen(with info: InfoData)
}

class MainRouter: MainRouterInputProtocol {
    unowned let viewController: MainViewController
    
    required init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func openDetailScreen(with info: InfoData) {
        viewController.performSegue(withIdentifier: "toDetail", sender: info)
    }
     
}
