//
//  NewsHeaderView.swift
//  Stock
//
//  Created by Dhiman Das on 6/2/23.
//

import UIKit

/// Delegate to notify of header evnets
protocol NewsHeaderViewDelegate: AnyObject {
    /// Notify user tapped header button
    /// - Parameter headerView: Ref of header view
    func newsHeaderViewDidTapAddButton(_ headerView: NewsHeaderView)
}

/// TableView header for news

class NewsHeaderView: UITableViewHeaderFooterView {
    
  /// Header identifier
  static let identifier = "NewsHeaderView"
    
  /// Ideal height of header
    static let preferredHeight: CGFloat = 70

    /// Delegate instance for evnets
    weak var delegate: NewsHeaderViewDelegate?
    
    /// ViewModel for header view
    struct viewModel {
        let title : String
        let shouldShowAddbutton : Bool
    }
    
    // MARK: - Private

    private let label : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
     let button : UIButton = {
        let button = UIButton()
        button.setTitle("+ Watchlist", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    //MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(label,button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 14, y: 0, width: contentView.width - 28, height: contentView.height)
        button.sizeToFit()
        button.frame = CGRect(x: contentView.width - button.width - 16, y: (contentView.height - button.height)/2, width: button.width + 8, height: button.height)

    }
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    /// Handle button tap
    @objc private func didTapButton() {
        // Call delegate
        delegate?.newsHeaderViewDidTapAddButton(self)
    }
    
    public func confiqure (with viewModel: viewModel) {
        label.text = viewModel.title
        button.isHidden = !viewModel.shouldShowAddbutton
        
    }
}
