//
//  HTTPRequestsProtocol.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 21/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Foundation

protocol HTTPRequestsProtocol {
    func registerUser(email eMail: String,
                                    password passWord: String,
                                    success: @escaping(_ response: RSBaseResponse) -> Void,
                                    failure: @escaping(_ error: RSBaseResponse) -> Void)
    func loginUser(email: String,
                   password: String,
                   successBlock: @escaping(_ response: LoginResponse) -> Void,
                   failureBlock: @escaping(_ error: RSBaseResponse) -> Void)
    
    func createNewUser(name: String,
                    email: String,
                    avatarName: String,
                    avatarColor: String,
                    sucessBlock: @escaping () -> Void,
                    failureBlock: @escaping (RSBaseResponse?) -> Void)
    
    func findUserByEmail(_ email: String, completionBlock: @escaping(_ userObject: User?) -> Void)
    
    func findAllChannels(succesBlock: @escaping([Channel]) -> Void, failureBlock: @escaping(RSBaseResponse?) -> Void)
    
    func findAllMessagesForChannel(_ channel: Channel,
                                   successBlock: @escaping([Message]?) -> Void,
                                   failureBlock: @escaping(RSBaseResponse?) -> Void)
    
    
    
}
