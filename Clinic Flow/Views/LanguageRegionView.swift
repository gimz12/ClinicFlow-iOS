import SwiftUI

struct LanguageRegionView: View {
    @Environment(\.dismiss) private var dismiss

    @AppStorage("lang_selectedLanguage") private var selectedLanguage: String = "English"
    @AppStorage("lang_selectedRegion") private var selectedRegion: String = "United States"
    @AppStorage("lang_useDeviceSettings") private var useDeviceSettings: Bool = true
    @AppStorage("lang_timeFormat24h") private var timeFormat24h: Bool = false
    @AppStorage("lang_weekStartsMonday") private var weekStartsMonday: Bool = false

    private let navy = Color(red: 0.10, green: 0.30, blue: 0.42)
    private let lightCard = Color(.systemBackground)

    private let languages = ["English", "Spanish", "French", "German", "Hindi", "Sinhala"]
    private let regions = ["United States", "United Kingdom", "Canada", "Australia", "Sri Lanka"]

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        infoCard

                        sectionTitle("Language")
                        languageSection

                        sectionTitle("Region")
                        regionSection

                        sectionTitle("Formats")
                        formatSection
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 28)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    private var header: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(navy)
            }

            Spacer()

            Text("Language & Region")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)

            Spacer()

            Image(systemName: "globe")
                .font(.system(size: 16))
                .opacity(0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private var infoCard: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(navy.opacity(0.12))
                    .frame(width: 52, height: 52)
                Image(systemName: "globe")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(navy)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Set your preferences")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)
                Text("Choose language, region, and formatting for dates and times.")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(16)
        .background(lightCard)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var languageSection: some View {
        VStack(spacing: 0) {
            toggleRow(
                title: "Use Device Language",
                subtitle: "Sync with iOS settings",
                isOn: $useDeviceSettings
            )
            .padding(16)

            Divider().padding(.leading, 16)

            selectionRow(title: "App Language", value: selectedLanguage)
                .padding(16)

            if !useDeviceSettings {
                Divider().padding(.leading, 16)
                selectionList(items: languages, selection: $selectedLanguage)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
            }
        }
        .background(lightCard)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var regionSection: some View {
        VStack(spacing: 0) {
            selectionRow(title: "Region", value: selectedRegion)
                .padding(16)

            Divider().padding(.leading, 16)

            selectionList(items: regions, selection: $selectedRegion)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
        }
        .background(lightCard)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private var formatSection: some View {
        VStack(spacing: 0) {
            toggleRow(
                title: "24-Hour Time",
                subtitle: "Use 24-hour time format",
                isOn: $timeFormat24h
            )
            .padding(16)

            Divider().padding(.leading, 16)

            toggleRow(
                title: "Week Starts Monday",
                subtitle: "Calendar week begins on Monday",
                isOn: $weekStartsMonday
            )
            .padding(16)
        }
        .background(lightCard)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }

    private func toggleRow(title: String, subtitle: String, isOn: Binding<Bool>) -> some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }

            Spacer()

            Toggle("", isOn: isOn)
                .labelsHidden()
        }
    }

    private func selectionRow(title: String, value: String) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
                Text("Selected: \(value)")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }

            Spacer()

            Text(value)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(navy)
        }
    }

    private func selectionList(items: [String], selection: Binding<String>) -> some View {
        VStack(spacing: 8) {
            ForEach(items, id: \.self) { item in
                Button(action: {
                    selection.wrappedValue = item
                }) {
                    HStack {
                        Text(item)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.primary)
                        Spacer()
                        if selection.wrappedValue == item {
                            Image(systemName: "checkmark")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(navy)
                        }
                    }
                    .padding(.vertical, 10)
                }

                if item != items.last {
                    Divider().padding(.leading, 8)
                }
            }
        }
        .padding(12)
        .background(Color(.systemGroupedBackground))
        .cornerRadius(12)
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text.uppercased())
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.secondary)
            .tracking(0.6)
            .padding(.horizontal, 2)
    }
}

#Preview {
    NavigationStack {
        LanguageRegionView()
    }
}
