//
//  MainViewController.swift
//  FinTest
//
//  Created by Илья Тюрин on 25.07.2021.
//

import UIKit

protocol MainViewInputProtocol: AnyObject {
    func reloadData(for section: InfoSectionViewModel)
}

protocol MainViewOutputProtocol: AnyObject {
    init(view: MainViewInputProtocol)
    func viewDidLoad()
    func cellDidTap(at indexPath: IndexPath)
}

class MainViewController: UITableViewController {
    
    var presenter: MainViewOutputProtocol!
    
    private let configurator: MainConfiguratorInputProtocol = MainConfigurator()
    private var sectionViewModel: SectionRowRepresentable = InfoSectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! DetailViewController
            let configurator: DetailConfiguratorInputProtocol = DetailConfigurator()
            configurator.configure(with: detailVC, and: sender as! InfoData)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionViewModel.rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = sectionViewModel.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.cellIdentifier, for: indexPath) as! InfoCell
        cell.viewModel = cellViewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.cellDidTap(at: indexPath)
    }
    
}

//MARK: - InputProtocol
extension MainViewController: MainViewInputProtocol {
    func reloadData(for section: InfoSectionViewModel) {
        sectionViewModel = section
        tableView.reloadData()
    }
}
