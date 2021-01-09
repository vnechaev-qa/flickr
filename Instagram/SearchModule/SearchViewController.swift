//
//  SearchViewController.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 07.01.2021.
//
import UIKit
import Foundation

protocol SearchViewProtocol: class {
    func reloadData()
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var collectionSearchView: UICollectionView! {
        didSet {
            collectionSearchView.dataSource = self
            registerNib()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageSearchView: UIImageView!
    var presenter: SearchPresenterProtocol!
    private let appAssembly = AppAssembly()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadData()
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfPhotos()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        guard let photo = presenter.photo(at: indexPath) else { return UICollectionViewCell() }
        cell.configure(with: photo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView = UICollectionReusableView()
        
        if kind == UICollectionView.elementKindSectionHeader {
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "section", for: indexPath)
        }
        return reusableView
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        presenter.loadData()
    }
}

//extension SearchViewController {
//    func loadSearchPhotos(searchText: String? = nil) {
//        presenter.loadData(searchText: searchText) { [weak self] (photos) in
//            guard let strongSelf = self else { return }
//
//            if let photos = photos {
//                strongSelf
//            }
//        }
//    }
//
//}

extension SearchViewController {
    func registerNib() {
        let nib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        collectionSearchView.register(nib, forCellWithReuseIdentifier: "PhotoCell")
    }
}

extension SearchViewController: SearchViewProtocol {
    func reloadData() {
        collectionSearchView.reloadData()
    }
}

extension SearchViewController: Storyboardeable {
    static func storyboardName() -> String {
        return "Main"
    }
}
