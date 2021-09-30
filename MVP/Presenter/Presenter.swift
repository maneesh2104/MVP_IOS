//
//  Presenter.swift
//  MVP
//
//  Created by Maneesh Sakthivel on 9/29/21.
//

import Foundation
import UIKit

protocol UserPresnterDelegate:AnyObject {
    func presentUsers(users: [User])
    func presentAlert(message: String, title: String)
}

typealias PresenterDelegate = UserPresnterDelegate & UIViewController

class UserPresenter{
    weak var delegate: PresenterDelegate?
    
    public func setViewDelegate(delegate: PresenterDelegate){
        self.delegate = delegate
    }
    
    func getUsers(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data,_, error in
            
            guard let data=data, error == nil else{
                return
            }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                self?.delegate?.presentUsers(users: users)
            }
            catch{
                print(error)
            }
            
        }
        task.resume()
    }
    
    func tap(user: User){
        self.delegate?.presentAlert(message: user.email, title: user.name)
    }
    
}
