//
//  EmployeesViewController.swift
//  PokerGame
//
//  Created by admin on 08/02/2023.
//

import UIKit

class CarpetViewController: UIViewController{
    
    @IBOutlet weak var collectionViewCarpet: UICollectionView!
    @IBOutlet weak var lablePlayer: UILabel!
    @IBOutlet weak var labelCash: UILabel!
    @IBOutlet weak var buttonBet: UIButton!
    @IBOutlet weak var buttonCall: UIButton!
    @IBOutlet weak var buttonRaise: UIButton!
    @IBOutlet weak var buttonFold: UIButton!
                
    lazy var viewModel = {
        CarpetViewModel()
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    
    func initView() {
        collectionViewCarpet.delegate = self
        collectionViewCarpet.dataSource = self
        collectionViewCarpet.register(CarpetCell.nib, forCellWithReuseIdentifier: CarpetCell.identifier)
    }

    func initViewModel() {
        viewModel.getCards()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionViewCarpet.reloadData()
            }
        }
    }
}

extension CarpetViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.carpetCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionViewCarpet.dequeueReusableCell(withReuseIdentifier: CarpetCell.identifier, for: indexPath) as? CarpetCell
        else {
            fatalError("Xib not exist !!")
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    
    /// UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let carpet = viewModel.getCellViewModel(at: indexPath)
        print("\(indexPath.row) - \(carpet.card)")
    }
    
    /// UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset:CGFloat = 10
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: UIScreen.main.bounds.width, height: 80)
        return CGSize(width: 110, height: 110)
    }
}
