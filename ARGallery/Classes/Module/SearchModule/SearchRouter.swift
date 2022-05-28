//
//  SearchRouter.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 28.10.2021.
//  
//

import UIKit

final class SearchRouter {
}

extension SearchRouter: SearchRouterInput {    
    func itemSelected(with view: SearchViewInput?, and id: Int) {
        guard let view = view as? UIViewController else { return }
        let itemDesc = ItemDescContainer.assemble(with: ItemDescContext(id: id))
        view.navigationController?.pushViewController(itemDesc.viewController, animated: true)
    }
}
