import SwiftUI

struct BookingView: View {
    let offering: Offering
    @Environment(\.dismiss) private var dismiss
    @State private var fromDate: Date
    @State private var toDate: Date
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    
    init(offering: Offering) {
        self.offering = offering
        let now = Date()
        let roundedNow = offering.hourlyBookingAllowed ? now.roundedToHour() : now
        _fromDate = State(initialValue: roundedNow)
        _toDate = State(initialValue: roundedNow.addingTimeInterval(offering.hourlyBookingAllowed ? 3600 : 86400))
    }
    
    private var minimumDuration: TimeInterval {
        offering.hourlyBookingAllowed ? 3600 : 86400 // 1 hour or 1 day
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Booking Duration")) {
                    DatePicker("From",
                             selection: Binding(
                                get: { fromDate },
                                set: { newDate in
                                    if offering.hourlyBookingAllowed {
                                        fromDate = newDate.roundedToHour()
                                        // Ensure toDate maintains minimum duration
                                        if toDate < fromDate.addingTimeInterval(minimumDuration) {
                                            toDate = fromDate.addingTimeInterval(minimumDuration)
                                        }
                                    } else {
                                        fromDate = newDate
                                    }
                                }
                             ),
                             in: Date()...,
                             displayedComponents: offering.hourlyBookingAllowed ? [.date, .hourAndMinute] : [.date])
                    
                    DatePicker("To",
                             selection: Binding(
                                get: { toDate },
                                set: { newDate in
                                    if offering.hourlyBookingAllowed {
                                        toDate = newDate.roundedToHour()
                                    } else {
                                        toDate = newDate
                                    }
                                }
                             ),
                             in: fromDate.addingTimeInterval(minimumDuration)...,
                             displayedComponents: offering.hourlyBookingAllowed ? [.date, .hourAndMinute] : [.date])
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Price Breakdown")
                            .font(.headline)
                        
                        HStack {
                            Text(offering.hourlyBookingAllowed ? "Hours" : "Days")
                            Spacer()
                            Text("\(durationUnits)")
                        }
                        
                        HStack {
                            Text("Rate")
                            Spacer()
                            Text("₹\(String(format: "%.2f", offering.cost)) per \(offering.hourlyBookingAllowed ? "hour" : "day")")
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Total")
                                .fontWeight(.bold)
                            Spacer()
                            Text("₹\(String(format: "%.2f", totalCost))")
                                .fontWeight(.bold)
                        }
                    }
                }
                
                Section {
                    Button(action: confirmBooking) {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        } else {
                            Text("Confirm Booking")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .disabled(isLoading)
                }
            }
            .navigationTitle("Book \(offering.name)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Booking", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private var durationUnits: Int {
        let timeInterval = toDate.timeIntervalSince(fromDate)
        return Int(ceil(timeInterval / minimumDuration))
    }
    
    private var totalCost: Double {
        Double(durationUnits) * offering.cost
    }
    
    private func confirmBooking() {
        guard let userId = SessionManager.shared.currentUser?.id else {
            alertMessage = "Please login to make a booking"
            showingAlert = true
            return
        }
        
        isLoading = true
        
        let request = BookingRequest(
            userId: userId,
            offering: offering,
            fromDate: fromDate,
            toDate: toDate,
            totalAmount: totalCost,
            durationUnits: durationUnits
        )
        
        Task {
            do {
                try await NetworkService.shared.createBooking(request)
                await MainActor.run {
                    isLoading = false
                    alertMessage = "Booking confirmed successfully!"
                    showingAlert = true
                    // Optionally dismiss the view after successful booking
                    dismiss()
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                    alertMessage = "Failed to create booking: \(error.localizedDescription)"
                    showingAlert = true
                }
            }
        }
    }
}

// Add this extension to help with date rounding
extension Date {
    func roundedToHour() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: self)
        return calendar.date(from: components) ?? self
    }
} 