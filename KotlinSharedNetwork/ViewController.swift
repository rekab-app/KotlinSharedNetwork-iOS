//
//  ViewController.swift
//  KotlinSharedNetwork
//
//  Created by Mehdi Sohrabi on 12/4/18.
//  Copyright © 2018 sixthsolution. All rights reserved.
//

import UIKit
import SharedNetwork

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.dataSource = self
        tableView.rowHeight = 80
        
        loadPosts()
    }
    
    func loadPosts() {
        let client = ApiClient()
        client.getPosts(successCallback: { [weak self] posts -> KotlinUnit in
            self?.posts = posts
            self?.tableView.reloadData()
            
            return KotlinUnit()
        }) { error -> KotlinUnit in
            print(error.description)
            
            return KotlinUnit()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.fillData(posts[indexPath.row])
        return cell
    }
}
