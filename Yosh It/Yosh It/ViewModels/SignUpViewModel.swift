//
//  SignUpViewModel.swift
//  Yosh It
//
//  Created by Alex Yoshida on 2023-05-09.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject{
    
    //requirements
    static let numUsernameRequirements = 2
    static let numPasswordRequirements = 2
    let usernameRequiredLength = 6
    let usernameMaxLength = 10
    
    let passwordRequiredLength = 6
    let passwordMaxLength = 10
    
    
    //User Info
    @Published var username = ""
    @Published var password = ""
    @Published var passwordAgain = ""
    
    
    //Footer Messages
    @Published var usernameMessages = [String] (repeating: " ", count: numUsernameRequirements)
    @Published var passwordMessages = [String] (repeating: " ", count: numUsernameRequirements)
    
    //Navigation
    @Published var showNextScreen = false
    @Published var isValid = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    
    //publsiher to ensure username is long enough
    private var isUsernameLongEnoguhPublisher: AnyPublisher<Bool, Never>{
        $username
            .removeDuplicates()
            .map{   i in
                return i.count >= self.usernameRequiredLength
            }
            .eraseToAnyPublisher()
    }
    
    //publisher to ensure username is not too long
    private var isUsernameTooLongPublisher: AnyPublisher<Bool, Never>{
        $username
            .removeDuplicates()
            .map{   i in
                return i.count <= self.usernameMaxLength
            }
            .eraseToAnyPublisher()
    }
    
    //is usernamevalid
    private var isUsernameValidPublisher: AnyPublisher<[String], Never> {
        Publishers.CombineLatest(isUsernameLongEnoguhPublisher, isUsernameTooLongPublisher)
            .map { isUsernameLongEnoguh, isUsernameTooLong in
                var usernameMessages = [String] (repeating: " ", count: SignUpViewModel.numUsernameRequirements)
                if (!isUsernameLongEnoguh) {
                    usernameMessages[usernameMessages.firstIndex(where: { value in
                        value == " "
                    })!] = "- Username must be 6 characters long"
                }
                
                if (!isUsernameTooLong) {
                    usernameMessages[usernameMessages.firstIndex(where: { value in
                        value == " "
                    })!] = "- Username must be less then 10 characters"
                }
                
                return usernameMessages
            }
            .eraseToAnyPublisher()
    }
    
    
    //publsiher to ensure password is long enough
    private var isPasswordLongEnoguhPublisher: AnyPublisher<Bool, Never> {
        $password
            .removeDuplicates()
            .map{   i in
                return i.count >= self.usernameRequiredLength
            }
            .eraseToAnyPublisher()
    }
    
    //publisher to ensure password is not too long
    private var isPasswordTooLongPublisher: AnyPublisher<Bool, Never>{
        $password
            .removeDuplicates()
            .map{   i in
                return i.count <= self.usernameMaxLength
            }
            .eraseToAnyPublisher()
    }
    
    //publisher to ensure password's are equal
    private var isPasswordEqual: AnyPublisher<Bool, Never>{
        Publishers.CombineLatest($password, $passwordAgain)
              .map { password, passwordAgain in
                return password == passwordAgain
              }
              .eraseToAnyPublisher()
    }
    
    //is password valid
    private var isPasswordValidPublisher: AnyPublisher<[String], Never> {
        Publishers.CombineLatest3(isPasswordLongEnoguhPublisher, isPasswordTooLongPublisher, isPasswordEqual)
            .map { isPasswordLongEnoguh, isPasswordTooLong, isPasswordEqual in
                var passwordMessages = [String] (repeating: " ", count: SignUpViewModel.numPasswordRequirements)
                if (!isPasswordLongEnoguh) {
                    passwordMessages[passwordMessages.firstIndex(where: { value in
                        value == " "
                    })!] = "- Password must be 6 characters long"
                }
                
                if (!isPasswordTooLong) {
                    passwordMessages[passwordMessages.firstIndex(where: { value in
                        value == " "
                    })!] = "- Password must be less then 10 characters"
                }
                
                if (!isPasswordEqual) {
                    passwordMessages[passwordMessages.firstIndex(where: { value in
                        value == " "
                    })!] = "- Passwords must be equal"
                }
                
                return passwordMessages
            }
            .eraseToAnyPublisher()
    }
    
    
    //can log in
    private var isAbleToSignUp: AnyPublisher<Bool, Never>{
        Publishers.CombineLatest(isUsernameValidPublisher, isPasswordValidPublisher)
            .map{ usernameMessages, passwordMessages in
                if (usernameMessages == [String] (repeating: " ", count: SignUpViewModel.numUsernameRequirements) &&
                    passwordMessages == [String] (repeating: " ", count: SignUpViewModel.numPasswordRequirements)){
                    return true
                }
                return false
            }.eraseToAnyPublisher()
    }
    
    init(){
        
        isUsernameValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.usernameMessages, on: self)
            .store(in: &cancellableSet)
        
        isPasswordValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.passwordMessages, on: self)
            .store(in: &cancellableSet)
        
        isAbleToSignUp
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on:self)
            .store(in: &cancellableSet)
        
    }
}
