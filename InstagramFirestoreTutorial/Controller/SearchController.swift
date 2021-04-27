//
//  SearchController.swift
//  InstagramFirestoreTutorial
//
//  Created by bean Milky on 2021/04/06.
//

import UIKit

class SearchController: UIViewController {
    
    enum Section: CaseIterable {
        case main
    }
    
    private var dataSource: UITableViewDiffableDataSource<Section, User>!
    private var users = [User]()
    private var filteredUsers = [User]()
    private var tableView: UITableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var isSearchMode: Bool {
        return searchController.isActive && searchController.searchBar.text?.isEmpty == false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatasource()
        fetchUsers()
        setTableView()
        setSearchController()
    }
    
    private func fetchUsers() {
        UserService.fetchUsers().then { [weak self] users in
            self?.users = users
            self?.tableView.reloadData()
        }
    }

    private func setTableView() {
        self.view.addSubview(tableView)
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseIdentifier)
    }
    
    private func setDatasource() {
        dataSource = UITableViewDiffableDataSource<Section, User>(tableView: tableView, cellProvider: { (tableView: UITableView, indexPath: IndexPath, user: User) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier, for: indexPath) as? UserCell
            else { return UITableViewCell() }
            cell.viewModel = UserCellViewModel(user: user)
            return cell
        })
    }
    
    private func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension SearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = dataSource.itemIdentifier(for: indexPath) {
            let controller = ProfileController(user: user)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension SearchController: UISearchResultsUpdating {
    internal func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        performQuery(with: searchText)
    }
    
    private func performQuery(with filter: String?) {
        let filterText = filter?.lowercased() ?? ""
        let userList = users.filter {
            return $0.username.lowercased().contains(filterText) ||
                $0.fullname.lowercased().contains(filterText)
        }
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        snapshot.appendSections([.main])
        snapshot.appendItems(userList, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
