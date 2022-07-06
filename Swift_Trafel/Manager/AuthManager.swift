//
//  AuthManager.swift
//  Swift_Trafel
//
//  Created by 申民鐡 on 2022/07/05.
//

import Foundation
import FirebaseAuth

struct AuthManager {
    
    let auth = Auth.auth()
    
    enum AuthError: Error {
        case unknonError
    }
    
    //    private var isUserLoggedIn: Bool {
    //        return Auth.auth().currentUser != nil
    //    }
    
    func isUserLoggedIn() -> Bool {
        return auth.currentUser != nil
    }
    
    func signUpNewUser(whithEmail email: String, password: String, completion: @escaping (Result<User,Error>)-> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            }else if let user = result?.user {
                completion(.success(user))
            }else {
                completion(.failure(AuthError.unknonError))
            }
        }
    }
    
    func loginUser(withEmail email: String, password: String, completion: @escaping (Result<User,Error>)-> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            }else if let user = result?.user {
                completion(.success(user))
            }else {
                completion(.failure(AuthError.unknonError))
            }
        }
    }
    
    func logoutUser() -> Result<Void, Error> {
        do {
            try auth.signOut()
            return .success(())
        } catch(let error) {
            return .failure(error)
        }
    }
    
    func resetPassword(withEmail email :String, completion: @escaping(Result<Void,Error>)->Void ){
        auth.sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
            }else {
                completion(.success(()))
            }
        }
    }
    
}
