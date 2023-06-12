//
//  StartViewController.swift
//  Fast Chat
//
//  Created by Macbook on 10/6/23.
//

import UIKit
class StartViewController: UIViewController {
    
    
    
    //MARK: - Data
    
    private var slides: [Slides] = [Slides(id: 0, image: UIImage(#imageLiteral(resourceName: "image1"))), Slides(id: 1, image: UIImage(#imageLiteral(resourceName: "image2"))), Slides(id: 2, image: UIImage(#imageLiteral(resourceName: "image3")))]
    
    lazy private var layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    
    lazy private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .black
        collectionView.isPagingEnabled = true
        //collectionView.clipsToBounds = false
        collectionView.bounces = false
        collectionView.alwaysBounceHorizontal = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        setupCollection()
        
        //dump(UIFont.familyNames)
        
    }
    
    
    //MARK: - CONSTRAINTS
    
    private func setupCollection() {
        self.view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.customID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
    }

}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate


extension StartViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.customID, for: indexPath) as! CustomCollectionViewCell
        
        cell.setImage(images: slides[indexPath.item])
        cell.delegate = self
        return cell
    }
    
}

extension StartViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        return self.view.frame.size
    }
    
}


extension StartViewController: CustomCollectionViewCellProtocol {
    
    func moveToRegVC() {
        navigationController?.pushViewController(RegViewController(), animated: true)
        print("Go to Registration button pressed! 😄🔥")
    }
        
    func moveToLoginVC() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
        print("Go to Login button pressed! 😄🔥")
        //navigationController?.pushViewController(MainTabBarController(), animated: true)
    }

}

