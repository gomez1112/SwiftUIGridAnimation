import SwiftUI

struct ContentView: View {
    //Sample photo 2
    @State private var photoSet = samplePhotos
    @State private var selectedPhotos: [Photo] = []
    @State private var selectedPhotoId: UUID?
    @Namespace private var photoTransition
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
                        ForEach(photoSet) { photo in
                            Image(photo.name)
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .cornerRadius(3.0)
                                .matchedGeometryEffect(id: photo.id, in: photoTransition)
                                .onTapGesture {
                                    withAnimation {
                                        selectedPhotos.append(photo)
                                        selectedPhotoId = photo.id
                                        if let index = photoSet.firstIndex(where: { $0.id == photo.id}) {
                                            photoSet.remove(at: index)
                                        }
                                    }
                                }
                        }
                    }
                }
                
                ScrollViewReader { scrollProxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: [GridItem(.adaptive(minimum: 100))]) {
                            ForEach(selectedPhotos) { photo in
                                Image(photo.name)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .cornerRadius(3.0)
                                    .id(photo.id)
                                    .matchedGeometryEffect(id: photo.id, in: photoTransition)
                                    .onTapGesture {
                                        withAnimation {
                                            photoSet.append(photo)
                                            if let index = selectedPhotos.firstIndex(where: { $0.id == photo.id}) { selectedPhotos.remove(at: index)}
                                        }
                                    }
                            }
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .onChange(of: selectedPhotoId, perform: { id in
                        guard id != nil else { return }
                        
                        scrollProxy.scrollTo(id)
                    })
                }
            }
            .padding()
            //.animation(.interactiveSpring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5), value: selectedPhotoId)
            .navigationTitle("Photos")
        }
        .navigationViewStyle(.stack)
    }
}
