//
//  MainRouter.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 28.10.2021.
//  
//

import UIKit

final class MainRouter {
}

extension MainRouter: MainRouterInput {
    func museumSelected(with view: MainViewInput?, title: String, and id: Int) {
        guard let view = view as? UIViewController else { return }
        let exhibitions = GalleriesContainer.assemble(with: GalleriesContext( id: id, title: title))
        view.navigationController?.pushViewController(exhibitions.viewController, animated: true)
        }
        
    func exebitionSelected(with view: MainViewInput?, title: String, and id: Int) {
        guard let view = view as? UIViewController else { return }
        let exhibitions = ExhibitionsContainer.assemble(with: ExhibitionsContext( id: id, title: title))
        view.navigationController?.pushViewController(exhibitions.viewController, animated: true)
    }
    
    func goToAllExhibition(with view: MainViewInput?) {
        guard let view = view as? UIViewController else { return }
        let container = AllContainer.assemble(with: AllContext(creator: ExhibitionsCreatorForAll()))
        view.navigationController?.pushViewController(container.viewController, animated: true)
    }

    func goToAllGallery(with view: MainViewInput?) {
        guard let view = view as? UIViewController else { return }
        let container = AllContainer.assemble(with: AllContext(creator: GalleriesCreatorForAll()))
        view.navigationController?.pushViewController(container.viewController, animated: true)
    }

    func itemSelected(with view: MainViewInput?, and id: Int) {
        guard let view = view as? UIViewController else { return }
        let itemDesc = ItemDescContainer.assemble(with: ItemDescContext(id: id))
        view.navigationController?.pushViewController(itemDesc.viewController, animated: true)
    }
}
