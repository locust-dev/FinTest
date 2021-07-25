//
//  MainViewController.swift
//  FinTest
//
//  Created by Илья Тюрин on 25.07.2021.
//

import UIKit

protocol MainViewInputProtocol: AnyObject {
   
}

protocol MainViewOutputProtocol: AnyObject {
    init(view: MainViewInputProtocol)
    func didTapCell(for: IndexPath)
}

class MainViewController: UITableViewController, MainViewInputProtocol {

    var presenter: MainViewOutputProtocol!
    
    private let configurator: MainConfiguratorInputProtocol = MainConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataManager.shared.titles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InfoCell

        cell.mainTitle.text = DataManager.shared.titles[indexPath.row]
        cell.subtitle.text = DataManager.shared.subtitles[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapCell(for: indexPath)
    }
    
}

////MARK: - InputProtocol
//extension MainViewController: MainViewInputProtocol {
//    func configureCells(infoData: [InfoData]) {
//        <#code#>
//    }
//
//}
