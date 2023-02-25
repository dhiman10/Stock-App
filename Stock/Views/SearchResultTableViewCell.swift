//
//  SearchResultTableViewCell.swift
//  Stock
//
//  Created by Dhiman Das on 5/2/23.
//

import Foundation
import UIKit

/// Tableview cell for search result
final class SearchResultTableViewCell : UITableViewCell {
    
    /// Identifier for cell
     static let identifier = "SearchResultTableViewCell"
    
    // MARK: - Init
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
