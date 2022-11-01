//
//  Test.swift
//  auth_demo
//
//  Created by 暨大附中１ on 2022/12/7.
//

import SwiftUI

struct Test: View {
    @State var name: String = ""
    @State var id = ""
    var images = ["按鈕","名片","進入"]
    var body: some View {
        List{
            ForEach((0...images.count), id:\.self){index in
                Image(images[index % images.count])
            }
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
