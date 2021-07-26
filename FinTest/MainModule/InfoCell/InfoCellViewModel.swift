//
//  InfoCellViewModel.swift
//  FinTest
//
//  Created by Илья Тюрин on 26.07.2021.
//

import Foundation

protocol CellIdentifiable {
    var cellIdentifier: String { get }
}

protocol SectionRowRepresentable {
    var rows: [CellIdentifiable] { get set }
}

class InfoCellViewModel: CellIdentifiable {
    var mainTitle: String
    var subtitle: String
    var image: Data?
    
    var cellIdentifier: String {
        "infoCell"
    }
    
    init(info: InfoData) {
        self.image = info.image
        self.mainTitle = info.mainTitle
        self.subtitle = info.subtitle
    }
}

class InfoSectionViewModel: SectionRowRepresentable {
    var rows: [CellIdentifiable] = []
}
