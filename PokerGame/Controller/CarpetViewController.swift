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
    @IBOutlet weak var buttonShuffle: UIButton!
    @IBOutlet weak var stackMain: UIStackView!
    @IBOutlet weak var progressLoad: UIProgressView!
    
    var timerLoad : Timer!

    lazy var viewModel = {
        CarpetViewModel()
    }()
  
    //MARK: LifeCycle
    ///Après le chargement de la vue en mémoire
    ///viewDidLoad() n'est appelé qu'une seule fois lorsque la vue est chargée
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        initView()
        initValue()
        definieActionSelector()
    }
    
    ///Utiliser avant que le ViewController ne soit ajouté à la hiérarchie des vues
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    ///Lorsque la ViewController est modifiée dans sa disposition ou ses limites
    override func viewWillLayoutSubviews() {
        print("viewWillLayoutSubviews")
    }
    
    ///Chaque fois que la vue est effectuée avec des calculs de mise en page automatique.
    ///Il est également appelé si la vue est mise à jour, tournée, modifiée ou si ses limites changent
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
    }
    
    ///Juste après l'ajout du View Controller à la hiérarchie des vues
    ///viewDidappear() est appelée à chaque fois que la vue apparaît à l'écran
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    ///Juste avant qu'il ne soit sur le point de disparaître de la hiérarchie des vues.
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }

    ///Lorsque la vue disparaît de la hiérarchie des vues
    override func viewDidDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    func initView() {
        let iShuffle = UIImage(systemName: "shuffle")
        buttonShuffle.setImage(iShuffle , for: .normal)
        buttonShuffle.setTitle("Shuffle", for: .normal)

        collectionViewCarpet.delegate = self
        collectionViewCarpet.dataSource = self
        collectionViewCarpet.register(CarpetCell.nib, forCellWithReuseIdentifier: CarpetCell.identifier)
    }
    
    func definieActionSelector() {
        buttonShuffle.addTarget(self, action: #selector(actionShuffleCards), for: .touchUpInside)
        
        viewModel.savePileCardsOfCarpet()
        
        timerLoad = Timer.scheduledTimer(
            timeInterval: 0.5 ,
            target: self,
            selector: #selector(loadProgress),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func actionShuffleCards() {
        viewModel.carpetCellViewModels.shuffle()
    }
    
    @objc func loadProgress(){
        progressLoad.progress += 0.1
        progressLoad.setProgress(progressLoad.progress, animated: true)
        
        if(progressLoad.progress == 1.0){
            timerLoad.invalidate()
            progressLoad.progress = 0.0
            viewModel.showPileCardsOfCarpet()
        }
     }
    
    func initValue() {
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionViewCarpet.reloadData()
            }
        }
        progressLoad.progress = 0.0
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
        print("\(indexPath.row) - \(carpet)")
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
