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
    
    
    //Footer Messages
    @Published var usernameMessages = [String] (repeating: " ", count: C.SignUpPage.numUsernameRequirements)
    @Published var passwordMessages = [String] (repeating: " ", count: C.SignUpPage.numPasswordRequirements)
    
    @Published var isRemembered = false
    @Published var isValid = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    
    //publsiher to ensure username is long enough
    private var isUsernameLongEnoguhPublisher: AnyPublisher<Bool, Never>{
        $username
            .removeDuplicates()
            .map{   i in
                return i.count >= C.SignUpPage.usernameRequiredLength
            }
            .eraseToAnyPublisher()
    }
    
    //publisher to ensure username is not too long
    private var isUsernameTooLongPublisher: AnyPublisher<Bool, Never>{
        $username
            .removeDuplicates()
            .map{   i in
                return i.count <= C.SignUpPage.usernameMaxLength
            }
            .eraseToAnyPublisher()
    }
    
    //is usernamevalid
    var isUsernameValidPublisher: AnyPublisher<[String], Never> {
        Publishers.CombineLatest(isUsernameLongEnoguhPublisher, isUsernameTooLongPublisher)
            .map { isUsernameLongEnoguh, isUsernameTooLong in
                var usernameMessages = [String] (repeating: " ", count: C.SignUpPage.numUsernameRequirements)
                if (!isUsernameLongEnoguh) {
                    usernameMessages[usernameMessages.firstIndex(where: { value in
                        value == " "
                    })!] = Strings.SignUpPage.isNotLongEnoughUsername
                }
                
                if (!isUsernameTooLong) {
                    usernameMessages[usernameMessages.firstIndex(where: { value in
                        value == " "
                    })!] = Strings.SignUpPage.isTooLongUsername
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
                return i.count >= C.SignUpPage.usernameRequiredLength
            }
            .eraseToAnyPublisher()
    }
    
    //publisher to ensure password is not too long
    private var isPasswordTooLongPublisher: AnyPublisher<Bool, Never>{
        $password
            .removeDuplicates()
            .map{   i in
                return i.count <= C.SignUpPage.usernameMaxLength
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
    var isPasswordValidPublisher: AnyPublisher<[String], Never> {
        Publishers.CombineLatest3(isPasswordLongEnoguhPublisher, isPasswordTooLongPublisher, isPasswordEqual)
            .map { isPasswordLongEnoguh, isPasswordTooLong, isPasswordEqual in
                var passwordMessages = [String] (repeating: " ", count: C.SignUpPage.numPasswordRequirements)
                if (!isPasswordLongEnoguh) {
                    passwordMessages[passwordMessages.firstIndex(where: { value in
                        value == " "
                    })!] = Strings.SignUpPage.isNotLongEnoughPassword
                }
                
                if (!isPasswordTooLong) {
                    passwordMessages[passwordMessages.firstIndex(where: { value in
                        value == " "
                    })!] = Strings.SignUpPage.isTooLongPassword
                }
                
                if (!isPasswordEqual) {
                    passwordMessages[passwordMessages.firstIndex(where: { value in
                        value == " "
                    })!] = Strings.SignUpPage.isNotEqualPassword
                }
                
                return passwordMessages
            }
            .eraseToAnyPublisher()
    }
    
    
    //can log in
    var isAbleToSignUp: AnyPublisher<Bool, Never>{
        Publishers.CombineLatest(isUsernameValidPublisher, isPasswordValidPublisher)
            .map{ usernameMessages, passwordMessages in
                if (usernameMessages == [String] (repeating: " ", count: C.SignUpPage.numUsernameRequirements) &&
                    passwordMessages == [String] (repeating: " ", count: C.SignUpPage.numPasswordRequirements)){
                    return true
                }
                return false
            }.eraseToAnyPublisher()
    }
    
    init(){
        
        isUsernameValidPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                self?.usernameMessages = $0
            })
            .store(in: &cancellableSet)
        
        isPasswordValidPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                self?.passwordMessages = $0
            })
            .store(in: &cancellableSet)
        
        isAbleToSignUp
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                self?.isValid = $0
            })
            .store(in: &cancellableSet)
    }
    
    
}
