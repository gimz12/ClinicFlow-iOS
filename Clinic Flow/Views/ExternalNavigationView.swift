import SwiftUI

struct ExternalNavigationView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL

    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                VStack(spacing: 16) {
                    Image(systemName: "map.fill")
                        .font(.system(size: 38, weight: .semibold))
                        .foregroundColor(navy)

                    Text("Open Maps")
                        .font(.system(size: 20, weight: .bold))

                    Text("Launch Apple Maps for turn-by-turn directions outside the clinic.")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)

                    Button(action: openMaps) {
                        Text("Open Apple Maps")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(navy)
                            .cornerRadius(14)
                    }
                    .padding(.horizontal, 16)

                    Spacer()
                }
                .padding(.top, 24)
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

            Text("External Navigation")
                .font(.system(size: 18, weight: .semibold))

            Spacer()

            Text(" ")
                .frame(width: 42)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private func openMaps() {
        if let url = URL(string: "https://maps.apple.com/?daddr=Central+Medical+Hospital") {
            openURL(url)
        }
    }
}

#Preview {
    NavigationStack {
        ExternalNavigationView()
    }
}
