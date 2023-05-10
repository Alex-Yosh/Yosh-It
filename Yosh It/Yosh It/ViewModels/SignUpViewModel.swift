//
//  SignUpViewModel.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-09.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject{
    
    //User Info
    @Published var username = ""
    @Published var password = ""
    @Published var passwordAgain = ""
    
    
    //ErrorMessage
    @Published var usernameErrorMessage = ""
    @Published var passwordErrorMessage = ""
    
    //Navigation
    @Published var showNextScreen = false
    @Published var isValid = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    
    private var isUserNameValid: AnyPublisher<Bool, Never>{
        $username
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map{   i in
                return i.count>=6
            }
            .eraseToAnyPublisher()
    }
    
    init(){
        isUserNameValid
            .receive(on: RunLoop.main)
            .map{ isvalid in
                isvalid ? " " : "Username must be 6 characters long"
            }
            .assign(to: \.usernameErrorMessage, on: self)
            .store(in: &cancellableSet)
    }
}
