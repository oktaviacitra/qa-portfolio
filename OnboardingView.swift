import SwiftUI
import SnapshotTesting
import XCTest

final class OnboardingView_SnapshotTest: XCTestCase {
    func evaluateDefaultView() throws {
        let view = OnboardingView() // Given
        assertSnapshot(of: view,
                       as: .image(precision: 0.98,
                                  perceptualPrecision: 0.99)) // Then
    }
}

struct OnboardingView: View {
    var body: some View {
        VStack {
            topSection
            
            Spacer()
            
            picture
            
            description
            
            nextButton
        }
        .padding()
    }
    
    var nextButton: some View {
        Button(action: {}, label: {
            Text("Next").foregroundColor(Color.white)
        })
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 55)
        .background(Color(hue: 1.0, saturation: 0.688, brightness: 0.986))
        .cornerRadius(55/2)
    }
    
    var topSection: some View {
        HStack {
            title1
            Spacer()
            skipButton
        }
    }
    
    var description: some View {
        Text("small cake designed to serve one person, which may be baked in a small thin paper or aluminum cup.")
            .font(.body)
            .fontWeight(.regular)
            .multilineTextAlignment(.center)
            .padding
    }
    
    var title2: some View {
        Text("Order Cup Cake")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(Color(hue: 1.0, saturation: 0.688, brightness: 0.986))
            .kerning(1.2)
    }
    
    var picture: some View {
        Image("cupcake")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 300)
            .padding
    }
    
    
    var title1: some View {
        Text("Hello Foodies")
            .fontWeight(.semibold)
            .font(.title)
    }
    
    var skipButton: some View {
        Button(action: {},
               label:{
            Text("SKIP")
                .fontWeight(.semibold)
                .kerning(1.2)
                .foregroundColor(Color.black)
        })
    }
}
