//
//  FilterResultViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 07/03/2023.
//

import Foundation
import RxCocoa
import RxSwift

class FilterResultViewModel: BaseViewModel {
//    let postTemp = [Post(title: "Bán gấp nhà mặt tiền Nguyễn Huệ", address: "69 Nguyễn Huệ, Bến Thành, Quận 1", price: "60 tỷ", authorName: "đăng bởi Ngọc Châu"),
//                    Post(title: "Bán gấp nhà mặt tiền Nguyễn Huệ", address: "69 Nguyễn Huệ, Bến Thành, Quận 1", price: "60 tỷ", authorName: "đăng bởi Ngọc Châu"),
//                    Post(title: "Bán gấp nhà mặt tiền Nguyễn Huệ", address: "69 Nguyễn Huệ, Bến Thành, Quận 1", price: "60 tỷ", authorName: "đăng bởi Ngọc Châu"),
//                    Post(title: "Bán gấp nhà mặt tiền Nguyễn Huệ", address: "69 Nguyễn Huệ, Bến Thành, Quận 1", price: "60 tỷ", authorName: "đăng bởi Ngọc Châu"),
//                    Post(title: "Bán gấp nhà mặt tiền Nguyễn Huệ", address: "69 Nguyễn Huệ, Bến Thành, Quận 1", price: "60 tỷ", authorName: "đăng bởi Ngọc Châu"),
//                    Post(title: "Bán gấp nhà mặt tiền Nguyễn Huệ", address: "69 Nguyễn Huệ, Bến Thành, Quận 1", price: "60 tỷ", authorName: "đăng bởi Ngọc Châu"),
//                    Post(title: "Bán gấp nhà mặt tiền Nguyễn Huệ", address: "69 Nguyễn Huệ, Bến Thành, Quận 1", price: "60 tỷ", authorName: "đăng bởi Ngọc Châu"),
//                    Post(title: "Bán gấp nhà mặt tiền Nguyễn Huệ", address: "69 Nguyễn Huệ, Bến Thành, Quận 1", price: "60 tỷ", authorName: "đăng bởi Ngọc Châu")]
    var optionsList = [String]()
    let post = BehaviorRelay<[Post]>(value: [])
    let options = BehaviorRelay<[String]>(value: [])
    var tabBarItemTitle = TabBarItemTitle.sell
    var mainTabBarItemTitle = MainTitle.sell
    var tuppleOptionsList = [(key: Int, value: String)]()
    
    func initData() {
//        post.accept(postTemp)
    }
    
    func parseTuppleToArray() {
        optionsList = []
        for (_, element) in tuppleOptionsList.enumerated() {
            optionsList.append(element.value)
        }
        options.accept(optionsList)
    }
}
