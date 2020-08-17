//
//  ScollScreen.swift
//  Big O Fit
//
//  Created by Home on 8/9/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI


struct Together: View {
    var body: some View {
        VStack {
            HStack (spacing: 0) {
                PresentWorkout()
                PresentWorkoutStats()
            }
        }
        .padding(.vertical, 20)
        

    }
}




struct ScrollScreen: UIViewRepresentable {
    @Binding var pageNum: Int
    
    func makeUIView(context: Context) -> UIScrollView {
        let total = Constants.screenWidth * 2
        
        let view = UIScrollView()
        view.isPagingEnabled = true
        view.contentSize = CGSize(width: total, height: 1.0)
        view.bounces = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        let view1 = UIHostingController(rootView: Together())
        view1.view.frame = CGRect(x: 0, y: 0, width: total, height: Constants.screenHeight)
        view1.view.backgroundColor = .clear
        
        view.addSubview(view1.view)
        
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        print("updated")
    }

    static func changeScrollPos() {
        
    }
    
}


struct Final: View {
    @State var pageNum = 0
    @State var scrollPos = 0
    
    var body: some View {
        ZStack {
            EmptyView()
                .frame(width: Constants.screenWidth, height: Constants.screenHeight)
                .gesture(
                    TapGesture()
                        .onEnded({ _ in
                            print("hi")
                        })
                )
            VStack {
                ScrollScreen(pageNum: $pageNum)
                CustomCircleIndicator(totalScreenNum: 2, currentScreen: $pageNum)
                    .frame(width: 35)
                    .foregroundColor(.white)
                    .gesture(
                        DragGesture()
                            .onEnded({_ in 
                                print("bet")
                            })
                )
            }
            .edgesIgnoringSafeArea(.top)
            .padding(.vertical, 10)
        }
        
        
        

    }
}


struct ScollScreen_Previews: PreviewProvider {
    static var previews: some View {
        Final().background(CustomColors.darkishred)
        
    }
}
