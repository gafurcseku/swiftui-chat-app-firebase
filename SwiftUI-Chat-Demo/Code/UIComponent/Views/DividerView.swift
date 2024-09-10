//
//  DividerView.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 8/3/24.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        Divider()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0.5)
            .padding(.all, 0)
    }
}

#Preview {
    DividerView()
}
