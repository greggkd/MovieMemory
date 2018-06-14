

import Foundation

class CardModel{

    let movieModel = MovieModel()
    
    var dict:[Int:String] = [1:"Title", 2: "Year", 3: "Genre", 4:"Released", 5:"Director", 6:"Writer",
                             7:"Actors", 8:"Plot", 9:"Language", 10:"Country", 11:"Awards", 12:"BoxOffice"]
    
    func getCards(movies: [MovieObj]) -> [Card] {
        
        var generatedNumbersArray = [Int]()
        
        //Declare an array to store the generated cards
        var generatedCardsArray = [Card]()
        
        //Randomly generte pairs of cards
        //for _ in 1...4 {
            
        while generatedNumbersArray.count < 4 {
            //Randomize the array
            let randomNumber = Int(arc4random_uniform(5) + 1)
            if generatedNumbersArray.contains(randomNumber) == false {
                
                //Log generated number
                //print(randomNumber)
                
                generatedNumbersArray.append(randomNumber)
                
                let randomElement = getRandomElement()
                let randomElement2 = getRandomElement()
                
                //Create the first card object
                //TODO: Modify Card Model so we just have a Poster element since we created
                //      movieModel.returnElement
                let cardOne = Card(imageName: "\(randomNumber)", movie: movies[randomNumber], textValue: movieModel.returnElement(movie: movies[randomNumber], ele: randomElement))
                generatedCardsArray.append(cardOne)
                
                //Create the second card object
                let cardTwo = Card(imageName: "\(randomNumber)", movie: movies[randomNumber], textValue: movieModel.returnElement(movie: movies[randomNumber], ele: randomElement2))
                generatedCardsArray.append(cardTwo)
            }
        }
        
        //Randomize array
        for i in 0...generatedCardsArray.count-1{
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
            let temporaryStorage = generatedCardsArray[i]
            generatedCardsArray[i] = generatedCardsArray[randomNumber]
            generatedCardsArray[randomNumber] = temporaryStorage
            
        }
        //Return the array
        return generatedCardsArray
    }
    
    func getRandomElement() -> String {
        //Randomly grab element from MovieObj: Codeable
        //doing 12 options for 13 elements so we don't get the last option 13: Poster
        
        let index: Int = Int(arc4random_uniform(UInt32(dict.count)))
        let randomElement = Array(dict.values)[index] //123 or 234 or 345
        
        return randomElement

    }
    
    //This will be called when the Play Again button is pressed
    func resetFlags(cards: [Card]) -> [Card]  {
        for card in cards {
            card.isFlipped = false
            card.isMatched = false
        }
        
        return cards
    }
    
}


