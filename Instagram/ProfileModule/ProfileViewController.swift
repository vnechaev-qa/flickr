//
//  ProfileViewCOntroller.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 27.12.2020.
//

import SwiftyJSON
import UIKit

protocol ProfileViewProtocol: class {
    func reloadData()
}

class ProfileViewController: UIViewController, UICollectionViewDelegate, UITableViewDelegate {
    var layoutType: LayoutType = .grid
    @IBOutlet weak var profileTable: UITableView? {
        
        didSet {
            profileTable?.delegate = self
            profileTable?.dataSource = self
            registerNib()
        }
    }
    
    @IBOutlet weak var profileView: UICollectionView? {
        didSet {
            profileView?.delegate = self
            profileView?.dataSource = self
            registerNib()
        }
    }
    
    var presenter: ProfilePresenterProtocol!
    private let appAssembly = AppAssembly()
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        self.layoutType = LayoutType(rawValue: sender.selectedSegmentIndex) ?? .grid
        profileView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let photoViewController = segue.destination as? PhotoViewController,
        let indexPath = profileView?.indexPathsForSelectedItems?.first {
            photoViewController.photo = presenter.photo(at: indexPath)
        }
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfPhotos()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        guard let photo = presenter.photo(at: indexPath) else { return UICollectionViewCell() }
        cell.configure(with: photo)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let model = presenter.photo(at: indexPath)
        if indexPath.row % 2 == 0 {
            pushDetailedViewController(photo: model!) // пушится через навигейшнконтроллер, до фиксов Андрея ниче не работало
        } else {
            presentDetailedWith(photo: model!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == presenter.numberOfPhotos() - 5 {
            presenter.reloadData()
        }
    }
}

extension ProfileViewController {
    func registerNib() {
        let nib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        profileView?.register(nib, forCellWithReuseIdentifier: "PhotoCell")
        
        let nibProfile = UINib(nibName: "ProfileTableViewCell", bundle: nil)
        profileTable?.register(nibProfile, forCellReuseIdentifier: "ProfileCell")
    }
}

extension ProfileViewController: UITableViewDataSource, UIWebViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileTableViewCell
        let profileCell = presenter.profile
        cell.confirutate(with: profileCell)
        return cell
    }
    
    
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    enum LayoutType: Int {
        case grid
        case list
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if layoutType == .grid {
            let itemWdth = (collectionView.bounds.width - 2) / 3
            return CGSize(width: itemWdth, height: itemWdth)
        } else {
            return CGSize(width: profileView?.bounds.width ?? 0, height: 200)
        }
    }
}
extension ProfileViewController: ProfileViewProtocol {
    func reloadData() {
        profileView?.reloadData()
    }
}

extension ProfileViewController: Storyboardeable {
    static func storyboardName() -> String {
        return "Main"
    }
}

extension ProfileViewController {
    func presentDetailedWith(photo: PhotoModel) {
        let vc = appAssembly.detailedViewController(photo: photo)
        self.present(vc, animated: true, completion: nil)
    }
    
    func pushDetailedViewController(photo: PhotoModel) {
        let vc = appAssembly.detailedViewController(photo: photo)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
