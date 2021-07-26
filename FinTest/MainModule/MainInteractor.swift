//
//  MainInteractor.swift
//  FinTest
//
//  Created by Илья Тюрин on 25.07.2021.
//
//

import Foundation

protocol MainInteractorInputProtocol: AnyObject {
    init(presenter: MainInteractorOutputProtocol)
    func fetchInfos()
    func getInfo(_ indexPath: IndexPath)
}

protocol MainInteractorOutputProtocol: AnyObject {
    func infosDidRecieve(infoData: [InfoData])
    func receiveInfo(infoData: InfoData)
}

class MainInteractor: MainInteractorInputProtocol {
    unowned let presenter: MainInteractorOutputProtocol
    
    required init(presenter: MainInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchInfos() {
        var infoData = [InfoData]()
        for i in 0...2 {
            let info = InfoData(mainTitle: DataManager.shared.titles[i],
                                subtitle: DataManager.shared.subtitles[i],
                                image: nil)
            infoData.append(info)
        }
        DataManager.shared.setInfos(infos: infoData)
        presenter.infosDidRecieve(infoData: infoData)
    }
    
    func getInfo(_ indexPath: IndexPath) {
        let infoData = DataManager.shared.getInfo(at: indexPath)
        presenter.receiveInfo(infoData: infoData)
    }
}
