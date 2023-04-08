//
//  ProjectDetailViewModel.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 01/04/2023.
//

import Foundation
import RxSwift
import RxRelay

class ProjectDetailViewModel: BaseViewModel {
    var project : Project?
    let images = BehaviorRelay<[String]>(value: [])
}
