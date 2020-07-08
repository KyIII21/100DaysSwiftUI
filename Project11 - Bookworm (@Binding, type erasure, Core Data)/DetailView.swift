//
//  DetailView.swift
//  Project11 - Bookworm (@Binding, type erasure, Core Data)
//
//  Created by Дмитрий on 08.07.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailView: View {
    let book: Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    func checkForNil(item: String?, atReplace: String) -> String?{
        if item == nil || item == ""{
            return atReplace
        }else{
            return item
        }
    }
    
    func deleteBook() {
        moc.delete(book)

        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.checkForNil(item: self.book.genre, atReplace: "Fantasy")!)
                        .frame(maxWidth: geometry.size.width)

                    Text(self.checkForNil(item: self.book.genre, atReplace: "Fantasy")!.uppercased())
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                Text(self.checkForNil(item: self.book.author, atReplace: "Unknown author")!)
                    .font(.title)
                    .foregroundColor(.secondary)

                Text(self.checkForNil(item: self.book.review, atReplace: "No review")!)
                    .padding()

                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)

                Spacer()
            }
            .alert(isPresented: self.$showingDeleteAlert) {
                Alert(title: Text("Delete book \(self.book.title ?? "")"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                        self.deleteBook()
                    }, secondaryButton: .cancel()
                )
            }
        }
        .navigationBarTitle(Text(self.checkForNil(item: book.title, atReplace: "Unknown Book")!), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test Title"
        book.author = ""
        book.genre = ""
        book.rating = 4
        book.review = ""

        return NavigationView {
            DetailView(book: book)
        }
    }
}
