//
//  DataManager.swift
//  FinTest
//
//  Created by Илья Тюрин on 25.07.2021.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    let titles = ["Some", "Up", "Down"]
    let subtitles = ["Main screen", "Detail Screen", "Work Item"]
    
    private var infos = [InfoData]()
    
    func setInfos(infos: [InfoData]) {
        self.infos = infos
    }
    
    func getInfo(at indexPath: IndexPath) -> InfoData {
        infos[indexPath.row]
    }
}
