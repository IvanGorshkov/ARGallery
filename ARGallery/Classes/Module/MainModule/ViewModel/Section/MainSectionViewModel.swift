//
//  MainSectionViewModel.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 04.11.2021.
//

import Foundation

final class MainSectionViewModel: SectionRowsRepresentable {
    var rows: [CellIdentifiable]
    var actions: TableViewCellOutput?
    
    func fillData(mainResponse: MainResponse) {
        rows.insert(
            HCollectionViewModel(array: mainResponse.topMuseum.compactMap({ card in
                return HorizontalViewModel(card: card)
            }), action: { [weak self] index in
                self?.actions?.clickOnCompilation(with: index)
            }), at: 1)
        
        rows.insert(
            HCollectionViewModel(array: mainResponse.topExhibition.compactMap({ card in
                return HorizontalViewModel(card: card)
            }), action: { [weak self] index in
                self?.actions?.clickOnAuthor(with: index)
            }), at: 3)
    
        rows.append(VCollectionViewModel(action: { [weak self] index in
            self?.actions?.clickOnArt(with: index)
        }, cards: mainResponse.recommendation))
    }
    
    init() {
        rows = [CellIdentifiable]()
        rows.append(HeaderCellViewModel(title: TitlesConstants.TopGalleryTitile, action: {
            self.actions?.clickAllCompilation()
        }))
        
        rows.append(HeaderCellViewModel(title: TitlesConstants.TopExhibitionTitle, action: {
            self.actions?.clickAllAuthor()
        }))

        rows.append(HeaderCellViewModel(title: TitlesConstants.RecommendationTitle, action: nil))
    }
}
