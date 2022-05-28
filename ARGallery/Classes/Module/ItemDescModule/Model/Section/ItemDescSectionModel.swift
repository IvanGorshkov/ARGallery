//
//  ItemDescSectionModel.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 29.10.2021.
//

import Foundation

final class ItemDescSectionModel: SectionRowsRepresentable {
    var rows: [CellIdentifiable]

    weak var delegate: ItemDescCellViewOutput?
    
    convenience init(_ desc: DescriptionEntity) {
        self.init(ItemDescResponse(id: 0, name: desc.name, picture: desc.picture, descr: desc.description, pictureSize: nil, info: desc.info), isAction: desc.isAction, addButtons: false)
    }
    
    init(_ itemDesc: ItemDescResponse, isAction: Bool = false, addButtons: Bool = true) {
        rows = [CellIdentifiable]()
        if isAction {
            rows.append(ItemDescNameCellModel(itemDesc, actionAR: { [weak self] in
                self?.delegate?.clickAR()
            }))
        } else {
            rows.append(ItemDescNameCellModel(itemDesc, actionAR: nil))
        }
        rows.append(SliderCellModel(itemDesc, action: { [weak self] imageSlideshow in
            self?.delegate?.openFullScreen(silder: imageSlideshow)
        }))
    
        if addButtons {
            rows.append(ButtonsDescModelCell(itemDesc, actionAR: { [weak self]  in
                self?.delegate?.clickAR()
            }, actionFav: { [weak self] isSelected in
                self?.delegate?.clickFav(isSelected: isSelected)
            }))
        }
        if !(itemDesc.descr?.isEmpty ?? true) {
          rows.append(AboutDescCellModel(itemDesc))
        }
        
        itemDesc.info?.forEach { [weak self] in
            self?.rows.append(SpecificationsDescCellModel($0))
        }
        
    }
}
