//
//  SearchRequestViewController.swift
//  Stock
//
//  Created by Dhiman Das on 3/2/23.
//

import UIKit

/// Delegate for search resutls

protocol SearchResultsViewControllerDelegate : AnyObject {
    /// Notify delegate of selection
    /// - Parameter searchResult: Result that was picked
    func searchResultsViewControllerDidSelect(searchResult: SearchResult)

}
/// VC to show search results

class SearchResultViewController: UIViewController {
    

    /// Delegate to get evnets
    weak var delegate: SearchResultsViewControllerDelegate?

    /// Collection of results
    private var results: [SearchResult] = []

    /// Primary view

    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
        
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Private

    /// Set up our table view
    private func setUpTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    
}
    // MARK: - Public

    /// Update results on VC
    /// - Parameter results: Collection of new resutls
    public func update(with results: [SearchResult]){
        
        self.results = results
        tableView.isHidden = results.isEmpty
        tableView.reloadData()
        
    }

}


// MARK: - TableView

extension SearchResultViewController : UITableViewDelegate, UITableViewDataSource {

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath)
        
        let model = results[indexPath.row]
        
        cell.textLabel?.text = model.displaySymbol
        cell.detailTextLabel?.text = model.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = results[indexPath.row]
        delegate?.searchResultsViewControllerDidSelect(searchResult: model)
    }
    
}


