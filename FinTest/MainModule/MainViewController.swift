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
    func addNewInfo(info: InfoData)
    func cellDidTap(at indexPath: IndexPath)
    func cellDidDelete(at indexPath: IndexPath)
}

protocol CreateInfoDelegate {
    func newInfoAdded(info: InfoData)
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
        } else {
            let createVC = segue.destination as! CreateInfoViewController
            createVC.delegate = self
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.cellDidDelete(at: indexPath)
        }
    }
    
}

//MARK: - InputProtocol
extension MainViewController: MainViewInputProtocol {
    func reloadData(for section: InfoSectionViewModel) {
        sectionViewModel = section
        tableView.reloadData()
    }
}

//MARK: - CreateInfo Delegate
extension MainViewController: CreateInfoDelegate {
    func newInfoAdded(info: InfoData) {
        presenter.addNewInfo(info: info)
    }
}
