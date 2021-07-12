//
//  URLRequest+Extensions.swift
//  RxWeather
//
//  Created by Len van Zyl on 2021/07/11.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

struct Resource<T>{
    let url: URL
}

extension URLRequest {
    static func load<T: Decodable>(resource: Resource<T>) -> Observable<T> {
        return Observable.from([resource.url]).flatMap {
            url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T in
                let response = try JSONDecoder().decode(T.self, from: data)
                return response
            }.asObservable()
        }
}
