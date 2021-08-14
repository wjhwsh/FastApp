//
//  ViewController.swift
//  FastAssignment
//
//  Created by Jianhua Wang on 8/12/21.
//

import UIKit

class HomeViewController: UIViewController {
    var homeViewMode = HomeViewModel()
    var dataSource: SearchItemsDataSource!
    var tableView = UITableView()
    var errorLabel: UILabel!
    let searchController = UISearchController(searchResultsController: nil)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Fast Assessment"
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = SearchItemsDataSource()
        setupViews()
    }
    
    func setupViews() {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.allowsMultipleSelection = true
        
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(OMDBTableViewCell.self, forCellReuseIdentifier: OMDBTableViewCell.reuseIdentifier)
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.reuseIdentifier)
        
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        
        definesPresentationContext = true
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create Playlist", style: .plain, target: self, action: #selector(showPlaylist))
        navigationItem.rightBarButtonItem?.isEnabled = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder =  "Search OMDB movies"
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    @objc func showPlaylist() {
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows, selectedIndexPaths.count > 0 {
            let confirmationVC = ConfirmationViewController()
            confirmationVC.items = selectedIndexPaths.compactMap {homeViewMode.items?[$0.row]}
            show(UINavigationController(rootViewController: confirmationVC), sender: self)
            
        } else {
            let alert = UIAlertController(title: nil, message: "Please click cell to select movies first.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: false, completion: nil)
        }
    }
}


extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            homeViewMode.searchOMDB(term: searchTerm) {[weak self] error in
                if self?.homeViewMode.searchResult?.response.lowercased() == "true" {
                    self?.dataSource.errorMessage = nil
                    self?.dataSource.items = self?.homeViewMode.items ?? []
                } else {
                    self?.dataSource.errorMessage = self?.homeViewMode.searchResult?.error ?? error?.localizedDescription
                    self?.dataSource.items = [OMDBSearchItem]()
                    
                }
                self?.navigationItem.rightBarButtonItem?.isEnabled = (self?.dataSource.items.count ?? 0 ) > 0
                self?.tableView.reloadData()
            }
        }
    }
}
