//
//  MainPresenter.swift
//  FinTest
//
//  Created by Илья Тюрин on 25.07.2021.
//

import Foundation

//MARK: - View output
class MainPresenter: MainViewOutputProtocol {
    unowned let view: MainViewInputProtocol
    var interactor: MainInteractorInputProtocol!
    var router: MainRouterInputProtocol!
    
    required init(view: MainViewInputProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        interactor.fetchInfos()
    }
    
    func cellDidTap(at indexPath: IndexPath) {
        interactor.getInfo(indexPath)
    }
    
    func cellDidDelete(at indexPath: IndexPath) {
        interactor.deleteInfo(at: indexPath)
    }
    
    func addNewInfo(info: InfoData) {
        interactor.addNewInfo(info: info)
    }
}

//MARK: - Interactor output
extension MainPresenter: MainInteractorOutputProtocol {
    func infosDidRecieve(infoData: [InfoData]) {
        let section = InfoSectionViewModel()
        infoData.forEach { infoData in
            let cellViewModel = InfoCellViewModel(info: infoData)
            section.rows.append(cellViewModel)
        }
        view.reloadData(for: section)
    }
    
    func receiveInfo(infoData: InfoData) {
        router.openDetailScreen(with: infoData)
    }
}
