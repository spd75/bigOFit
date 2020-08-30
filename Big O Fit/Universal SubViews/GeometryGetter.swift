//
//  GeometryGetter.swift
//  Big O Fit
//
//  Created by Sergio Diaz on 8/27/20.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI

struct GeometryGetter: View {
    @Binding var rect: CGRect
    
    var body: some View {
        GeometryReader { g in
            self.makeView(g: g)
        }
    }
    
    func makeView(g: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = g.frame(in: .global)
        }
        
        return Rectangle().fill(Color.clear)
    }

}

struct GeometryGetter_Previews: PreviewProvider {
    static var previews: some View {
        GeometryGetter(rect: Binding.constant(CGRect()))
    }
}
