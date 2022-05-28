//
//  EmptyCartView.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 08.11.2021.
//

import UIKit

final class EmptyCartView: UIView {
    internal var title = UILabel()
    internal var subTitle = UILabel()
    internal var imageView = UIImageView()
    
    init(frame: CGRect = CGRect.zero, titleText: String, subtitleText: String) {
        super.init(frame: frame)
        [title, subTitle, imageView].forEach { [weak self] view in
            self?.addSubview(view)
        }
        setUp(titleText: titleText, subtitleText: subtitleText)
        addViewConstraints()
    }
    
    func setUp(titleText: String, subtitleText: String) {
        setLabel(label: subTitle, text: subtitleText, alpha: 0.4, fontSize: 18, weight: .regular)
        setLabel(label: title, text: titleText, alpha: 0.5, fontSize: 36, weight: .bold)
        setUpImageView()
    }
    
    func setLabel(label: UILabel, text: String, alpha: CGFloat, fontSize: CGFloat, weight: UIFont.Weight) {
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textColor = ColorConstants.BlackColor.withAlphaComponent(alpha)
    }
    
    func setUpImageView() {
        imageView.image = UIImage(named: "cartImage")
        imageView.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
