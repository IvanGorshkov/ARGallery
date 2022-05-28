//
//  FavoriteRouter.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 05.04.2022.
//  
//

import UIKit

final class FavoriteRouter {
}

extension FavoriteRouter: FavoriteRouterInput {
    func itemSelected(with view: FavoriteViewInput?, and id: Int) {
        guard let view = view as? UIViewController else { return }
        let itemDesc = ItemDescContainer.assemble(with: ItemDescContext(id: id))
        view.navigationController?.pushViewController(itemDesc.viewController, animated: true)
    }
}
