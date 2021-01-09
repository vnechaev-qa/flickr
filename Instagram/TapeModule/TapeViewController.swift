//
//  ViewController.swift
//  Instagram
//
//  Created by Vladisluv Nechik on 26.12.2020.
//
import SwiftyJSON
import UIKit

protocol TapeViewProtocol: class {
    func reloadData()
}

class TapeViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            registerNib()
        }
    }
    
    var presenter: TapePresenterProtocol! // inject
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadData()
    }
}

extension TapeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfPhotos()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        guard let photo = presenter.photo(at: indexPath) else { return UICollectionViewCell() }
        cell.configure(with: photo)
        return cell
    }
}

extension TapeViewController {
    func registerNib() {
        let nib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "PhotoCell")
    }
}

extension TapeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWdth = collectionView.bounds.width
        return CGSize(width: itemWdth, height: itemWdth)
    }
}
extension TapeViewController: TapeViewProtocol {
    func reloadData() {
        collectionView.reloadData()
    }
}
extension TapeViewController: Storyboardeable {
    static func storyboardName() -> String {
        return "Main"
    }
}

