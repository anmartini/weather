//
//  RegionalView.swift
//  weathER
//
//  Created by Roberto Casula on 28/02/21.
//

import SwiftUI

struct RegionalView: View {
    
    @ObservedObject var viewModel = RegionalViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.regionalDays, id: \.self) { regionalDay in
                RegionalDayView(regionalDay: regionalDay)
            }
        }
        .onAppear() {
            self.loadData()
        }
    }
    
    private func loadData() {
        viewModel.loadData()
    }
}

struct RegionalView_Previews: PreviewProvider {
    static var previews: some View {
        RegionalView()
    }
}
