//
//  NumberPadView.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/19.
//

import SwiftUI

struct NumberPadView: View {
    @Binding var number : String
    
    var body: some View {
        VStack {
            ForEach(0...2,id:\.self){ rowIndex in
                HStack {
                    ForEach(1...3,id:\.self){ index in
                        NumberPadButtonView(textField: $number,number: "\((rowIndex*3)+index)")
                    }
                }
            }
            HStack {
                ZStack {
                    Circle()
                        .foregroundColor(Color(UIColor.systemGray6))
                    Image(systemName:"clear")
                        .font(.system(size: 30))
                        .foregroundColor(Color(UIColor.darkGray))
                }
                .onTapGesture {
                    number.removeAll()
                }
                .frame(width: 60, height: 60)
                NumberPadButtonView(textField: $number, number: "0")
                ZStack {
                    Circle()
                        .foregroundColor(Color(UIColor.systemGray6))
                    Image(systemName:"delete.left")
                        .font(.system(size: 30))
                        .foregroundColor(Color(UIColor.darkGray))
                }
                .onTapGesture {
                    number.removeLast(!number.hasSuffix("-") ? 1 :2)
                }
                .frame(width: 60, height: 60)
            }
        }
    }
}

private struct NumberPadButtonView: View {
    @Binding var textField: String
    let number: String
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color(UIColor.systemGray6))
            Text(number)
                .font(.system(size: 40))
                .foregroundColor(Color(UIColor.darkGray))
        }
        .frame(width: 60, height: 60)
        .onTapGesture {
            textField += number
        }
    }
}

struct NumberPadView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPadView(number: .constant(""))
    }
}
