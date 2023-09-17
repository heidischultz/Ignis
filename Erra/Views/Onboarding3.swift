//
//  Onboarding3.swift
//  Erra
//
//  Created by Heidi Schultz on 9/1/23.
//


/*
This is the add address page
 
 */

import SwiftUI
import FirebaseAuth
import CoreData

struct Onboarding3: View {
    @State private var isHomeViewPresented = false
    let managedObjectContext = PersistenceController.shared.container.viewContext
    @StateObject private var viewModelAddress = AddressViewModel()
    @StateObject private var viewModel = Onboarding3ViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView { // Wrap your view inside a NavigationView
                ZStack {
                    VStack {
                        Image("onboardFire")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.55)
                        
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.45)
                            .foregroundColor(.white)
                    }
                    
                    ZStack {
                        // Rectangle that comes out
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height * 0.30)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        
                        VStack {
                            Text("Add a Primary Address")
                                .font(Font.custom("Inter-Regular", size: 24))
                                .padding(.bottom, 80)
                            
                            TextField("Street", text: $viewModelAddress.primary)
                                .padding()
                                .background(
                                    VStack {
                                        Color.white.opacity(0.4)
                                        Rectangle().frame(height: 1).foregroundColor(.gray)
                                    }
                                )
                                .frame(width: UIScreen.main.bounds.width * 0.80)
                            
                            TextField("City", text: $viewModelAddress.city)
                                .padding()
                                .background(
                                    VStack {
                                        Color.white.opacity(0.4)
                                        Rectangle().frame(height: 1).foregroundColor(.gray)
                                    }
                                )
                                .frame(width: UIScreen.main.bounds.width * 0.80)
                            
                            TextField("Country", text: $viewModelAddress.country)
                                .padding()
                                .background(
                                    VStack {
                                        Color.white.opacity(0.4)
                                        Rectangle().frame(height: 1).foregroundColor(.gray)
                                    }
                                )
                                .frame(width: UIScreen.main.bounds.width * 0.80)
                        }
                    }
                    
                    // Fix static
                    Image("Logo")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .aspectRatio(contentMode: .fit)
                        .position(x: 290, y: 700)
                    
                    // Bottom stuff
                    HStack(spacing: 130) {
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(width: 150, height: 15)
                                .foregroundColor(.gray)
                                .cornerRadius(7)
                            
                            Rectangle()
                                .frame(width: 25, height: 15)
                                .foregroundColor(.black)
                                .cornerRadius(7)
                        }
                        Button(action: {
                            // Check if a user is signed in
                            if let user = Auth.auth().currentUser {
                                let uid = user.uid
                                
                                viewModelAddress.AddressFunc(forUser: uid) { addressSuccess in
                                    if addressSuccess {
                                        // Update the address in CoreData
                                        viewModel.CoreDataVM2.updateAddressStatus(forUser: uid)
                                        isHomeViewPresented.toggle()
                                    } else {
                                        print("AddressFunc failed")
                                    }
                                }
                            } else {
                                print("No user authenticated")
                            }
                        }) {
                            Image("Arrow")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                        }
                        .fullScreenCover(isPresented: $isHomeViewPresented) {
                            HomeView()
                        }
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height)
                }
                .edgesIgnoringSafeArea(.all)
                .background(Color.white)
            }
        }
    }
}


final class AddressViewModel: ObservableObject {
    @Published var primary = ""
    @Published var city = ""
    @Published var country = ""
    @Published var user = ""
   
   
    
    func AddressFunc(forUser uid: String, completion: @escaping (Bool) -> Void) {
        guard !primary.isEmpty, !city.isEmpty else {
            print("Please fill out all required fields.")
            completion(false)
            return
        }
        
        Task {
            do {
                
                try await DataManager.shared.addAddress1(address: primary, city: city, country: country, id: uid)
                
                print("Success")
                completion(true)
            } catch {
                print("Error: \(error)")
                completion(false)
            }
        }
    }
}

//Core data updating if address section completed

final class CoreDataVM1: ObservableObject {
    private let managedObjectContext: NSManagedObjectContext

    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func updateAddressStatus(forUser uid: String) {
        // Fetch and update the Onboarding entity
        let fetchRequest: NSFetchRequest<Onboarding> = Onboarding.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uniqueIdentifier == %@", uid)

        do {
            let onboardingEntities = try managedObjectContext.fetch(fetchRequest)
            if let onboardingEntity = onboardingEntities.first {
                // Update the attribute
                onboardingEntity.isAddressCompleted = true

                // Save managed object context to persist change
                try managedObjectContext.save()
            }
        } catch {
            print("Error updating Onboarding entity Address: \(error)")
        }
    }
}


final class Onboarding3ViewModel : ObservableObject {
@StateObject var CoreDataVM2 = CoreDataVM1(managedObjectContext: PersistenceController.shared.container.viewContext)
}

 struct Onboarding3_Previews: PreviewProvider {
     static var previews: some View {
         Onboarding3()
     }
 }
