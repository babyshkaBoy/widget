//
//  BottleView.swift
//  widgets
//
//  Created by Азамат Баев on 24.06.2024.
//

import SwiftUI

enum BottleType {
    case big
    case small
}

struct BottleView: View {
    @Binding var waterAmount: Int
    @Binding var maxVolume: Int
    var liquidPercentage: CGFloat {
        CGFloat(waterAmount) / CGFloat(maxVolume)
    }
    
    var bottleType: BottleType = .big
    
    var fillColor: Color = .blue.opacity(0.3)
    var emptyColor: Color = .gray.opacity(0.3)
    
    
    var bottleHeight: CGFloat {
        switch bottleType {
        case .big:
            return 200
        case .small:
            return 70
        }
    }
    
    var bottleWidth: CGFloat {
        switch bottleType {
        case .big:
            return 100
        case .small:
            return 50
        }
    }
    
    
    var strawHeight: CGFloat {
        switch bottleType {
        case .big:
            return 50
        case .small:
            return 30
        }
    }
    
    var strawWidth: CGFloat {
        switch bottleType {
        case .big:
            return 15
        case .small:
            return 10
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            //straw
            Rectangle().fill(liquidPercentage == 1 ? fillColor : emptyColor ).frame(width: strawWidth, height: strawHeight)
            
            
            VStack(spacing: 0) {
                //empty part of bottle
                Rectangle().fill(emptyColor).frame(width: bottleWidth, height: bottleHeight * (1 - liquidPercentage))
                
                
                //full part of bottle
                Rectangle().fill(fillColor).frame(width: bottleWidth, height: bottleHeight * liquidPercentage)
                
            }
           
        }
    }
}

#Preview {
    BottleView(waterAmount: .constant(1500), maxVolume: .constant(3000), bottleType: .small)
}

