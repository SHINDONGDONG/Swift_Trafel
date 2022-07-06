//
//  Slide.swift
//  Swift_Trafel
//
//  Created by 申民鐡 on 2022/07/04.
//

import Foundation


struct Slide {
    let imageName: String
    let title: String
    let description: String

    
    static let collection: [Slide] = [
        .init(imageName: "imSlide1", title: "ようこそiOSへ", description: "ただ人がどこにやりもらいかと云って、ようやく学校の分子というようます事です、時代にいうて、こちらに少し充たすながらは理由熊本となかろものだ。どちらは人をするたかもないな主義が這入りない右はまるあり訳ですますとあっです。"),
        .init(imageName: "imSlide2", title: "ようこそAndroidへ", description: "私は料にましだうち私かよるたて始めな、と限らて私がしから好いかこれからは実在をあるだ。"),
        .init(imageName: "imSlide3", title: "ようこそWebへ", description: "個性にちょっと投げばいるて、ない切り上げて、彼らもこのあとからいのに親しいと正直せがらなどありたあっから"),
    ]
}
