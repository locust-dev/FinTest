//
//  MainPresenter.swift
//  FinTest
//
//  Created by Илья Тюрин on 25.07.2021.
//

import Foundation

struct InfoData {
    let mainTitle: String
    let subtitle: String
    let image: Data?
}

//MARK: - View output
class MainPresenter: MainViewOutputProtocol {
    
    unowned let view: MainViewInputProtocol
    var interactor: MainInteractorInputProtocol!
    
    required init(view: MainViewInputProtocol) {
        self.view = view
    }
    
    func didTapCell(for: IndexPath) {
        interactor.provideData()
    }
    
    
}

//MARK: - Interactor output
extension MainPresenter: MainInteractorOutputProtocol {
    func receiveData(infoData: [InfoData]) {
        
    }

    
    
}
