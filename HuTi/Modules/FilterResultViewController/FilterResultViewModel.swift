//
//  FilterResultViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 07/03/2023.
//

import Foundation
import RxCocoa
import RxSwift

class FilterResultViewModel {
    let bag = DisposeBag()
    let postTemp = [Post(title: "Bán gấp nhà mặt tiền Nguyễn Huệ", address: "69 Nguyễn Huệ, Bến Thành, Quận 1", price: "60 tỷ", authorName: "đăng bởi Ngọc Châu"),
                    Post(title: "Bán gấp nhà mặt tiền Nguyễn Huệ", address: "69 Nguyễn Huệ, Bến Thành, Quận 1", price: "60 tỷ", authorName: "đăng bởi Ngọc Châu"),
                    Post(title: "Bán gấp nhà mặt tiền Nguyễn Huệ", address: "69 Nguyễn Huệ, Bến Thành, Quận 1", price: "60 tỷ", authorName: "đăng bởi Ngọc Châu"),
                    Post(title: "Bán gấp nhà mặt tiền Nguyễn Huệ", address: "69 Nguyễn Huệ, Bến Thành, Quận 1", price: "60 tỷ", authorName: "đăng bởi Ngọc Châu"),
                    Post(title: "Bán gấp nhà mặt tiền Nguyễn Huệ", address: "69 Nguyễn Huệ, Bến Thành, Quận 1", price: "60 tỷ", authorName: "đăng bởi Ngọc Châu"),
                    Post(title: "Bán gấp nhà mặt tiền Nguyễn Huệ", address: "69 Nguyễn Huệ, Bến Thành, Quận 1", price: "60 tỷ", authorName: "đăng bởi Ngọc Châu"),
                    Post(title: "Bán gấp nhà mặt tiền Nguyễn Huệ", address: "69 Nguyễn Huệ, Bến Thành, Quận 1", price: "60 tỷ", authorName: "đăng bởi Ngọc Châu"),
                    Post(title: "Bán gấp nhà mặt tiền Nguyễn Huệ", address: "69 Nguyễn Huệ, Bến Thành, Quận 1", price: "60 tỷ", authorName: "đăng bởi Ngọc Châu")]
    let addressTemp = ["TP. Hồ Chí Minh", "Quận Tân Phú", "Tân Sơn Nhì"]
    let post = BehaviorRelay<[Post]>(value: [])
    let address = BehaviorRelay<[String]>(value: [])
    var tabBarItem = 0
    
    func initData() {
        post.accept(postTemp)
        address.accept(addressTemp)
    }
}
