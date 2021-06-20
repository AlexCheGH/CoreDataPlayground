//
//  ViewController.swift
//  CoreDataTestApp
//
//  Created by AP Aliaksandr Chekushkin on 6/20/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource = ProfilesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .red
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Enter Name", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { action in
            let name = alert.textFields![0].text
            
            if let name = name {
                if !name.isEmpty {
                    self.dataSource.addNewEntry(name: name)
                    self.tableView.reloadData()
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.userProfiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "myCell")
        cell?.backgroundColor = .green
        cell?.textLabel?.text = (dataSource.userProfiles[indexPath.row].name as! String)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            dataSource.removeEntry(at: indexPath.row)
            //should not reload the whole table view. need to "update cell at"
            self.tableView.reloadData()
        default:
            return
        }
    }
}
