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
}
