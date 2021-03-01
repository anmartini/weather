//
//  CountryDayView.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import SwiftUI

struct CountryDayView: View {
    let countryDay: CountryDay
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            HStack {
                Text((countryDay.readableDay ?? "giorno").capitalizedFirstLetter())
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            VStack (alignment: .leading, spacing: 5) {
                FakeHtmlView(countryDay.forecast)
            }
            VStack (alignment: .leading, spacing: 5) {
                ForEach(countryDay.zones, id: \.self) { zone in
                    Text(zone.name)
                }
            }
            HStack {
                Spacer()
                Text("Previsione del \(countryDay.readableUpdatedAt ?? "")")
                    .font(.footnote)
            }
        }
    }
}

struct CountryDayView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDayView(countryDay: CountryDay(
            day: Date(),
            forecast: "<p>Sereno tutta la <b>giornata</b>.</p><p>Temperature massime pomeridiane comprese tra 14° sui rilievi e 19° in pianura.</p><p>Velocità massima del vento compresa tra 15 (sui rilievi) e 19 km/h (in pianura).</p>",
            updatedAt: Date(),
            zones: []
        ))
    }
}
