//
//  HorizontalViewModel.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 05.11.2021.

import UIKit

class HorizontalViewModel: CellIdentifiable {
    var cellIdentifier: String {
        return HCollectionViewCell.cellIdentifier
    }

    var cellHeight: Float {
        return 1
    }

    let pic: String
    let name: String
    let id: Int

    let height: CGFloat
    let width: CGFloat
    
    var widthConstrint: CGFloat {
        let nHeight = CGFloat(170)
        let nWidth = (width / height) * nHeight
        return nWidth
    }
    
    init(card: Card) {
        self.pic = card.picture
        self.name = card.name
        self.height = CGFloat(card.pictureSize.height)
        self.width = CGFloat(card.pictureSize.width)
        self.id = card.id
    }
}
