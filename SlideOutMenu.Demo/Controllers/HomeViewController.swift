//
//  HomeViewController.swift
//  SlideOutMenu.Demo
//
//  Created by Art Arriaga on 2/10/20.
//  Copyright © 2020 ArturoArriaga.IO. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationItem.title = "Hello There"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
//
//    init() {
//
//        let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
//
//            if sectionNumber == 0 {
//                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//                item.contentInsets.bottom = 16
//                item.contentInsets.trailing = 16
//
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(300)), subitems: [item])
//                let section = NSCollectionLayoutSection(group: group)
//                section.orthogonalScrollingBehavior = .groupPaging
//                section.contentInsets.leading = 16
//                return section
//            } else {
//                // second section
//
//                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)))
//                item.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 16)
//
//                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(300)), subitems: [item])
//
//                let section = NSCollectionLayoutSection(group: group)
//                section.orthogonalScrollingBehavior = .groupPaging
//                section.contentInsets.leading = 16
//
//                let kind = UICollectionView.elementKindSectionHeader
//                section.boundarySupplementaryItems = [
//                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: kind, alignment: .topLeading)
//                ]
//
//                return section
//            }
//        }
//
//        super.init(collectionViewLayout: layout)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
