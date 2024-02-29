//
//  ContentView.swift
//  WidgetDemo
//
//  Created by 贾建辉 on 2024/2/29.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("num") var num = 0
//    @State var num = 0
    
    let lineWidth: CGFloat = 26
    
    var body: some View {
        ZStack {
            Color.primary.ignoresSafeArea()
            VStack(spacing: 60) {
                ZStack {
                    Circle()
                        .stroke(.white.opacity(0.1), lineWidth: lineWidth)
                    Circle()
                        // CGFloat(num / 10) 与 CGFloat(num) / 10不一样，前者小数部分可能会丢失，后者不会
                        .trim(from: 0.0, to: CGFloat(num) / 10)
                        .stroke(.blue, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    VStack {
                        Text(String(num))
                            .font(.system(size: 60, weight: .heavy, design: .serif))
                            
                        Text("当前进度")
                            .font(.system(size: 14, weight: .bold))
                    }
                    .foregroundStyle(.white)
                }
                
                
                //按钮
                HStack {
                    Button {
                        if num >= 0 {
                            withAnimation(.spring()) {
                                num -= 1
                            }
                           
                        }
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.blue.opacity(0.1))
                            .frame(width: 80, height: 50)
                            .overlay {
                                Image(systemName: "minus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 22)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.blue)
                            }
                    }
                    .opacity(num == 0 ? 0.5 : 1)
                    .disabled(num == 0 ? true : false)
                    Spacer()
                    Button {
                        if num <= 10 {
                            num += 1
                        } else {
                            return
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.blue.opacity(0.1))
                            .frame(width: 80, height: 50)
                            .overlay {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 22)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.blue)
                            }
                    }
                    .opacity(num == 10 ? 0.5 : 1)
                    .disabled(num == 10 ? true : false)
                }
            }
            .padding(60)
        }
    }
}

#Preview {
    ContentView()
}
