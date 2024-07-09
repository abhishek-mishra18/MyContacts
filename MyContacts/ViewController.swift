//
//  ViewController.swift
//  MyContacts
//
//  Created by Abhishek on 08/07/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var sectionTitle = [String]()
    
    var namesDict = [String: [String]]()
    
    var dummyData =  [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let path = Bundle.main.path(forResource: "Name", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do{
            let data = try Data(contentsOf: url)
            let name = try JSONDecoder().decode([String].self, from: data)
            for items in name {
                dummyData.append(items)
            }
        }
        catch{}
        
        sectionTitle = Array(Set(dummyData.compactMap({
            String($0.prefix(1))
            })))
        
        sectionTitle.sort()
        
        for title in sectionTitle{
            namesDict[title] = [String]()
        }
        
        for name in dummyData{
            namesDict[String(name.prefix((1)))]?.append(name)
        }
        
        print(namesDict)
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "contactVC")
        vc.navigationItem.title = namesDict[sectionTitle[indexPath.section]]?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesDict[sectionTitle[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = namesDict[sectionTitle[indexPath.section]]?[indexPath.row]
        //cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
}
        

