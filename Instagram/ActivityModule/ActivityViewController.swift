//
//  ActivityViewController.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 26.12.2020.
//
import UIKit
import Foundation

protocol ActivityViewProtocol: class {
    func reloadData()
}

class ActivityViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            registerNib()
        }
    }
    
    var presenter: ActivityPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "INSTA"
    }
}

extension ActivityViewController: UIWebViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.activities.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Что нового"
        } else {
            return "На прошлой неделе"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityTableViewCell
        let model = presenter.activity(at: indexPath)
        cell.configurate(with: model)
        return cell
    }
}

extension ActivityViewController {
    fileprivate func registerNib() {
        let nib = UINib(nibName: "ActivityTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ActivityCell")
    }
}

extension ActivityViewController: Storyboardeable {
    static func storyboardName() -> String {
        return "Main"
    }
}
