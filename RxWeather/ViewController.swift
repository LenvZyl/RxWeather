//
//  ViewController.swift
//  RxWeather
//
//  Created by Len van Zyl on 2021/07/11.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        clearText()
        self.searchTextField.returnKeyType = .search
        self.searchTextField.rx.controlEvent([.editingDidEndOnExit])
            .asObservable().map{self.searchTextField.text}
            .subscribe(onNext: { city in
            guard let cityName = city else {
                return
            }
            if cityName.isEmpty {
                self.clearText()
            }else {
                self.fetchWeather(cityName)
            }
            
        }).disposed(by: disposeBag)
    }
    
    private func fetchWeather(_ city: String){
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL.weatherSearchUrl(city: cityEncoded) else {
            return
        }
        let resource = Resource<WeatherResult>(url: url)
        let search = URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .catchAndReturn(WeatherResult.emptyResponse)
        search.map { "\($0.main.temp) ℃"}
        .bind(to: self.tempLabel.rx.text).disposed(by: disposeBag)
        search.map { "\($0.main.humidity) 💧"}
        .bind(to: self.humidityLabel.rx.text).disposed(by: disposeBag)
    }
    private func clearText(){
        self.tempLabel.text = "- ℃"
        self.humidityLabel.text = "- 💧"
    }

}

