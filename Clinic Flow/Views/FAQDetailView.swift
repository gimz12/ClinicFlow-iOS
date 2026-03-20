import SwiftUI

struct FAQItem: Identifiable, Hashable {
    let id = UUID()
    let question: String
    let answer: String
    let steps: [String]
}

struct FAQDetailView: View {
    @Environment(\.dismiss) private var dismiss

    let faq: FAQItem

    private let navy = Color(red: 0.10, green: 0.30, blue: 0.42)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(faq.question)
                            .font(.system(size: 20, weight: .bold))

                        Text(faq.answer)
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)

                        if !faq.steps.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Steps")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.secondary)

                                ForEach(faq.steps.indices, id: \.self) { index in
                                    HStack(alignment: .top, spacing: 8) {
                                        Text("\(index + 1).")
                                            .font(.system(size: 13, weight: .semibold))
                                            .foregroundColor(navy)
                                        Text(faq.steps[index])
                                            .font(.system(size: 13))
                                            .foregroundColor(.primary)
                                    }
                                }
                            }
                            .padding(16)
                            .background(Color(.systemBackground))
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(.systemGray5), lineWidth: 1)
                            )
                        }
                    }
                    .padding(16)
                }
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

            Text("FAQ")
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
    FAQDetailView(faq: FAQItem(question: "How do I reschedule an appointment?", answer: "Open your appointment details and choose Reschedule.", steps: ["Open Home tab", "Tap View Details", "Choose Reschedule"]))
}
