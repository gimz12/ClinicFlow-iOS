import SwiftUI

struct VoiceDirectionsView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var voiceEnabled: Bool = true
    @State private var voiceVolume: Double = 0.7

    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                VStack(alignment: .leading, spacing: 16) {
                    Toggle("Enable Voice Directions", isOn: $voiceEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: navy))

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Volume")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.secondary)
                        Slider(value: $voiceVolume)
                            .tint(navy)
                    }

                    Text("Voice guidance will announce upcoming turns and arrivals.")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)

                    Spacer()
                }
                .padding(16)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    private var header: some View {
        HStack {
            Button(action: { dismiss() }) {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(navy)
            }

            Spacer()

            Text("Voice Directions")
                .font(.system(size: 18, weight: .semibold))

            Spacer()

            Text(" ")
                .frame(width: 42)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
}

#Preview {
    NavigationStack {
        VoiceDirectionsView()
    }
}
