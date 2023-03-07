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
    let post = BehaviorRelay<[Port]>(value: [])
    var tabBarItem = 0
}
