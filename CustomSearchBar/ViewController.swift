//
//  ViewController.swift
//  CustomSearchBar
//
//  Created by Ahmed Soultan on 14/06/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var resultsTableView: UITableView!
    
    var fruitsArray = ["Apple","Watermelon","Orange","Litchi","Strawberry"]
    var searchedArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        
        searchBar.delegate = self
        
        searchedArray = fruitsArray
    }


}

extension ViewController:UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = searchedArray[indexPath.row]
        return cell
    }
    
    
}

extension ViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchBar.text?.count != 0 {
            self.searchedArray.removeAll()
            
            for str in fruitsArray {
                let range = str.lowercased().range(of: searchBar.text!, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil {
                    self.searchedArray.append(str)
                }
            }
            
        }
        resultsTableView.reloadData()
        print(searchedArray)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()
        searchedArray.removeAll()
//        for str in fruitsArray{
//            searchedArray.append(str)
//        }
        searchedArray = fruitsArray
        print(searchedArray)
        resultsTableView.reloadData()
        return true
    }
    
}

