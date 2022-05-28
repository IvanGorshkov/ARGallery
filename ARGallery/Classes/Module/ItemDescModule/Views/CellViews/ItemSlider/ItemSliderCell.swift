//
//  ItemSliderCell.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 29.10.2021.
//

import UIKit

final class ItemSliderCell: BaseCell {
    internal var slider = ImageSlideshow()
    static let cellIdentifier = "ItemDescSliderCellModel"
    public fileprivate(set) var images = [InputSource]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [slider].forEach({
            contentView.addSubview($0)
        })
        addConstraintsSlider()
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateViews() {
        guard let model = model as? SliderCellModel else { return }
        
        images = [InputSource]()
        model.pics.forEach {
            images.append(KingfisherSource(urlString: $0)!)
            self.slider.setImageInputs(images)
        }
    }

    @objc
    private func didTap() {
        guard let model = model as? SliderCellModel else { return }
        model.action?(slider)
    }

    @objc
    private func swipeHandler(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
                slider.nextPage(animated: true)
        case .right:
                slider.previousPage(animated: true)
        default:
                break
         }
    }

    private func setUp() {
        setUpBase()
        setUpSlider()
    }

    private func setUpBase() {
        backgroundColor = .clear
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
    }

    private func setUpSlider() {
        slider.layer.cornerRadius = 10
        slider.slideshowInterval = 0.0
        slider.circular = true
        slider.pageIndicatorPosition = .init(horizontal: .center, vertical: .customBottom(padding: -5))
        slider.contentScaleMode = UIViewContentMode.scaleAspectFill

        let recognizerR = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        recognizerR.direction = UISwipeGestureRecognizer.Direction.right
        slider.addGestureRecognizer(recognizerR)

        let recognizerL = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        recognizerL.direction = UISwipeGestureRecognizer.Direction.left
        slider.addGestureRecognizer(recognizerL)

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        slider.addGestureRecognizer(gestureRecognizer)
    }
}
