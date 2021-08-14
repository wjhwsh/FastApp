//
//  ConfirmationViewController.swift
//  FastAssignment
//
//  Created by Jianhua Wang on 8/13/21.
//

import UIKit

class ConfirmationViewController: UIViewController {
    var items = [OMDBSearchItem]()
    var tableView = UITableView()
    var footerLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        tableView.register(OMDBTableViewCell.self, forCellReuseIdentifier: OMDBTableViewCell.reuseIdentifier)
        footerLabel.text = "My favorite color is blue"
        footerLabel.textAlignment = .center
        self.view.addSubview(tableView)
        self.navigationController?.isToolbarHidden = false
        self.toolbarItems = [UIBarButtonItem(customView: footerLabel)]
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(cancelButtonTapped))
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
        // Do any additional setup after loading the view.
    }
    
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ConfirmationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: OMDBTableViewCell.reuseIdentifier, for: indexPath) as! OMDBTableViewCell
        cell.updateWithOMDBSearchItem(items[indexPath.row])
        return cell
    }
}
