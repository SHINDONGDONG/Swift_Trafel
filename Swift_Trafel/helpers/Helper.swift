//
//  Helper.swift
//  Swift_Trafel
//
//  Created by 申民鐡 on 2022/07/04.
//


import Foundation

func delay(durationInSeconds: Double, completion: @escaping ()->Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + durationInSeconds, execute: completion)
}
