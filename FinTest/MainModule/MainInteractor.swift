//
//  MainInteractor.swift
//  FinTest
//
//  Created by Илья Тюрин on 25.07.2021.
//
//

protocol MainInteractorInputProtocol: AnyObject {
    init(presenter: MainInteractorOutputProtocol)
    func provideData()
}

protocol MainInteractorOutputProtocol: AnyObject {
    func receiveData(infoData: [InfoData])
}

class MainInteractor: MainInteractorInputProtocol {
    
    unowned let presenter: MainInteractorOutputProtocol
    
    required init(presenter: MainInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideData() {
        var infoData = [InfoData]()
        for i in 1...3 {
            let info = InfoData(mainTitle: DataManager.shared.titles[i], subtitle: DataManager.shared.subtitles[i], image: nil)
            infoData.append(info)
        }
        
        presenter.receiveData(infoData: infoData)
    }
    
    
}
