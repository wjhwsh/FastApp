//
//  SearchItemsDataSource.swift
//  FastAssignment
//
//  Created by Jianhua Wang on 8/13/21.
//

import UIKit

class SearchItemsDataSource: NSObject {
    var items = [OMDBSearchItem]()
    var errorMessage: String?
}

extension SearchItemsDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = errorMessage {
            return 1
        } else {
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let errorMessage = errorMessage {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.reuseIdentifier, for: indexPath) as! EmptyTableViewCell
            cell.messageLabel.text = errorMessage
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: OMDBTableViewCell.reuseIdentifier, for: indexPath) as! OMDBTableViewCell
            
            cell.updateWithOMDBSearchItem(items[indexPath.row])
            
            return cell
        }
    }
}

