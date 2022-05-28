//
//  VerticalPaintsModel.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 05.11.2021.
//


final class VerticalViewModel: BaseCellModel {
    let id: Int
    let pic: String
    let name: String
    let frameHeight: Int
    let frameWidth: Int
    
    override var cellIdentifier: String {
        return VCollectionViewCell.cellIdentifier
    }
    
    init(id: Int,
         pic: String,
         name: String,
         frameHeight: Int,
         frameWidth: Int) {
        self.id =  id
        self.pic = pic
        self.name = name
        self.frameHeight = frameHeight
        self.frameWidth = frameWidth
    }
}
