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
    
    func checkForNil(item: String?, atReplace: String) -> String?{
        if item == nil || item == ""{
            return atReplace
        }else{
            return item
        }
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
        }
        .navigationBarTitle(Text(self.checkForNil(item: book.title, atReplace: "Unknown Book")!), displayMode: .inline)
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
