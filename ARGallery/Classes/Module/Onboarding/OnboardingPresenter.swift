//
//  OnboardingPresenterARHome.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 08.05.2022.
//

import Foundation

struct OnboardingModel {
    var titles: [String]
    var descs: [String]
    var imgs: [String]
}
protocol OnboardingPresenter {
    func getValue() -> OnboardingModel
}


class OnboardingPresenterARHome: OnboardingPresenter {
    func getValue() -> OnboardingModel {
        return OnboardingModel(
            titles: ["Наведите на стену","Подождите, пока определится стена","Нажмите на найденную поверхность"],
            descs: ["Найдите вертикальную поверхность, на которую можно разместить картину","Двигайте телефоном в разные стороны, пока не опредится поверхность","Нажмите на выделенную поверхность. Тогда добавится картина!"],
            imgs:  ["onb1","onb2","onb3"])
    }
}

class OnboardingPresenterARGallery: OnboardingPresenter {
    func getValue() -> OnboardingModel {
        return OnboardingModel(
            titles: ["Наведите на картину","Подождите","Готово"],
            descs: ["Найдите камеру на интересующую вас картину","Дождитесь появления значка информации","Нажмите на значок для получения подробной информации о картине"],
            imgs:  ["arhome1","arhome2","arhome3"])
    }
}
