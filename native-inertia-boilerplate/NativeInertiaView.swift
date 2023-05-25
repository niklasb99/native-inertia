//
//  NativeInertiaViewController.swift
//  native-inertia-boilerplate
//
//  Created by Niklas Burger on 25.05.23.
//

import CoreData
import SwiftUI
import CoreHaptics

struct NativeInertiaView: View {
    @ObservedObject var compassHeading = CompassHeading()
    
    var body: some View {
        VStack {
            Text("\(Int(self.compassHeading.degrees)*(-1))°")
                .font(.title)
                .bold()
        }
        
    }
}
