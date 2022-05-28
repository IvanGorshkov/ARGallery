//
//  HorizontalCollectionViewCell.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 04.11.2021.
//

import UIKit

final class HCollectionViewTableViewCell: BaseCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var array: [HorizontalViewModel] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    static let cellIdentifier = "HCollectionViewModel"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [collectionView].forEach { [weak self] in
            self?.contentView.addSubview($0)
        }
        addConstraintsCollectionView()
        setUp()
    }
    
    private func setUp() {
        backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HCollectionViewCell.self, forCellWithReuseIdentifier: HCollectionViewCell.cellIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateViews() {
        guard let model = model as? HCollectionViewModel else { return }
        array = model.array
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HCollectionViewCell.cellIdentifier, for: indexPath)
                as? HCollectionViewCell else {
                    return UICollectionViewCell()
                }
        
        cell.configure(model: array[indexPath.row]) {
            let myCell = collectionView.cellForItem(at: indexPath)
            return cell == myCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = model as? HCollectionViewModel else { return }
        model.action?(indexPath.row)
    }
}
