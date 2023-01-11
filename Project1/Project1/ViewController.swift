//
//  ViewController.swift
//  Project1
//
//  Created by Jaswitha Reddy Guntaka on 1/10/23.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        print(pictures)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pictures = pictures.sorted()
        
        // reuses the cells and creates a lazy scroll
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        // text in the cell is the name of the picture
        cell.textLabel?.text = pictures[indexPath.row]
        cell.textLabel?.font = UIFont(name: "", size: 22)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedImageIndex = indexPath.row + 1
            vc.numberOfImages = pictures.count
            
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
