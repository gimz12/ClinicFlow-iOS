import SwiftUI

struct ShareLocationView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var shareCode: String = "A201-9382"
    @State private var copied: Bool = false

    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                VStack(spacing: 16) {
                    Text("Share your location with a companion")
                        .font(.system(size: 16, weight: .semibold))

                    Text("Give them this code to follow your route.")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)

                    Text(shareCode)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(navy)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.systemGray5), lineWidth: 1)
                        )

                    Button(action: copyCode) {
                        Text(copied ? "Copied" : "Copy Code")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(navy)
                            .cornerRadius(14)
                    }
                }
                .padding(16)

                Spacer()
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

            Text("Share Location")
                .font(.system(size: 18, weight: .semibold))

            Spacer()

            Text(" ")
                .frame(width: 42)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private func copyCode() {
        UIPasteboard.general.string = shareCode
        copied = true
    }
}

#Preview {
    NavigationStack {
        ShareLocationView()
    }
}
