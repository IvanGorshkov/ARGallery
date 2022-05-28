//
//  VCollectionViewTableViewCell.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 04.11.2021.
//

import UIKit
import AVFoundation

final class VCollectionViewTableViewCell: BaseCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    private var array: [VerticalViewModel] = []
    private var isReloaded = false

    internal lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        return collectionView
    }()

    static let cellIdentifier = "VCollectionViewModel"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [collectionView].forEach { [weak self] in
            self?.contentView.addSubview($0)
        }
        addConstraintsCollectionView()
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
        collectionView.register(VCollectionViewCell.self, forCellWithReuseIdentifier: VCollectionViewCell.cellIdentifier)
    }

    override func updateViews() {
        guard let model = model as? VCollectionViewModel else { return }
        array = model.array
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        collectionView.frame = CGRect(x: 8.0, y: 8.0, width: targetSize.width, height: targetSize.height)
        reloadLayout()
        return collectionView.collectionViewLayout.collectionViewContentSize
    }
    private func reloadLayout() {
        let layout = MosaicViewLayout()
        layout.delegate = self
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.collectionViewLayout.invalidateLayout()
        if isReloaded == false {
            collectionView.reloadData()
            isReloaded = true
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VCollectionViewCell.cellIdentifier, for: indexPath)
                as? VCollectionViewCell else {
                    return UICollectionViewCell()
                }

        cell.configure(model: array[indexPath.row], complition: {
            let myCell = collectionView.cellForItem(at: indexPath)
            return cell == myCell
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = model as? VCollectionViewModel else { return }
        model.action?(indexPath.row)
    }
}

// MARK: MosaicLayoutDelegate
extension VCollectionViewTableViewCell: MosaicLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForImageAtIndexPath indexPath: IndexPath,
        withWidth width: CGFloat,
        complition: @escaping (CGFloat) -> Void) {
        let item = array[indexPath.item]
        
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio:
                                CGSize(
                                    width: CGFloat(item.frameWidth),
                                    height: CGFloat(item.frameHeight)
                                ), insideRect: boundingRect)
            complition(rect.height)
    }

    func collectionView(_ collectionView: UICollectionView, heightForDescriptionAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let character = array[indexPath.item]
        let descriptionHeight = heightForText(character.name, width: width-24)
        let height = 4 + 17 + 4 + descriptionHeight
        return height
    }

    func heightForText(_ text: String, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 16)
        let rect = NSString(string: text).boundingRect(
            with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil)
        return ceil(rect.height)
    }
}
