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
    
    let dummyData =  [
            "John Doe", "Jane Smith", "Michael Johnson", "Emily Brown", "Daniel Wilson",
            "Sarah Martinez", "Kevin Lee", "Amanda Davis", "Jason Taylor", "Rachel Moore",
            "David Harris", "Lisa Clark", "James Lewis", "Jessica Walker", "Christopher Hall",
            "Mary Allen", "Robert Young", "Linda King", "Thomas Wright", "Patricia Scott",
            "Mark Green", "Barbara Adams", "Steven Baker", "Susan Nelson", "Joseph Hill",
            "Karen Ramirez", "Charles Campbell", "Nancy Mitchell", "Paul Roberts", "Betty Carter",
            "Edward Turner", "Margaret Phillips", "Brian Parker", "Sandra Evans", "George Edwards",
            "Ashley Collins", "Ronald Stewart", "Kimberly Sanchez", "Anthony Morris", "Donna Rogers",
            "Kenneth Reed", "Michelle Cook", "Jason Morgan", "Emily Bell", "Eric Murphy",
            "Sophia Bailey", "Ryan Rivera", "Christine Cooper", "Jeffrey Richardson", "Amy Cox",
            "Frank Howard", "Kathleen Ward", "Scott Torres", "Megan Peterson", "Raymond Gray",
            "Laura Ramirez", "Gregory James", "Janet Watson", "Jacob Brooks", "Diane Price",
            "Patrick Bennett", "Angela Wood", "Nicholas Barnes", "Cynthia Ross", "Joshua Henderson",
            "Katherine Coleman", "Gary Jenkins", "Julie Perry", "Andrew Russell", "Victoria Butler",
            "Justin Powell", "Teresa Foster", "Sean Simmons", "Carolyn Gonzales", "Stephen Bryant",
            "Martha Alexander", "Benjamin Russell", "Frances Griffin", "Matthew Shaw", "Ann Knight",
            "Larry Reynolds", "Pamela Fisher", "Timothy Webb", "Debra Kennedy", "Walter Welch",
            "Janice Daniels", "Peter Stevens", "Ruth Wheeler", "Kyle Harper", "Jacqueline Berry",
            "Dennis Warren", "Alice Elliott", "Raymond Fields", "Julia Bishop", "Roger Perry",
            "Gloria Burns", "Jeremy Olson", "Victoria Hart", "Samuel Holland", "Marie Reynolds"
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
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
        print(dummyData[indexPath.row])
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
        

