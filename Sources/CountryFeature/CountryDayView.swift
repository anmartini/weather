//
//  CountryDayView.swift
//
//
//  Created by Roberto Casula on 07/04/21.
//

import SwiftUI
import SharedModels
import SharedExtensions

struct CountryDayView: View {

    let countryDay: CountryDay

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text((countryDay.readableDay ?? "giorno").capitalizedFirstLetter)
                    .font(.title)
                Spacer()
            }
            VStack(alignment: .leading, spacing: 5) {
                FakeHtmlView(countryDay.forecast)
            }
            HStack {
                Spacer()
                Text("Previsione del \(countryDay.readableUpdatedAt ?? "")")
                    .font(.footnote)
            }
            Text("Zone")
                .font(.title2)
            List {
                ForEach(countryDay.zones, id: \.self) { zone in
                    Group {
                        if zone.forecast != nil {
                            NavigationLink(destination: ZoneView(zone: zone)) {
                                Text(zone.name.capitalizedFirstLetter)
                            }
                        } else {
                            Text(zone.name.capitalizedFirstLetter)
                        }
                    }
                }
            }
            .frame(height: CGFloat(45 * countryDay.zones.count))
        }
    }
}

struct CountryDayView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDayView(
            countryDay: .init(
                day: Date(),
                forecast:
                    "<p>Sereno tutta la <b>giornata</b>.</p><p>Temperature massime pomeridiane comprese tra 14° sui rilievi e 19° in pianura.</p><p>Velocità massima del vento compresa tra 15 (sui rilievi) e 19 km/h (in pianura).</p>",
                updatedAt: Date(),
                zones: [
                    .init(
                        code: "A",
                        name: "AAA",
                        forecast: .init(
                            rain: "rain",
                            wind: 2,
                            temperature: .init(
                                min: 10,
                                max: 20
                            )
                        ),
                        times: [
                            .init(
                                weather: .init(
                                    value: "AA",
                                    text: .init(
                                        it: "aa",
                                        en: "aa"
                                    )
                                )
                            )
                        ]
                    )
                ]
            )
        )
    }
}
