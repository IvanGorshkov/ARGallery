//
//  ItemDescInteractor.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 28.10.2021.
//  
//

import UIKit
import Kingfisher

final class ItemDescInteractor {
	weak var output: ItemDescInteractorOutput?
    private var itemDescModel: ItemDescResponse?
    
    init() { }
}

extension ItemDescInteractor: ItemDescInteractorInput {
    func changeFav(isSelected: Bool) {
        guard let itemDescModel = itemDescModel else { return }
        if isSelected {
            FavStorage().add(id: itemDescModel.id)
        } else {
            FavStorage().remove(id: itemDescModel.id)
        }
    }
    

    func prepareShareData() {
        DownloadImage.shred.downloadImage(with: itemDescModel?.picture.components(separatedBy: ",").first ?? "") { [weak self] image in
            var items: [Any] = [image!]
            let info = self?.itemDescModel?.info?.map({ info in
                return info.type + " " + info.value + "\n"
            }).joined()
            let desc = [
                (self?.itemDescModel?.name)! + "\n",
                ((self?.itemDescModel?.descr) ?? "") + "\n",
                info!
                ].joined()
            items.append(desc)
            self?.output?.shareDataDidRecive(items: items)
        }
        
    }
    
    func loadFirstPhoto() {
        DownloadImage.shred.downloadImage(with: itemDescModel?.picture ?? "") { image in
            guard let image = image else {
                return
            }

            self.output?.firstPhotoDidLoad(
                arModel: PaintingARModel(pic: image, width: Float(self.itemDescModel?.pictureSize?.width ?? 0), height: Float(self.itemDescModel?.pictureSize?.height ?? 0))
            )
        }
    }


    func loadItemById(with id: Int) {
        ItemDescRequest(id: id).perform { [weak self] itemDescModel, err in
            if err != nil {
                return
            }
            guard let self = self, let itemDescModel = itemDescModel else {
                return
            }
            self.itemDescModel = itemDescModel
            self.itemDescModel?.isSelected = FavStorage().isExist(id: id)
            self.output?.itemDidLoad(itemDesc:  self.itemDescModel!)
        }
    }
}
