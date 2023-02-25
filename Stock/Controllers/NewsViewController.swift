//
//  TopStoriesNewsViewController.swift
//  Stock
//
//  Created by Dhiman Das on 3/2/23.
//

import UIKit
import SafariServices


/// Controller to show news

class NewsViewController: UIViewController {
    
    /// Type of news
    enum `Type` {
        
        case topStories
        case compan(symbol: String)
        /// Title for given type
        var title : String {
            switch self {
            case .topStories :
                return "Top Stories"
            case .compan(let symbol):
                return symbol.uppercased()
            }
        }
    }
    
    // MARK: - Properties

    /// Collection of models
    private var stories = [NewsStory]()
    
    /// Primary news view
    let tableView : UITableView = {
       let table = UITableView()
        
        // Rgister cell, header
        table.register(NewsStoryTableViewCell.self,
                       forCellReuseIdentifier: NewsStoryTableViewCell.identfier)
        
        table.register(NewsHeaderView.self, forHeaderFooterViewReuseIdentifier: NewsHeaderView.identifier)
        table.backgroundColor = .clear
        return table
    }()
    
    private let type : Type
    
    // MARK: - Init
    init(type : Type) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        fetchNews()


    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Private

    /// Sets up tableView
    private func setUpTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchNews() {
        
        APICaller.shared.news(for: type){ result in
            
            switch result {
            case .success(let stories):
                DispatchQueue.main.async {
                    self.stories = stories
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Open a story
    /// - Parameter url: URL to open
    private func open(url: URL) {
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }


}

// MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsStoryTableViewCell.identfier, for: indexPath) as? NewsStoryTableViewCell else {
            fatalError()
        }
        cell.confiqure(with: .init(model: stories[indexPath.row]))
     
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsHeaderView.identifier) as? NewsHeaderView else {
            return nil
        }
                
        header.confiqure(with: .init(title: self.type.title, shouldShowAddbutton: false))
        
        return header

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewsStoryTableViewCell.preferredHeight

    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return NewsHeaderView.preferredHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let story = stories[indexPath.row]
        guard let url = URL(string: story.url) else {
            presentFailedToOpenAlert()
            return
        }
        open(url: url)
        

    }
    /// Present an alert to show an error occurred when opening story

    private func presentFailedToOpenAlert() {

        let alert = UIAlertController(
            title: "Unable to Open",
            message: "We were unable to open the article.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
        
    }
}
