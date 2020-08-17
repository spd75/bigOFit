//
//  MultiLineTextView.swift
//  Big O Fit
//
//  Created by Home on 7/26/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import SwiftUI


struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String
    let fillerText: String
    let fontSize: CGFloat?
    

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        
        view.textContainer.lineFragmentPadding = 0
        view.textContainerInset = .zero
        view.backgroundColor = UIColor.clear
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        
        view.font = UIFont(name: "Nunito-Regular", size: fontSize ?? 20)
        
        if text != "" {
            view.text = text
            view.textColor = UIColor.black
        } else {
            view.text = fillerText
            view.textColor = CustomColors.textViewGray
        }
        
        view.delegate = context.coordinator
        
        return view
    }
    

    func updateUIView(_ uiView: UITextView, context: Context) {
//        if text != "" {
//            uiView.text = text
//        } else {
//            uiView.text = fillerText
//        }
        
    }
    
    func makeCoordinator() -> MultilineTextView.Coordinator {
        MultilineTextView.Coordinator(self, fillerText: self.fillerText)
    }
    
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: MultilineTextView
        var fillerText: String
        
        init(_ parent: MultilineTextView, fillerText: String) {
            self.parent = parent
            self.fillerText = fillerText
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == self.fillerText {
                textView.text = ""
            }
            textView.textColor = .black
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                textView.text = self.fillerText
                textView.textColor = CustomColors.textViewGray
            }
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                textView.resignFirstResponder()
                return false
            }
            return true
        }
        
        
    }
    
}

struct MultiLineTextView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
