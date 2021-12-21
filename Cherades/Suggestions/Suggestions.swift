//
//  Suggestions.swift
//  Cherades
//
//  Created by Dave Bage on 11/12/2021.
//

import Foundation
import SwiftUI

enum SuggestionType {
    case movie
    case book
    case theatre
    case none
    
    func icon() -> Image {
        switch self {
        case .movie:
            return Image(systemName: "video.fill")
        case .book:
            return Image(systemName: "book.fill")
        case .theatre:
            return Image.theatreMasks
        case .none:
            return Image(systemName: "questionmark.circle")
        }
    }
}

enum AgeType {
    case kid
    case adult
}

struct Suggestion {
    let name: String
    let type: SuggestionType
    let ageType: AgeType
    var alreadySuggested = false
    let id = UUID()
}

class Suggestions {
    var kidsMoviesList = [Suggestion]()
    var adultsMoviesList = [Suggestion]()
    var books = [Suggestion]()
    var shows = [Suggestion]()
    
    static let shared = Suggestions()
        
    let kidsMoviesStrings = [
        "The Lion King",
        "Frozen II",
        "Frozen",
        "Incredibles 2",
        "Minions",
        "Toy Story 4",
        "Toy Story 3",
        "Despicable Me 3",
        "Finding Dory",
        "Zootopia",
        "The Lion King",
        "Despicable Me 2",
        "Finding Nemo",
        "Shrek 2",
        "Ice Age: Dawn of the Dinosaurs",
        "The Secret Life of Pets",
        "Inside Out",
        "Shrek the Third",
        "Coco",
        "Shrek Forever After",
        "Madagascar 3: Europe's Most Wanted",
        "Monsters University",
        "Kung Fu Panda 2",
        "Ice Age: The Meltdown",
        "Moana",
        "Sing",
        "Kung Fu Panda",
        "The Incredibles",
        "Ratatouille",
        "Madagascar: Escape 2 Africa",
        "Tangled",
        "Night at the Museum",
        "The Croods",
        "The Smurfs",
        "Monsters, Inc.",
        "Cars 2",
        "Madagascar",
        "Puss in Boots",
        "Brave",
        "Despicable Me",
        "Ralph Breaks The Internet",
        "The Boss Baby",
        "Hotel Transylvania 3: Summer Vacation",
        "How to Train Your Dragon: The Hidden World",
        "Kung Fu Panda 3",
        "Dr. Seuss’ The Grinch",
        "Toy Story 2",
        "Wreck-It Ralph",
        "Rio 2",
        "Shrek",
        "Rio",
        "Charlie and the Chocolate Factory",
        "Hotel Transylvania 2",
        "The Lego Movie",
        "Cars",
        "The Secret Life of Pets 2",
        "Alvin and the Chipmunks: The Squeakquel",
        "Pokémon: Detective Pikachu",
        "Ice Age: Collision Course",
        "Ice Age",
        "Home",
        "Happy Feet",
        "Cars 3",
        "Monsters vs. Aliens",
        "Hotel Transylvania",
        "Shark Tale",
        "Penguins of Madagascar",
        "Toy Story",
        "Alvin and the Chipmunks",
        "Dinosaur",
        "Dumbo",
        "The Angry Birds Movie",
        "Dr. Seuss’ The Lorax",
        "Alvin and the Chipmunks: Chipwrecked",
        "Mary Poppins Returns",
        "The Smurfs 2",
        "Peter Rabbit",
        "How the Grinch Stole Christmas",
        "Over the Hedge",
        "Trolls",
        "The Good Dinosaur",
        "Bolt",
        "Megamind",
        "The Polar Express",
        "The SpongeBob Movie: Sponge Out of Water",
        "The Lego Batman Movie",
        "Chicken Little",
        "Rise of the Guardians",
        "Sonic The Hedgehog",
        "101 Dalmatians",
        "Hook",
        "Stuart Little",
        "Doctor Dolittle",
        "G-Force",
        "Ferdinand",
        "Bee Movie",
        "Turbo",
        "Scooby-Doo",
        "Cloudy with a Chance of Meatballs 2",
        "The Nutty Professor",
        "The Princess and the Frog",
        "Mr. Peabody & Sherman",
        "Bambi",
        "Epic",
        "Robots",
        "Paddington",
        "Brother Bear",
        "Space Jam",
        "The Peanuts Movie",
        "Alvin and the Chipmunks: The Road Chip",
        "Lilo & Stitch",
        "Rango",
        "Jiang Ziya",
        "Disney Planes",
        "Hauru no ugoku shiro",
        "Cloudy with a Chance of Meatballs",
        "Chicken Run",
        "Elf",
        "The Little Mermaid",
        "The Emoji Movie",
        "The Croods: A New Age",
        "Smallfoot",
        "Lemony Snicket's A Series of Unfortunate Events",
        "Gake no ue no Ponyo",
        "Yogi Bear",
        "The Addams Family",
        "The BFG",
        "Christopher Robin",
        "Spy Kids",
        "Wallace & Gromit: The Curse of the Were-Rabbit",
        "Smurfs: The Lost Village",
        "Paddington 2",
        "Open Season",
        "The Santa Clause",
        "The LEGO Movie 2: The Second Part",
        "Mr. Poppers's Penguins",
        "Abominable",
        "Hop",
        "Atlantis: The Lost Empire",
        "Snow White and the Seven Dwarfs",
        "Storks",
        "Scooby-Doo 2: Monsters Unleashed",
        "Flushed Away",
        "Flubber",
        "Dr. Dolittle 2",
        "George Of The Jungle",
        "The Santa Clause 2",
        "The Emperor's New Groove",
        "Spy Kids 3-D: Game Over",
        "Xi you ji zhi da sheng gui lai",
        "Stuart Little 2",
        "Spies in Disguise",
        "Pokemon: The First Movie",
        "The Muppets",
        "Happy Feet Two",
        "Planes: Fire and Rescue",
        "The Haunted Mansion",
        "Peter Rabbit 2: The Runaway",
        "Antz",
        "The Angry Birds Movie 2",
        "Kari gurashi no Arietti",
        "Arthur Christmas",
        "Garfield: A Tail of Two Kitties",
        "Stand By Me Doraemon",
        "Surf’s Up",
        "Herbie: Fully Loaded",
        "Space Jam: A New Legacy",
        "Charlotte\'s Web",
        "Power Rangers",
        "SpongeBob SquarePants: The Movie",
        "The Jungle Book",
        "Monster House",
        "The Rugrats Movie",
        "Legend of the Guardians: The Owls of Ga'Hoole",
        "Pete’s Dragon",
        "The Pirates! Band of Misfits",
        "Pokemon 2000",
        "Dr. Seuss’ The Cat in the Hat",
        "Onward",
        "The Boss Baby: Family Business",
        "Tom and Jerry",
        "Jingle All the Way",
        "Captain Underpants: The First Epic Movie",
        "Coraline",
        "Walking with Dinosaurs",
        "The Lego Ninjago Movie",
        "The Nut Job",
        "Hotel for Dogs",
        "Dora and the Lost City of Gold",
        "Encanto",
        "Spy Kids 2: The Island of Lost Dreams",
        "Soul",
        "Barnyard: The Original Party Animals",
        "Snow Dogs",
        "Wonder Park",
        "Cats & Dogs: The Revenge of Kitty Galore",
        "Boonie Bears: Blast Into The Past",
        "The Boxtrolls",
        "Free Birds",
        "The Addams Family 2",
    ]
    
    let adultsMoviesStrings = [
        "Avatar",
        "Avengers: Endgame",
        "Avengers: Infinity War",
        "Jurassic World",
        "Furious 7",
        "The Avengers",
        "Avengers: Age of Ultron",
        "Black Panther",
        "Jurassic World: Fallen Kingdom",
        "The Fate of the Furious",
        "Iron Man 3",
        "Captain America: Civil War",
        "Aquaman",
        "Spider-Man: Far From Home",
        "Captain Marvel",
        "Transformers: Dark of the Moon",
        "Skyfall",
        "Transformers: Age of Extinction",
        "The Dark Knight Rises",
        "The Dark Knight",
        "Chang jin hu",
        "Spider-Man: Homecoming",
        "Spectre",
        "Batman v Superman: Dawn of Justice",
        "Guardians of the Galaxy Vol 2",
        "Venom",
        "Thor: Ragnarok",
        "Transformers: Revenge of the Fallen",
        "Zhan Lang 2",
        "Wonder Woman",
        "Fast and Furious 6",
        "Mission: Impossible—Fallout",
        "Deadpool 2",
        "Deadpool",
        "No Time to Die",
        "Guardians of the Galaxy",
        "Fast & Furious Presents: Hobbs & Shaw",
        "2012",
        "X-Men: Days of Future Past",
        "Suicide Squad",
        "The Matrix Reloaded",
        "Liu Lang Di Qiu",
        "F9: The Fast Saga",
        "Captain America: The Winter Soldier",
        "The Amazing Spider-Man 2",
        "Transformers",
        "Tang Ren Jie Tan An 3",
        "Mission: Impossible—Ghost Protocol",
        "Mission: Impossible—Rogue Nation",
        "Doctor Strange",
        "Man of Steel",
        "Justice League",
        "Thor: The Dark World",
        "Fast Five",
        "Hancock",
        "Ant-Man and the Wasp",
        "Iron Man 2",
        "The Lost World: Jurassic Park",
        "Logan",
        "War of the Worlds",
        "Transformers: The Last Knight",
        "Casino Royale",
        "Quantum of Solace",
        "Mission: Impossible 2",
        "Tang Ren Jie Tan An 2",
        "X-Men: Apocalypse",
        "Sherlock Holmes: A Game of Shadows",
        "Hong Hai Xing Dong",
        "World War Z",
        "Godzilla",
        "The Meg",
        "Dunkirk",
        "Ant-Man",
        "Terminator 2: Judgment Day",
        "Twister",
        "Venom: Let There be Carnage",
        "Clash of the Titans",
        "War for the Planet of the Apes",
        "Mr. and Mrs. Smith",
        "Troy",
        "Ba bai",
        "Godzilla vs. Kong",
        "The Matrix",
        "X-Men: The Last Stand",
        "Mission: Impossible",
        "Lucy",
        "The Last Samurai",
        "Gladiator",
        "300",
        "Thor",
        "Pearl Harbor",
        "Men in Black 2",
        "Warcraft",
        "Terminator 3: Rise of the Machines",
        "Terminator: Genisys",
        "Die Another Day",
        "Rampage",
        "The Matrix Revolutions",
        "Bad Boys For Life",
        "Shang-Chi and the Legend of the Ten Rings",
    ]
    
    let booksStrings = [
        "Mrs Pepperpot Stories ",
        "A Traveller in Time ",
        "Black Beauty ",
        "The Diary of a Young Girl ",
        "The Little Prince ",
        "The Great Adventures of Sherlock Holmes ",
        "Swallows and Amazons ",
        "A Kestrel for a Knave ",
        "The Tale of Jemima Puddle-Duck ",
        "Grimms' Fairy Tales ",
        "Eragon ",
        "The Lion, the Witch and the Wardrobe ",
        "A Christmas Carol ",
        "The Water Babies ",
        "Stig of the Dump ",
        "Robinson Crusoe ",
        "Elmer ",
        "The Hundred and One Dalmatians ",
        "Five Children and It ",
        "Charlotte's Web ",
        "The Enchanted Castle ",
        "Brown Bear, Brown Bear, What Do You See? ",
        "The Railway Children ",
        "Emil and the Detectives ",
        "The Very Hungry Caterpillar ",
        "The Family from One End Street ",
        "A Little Princess ",
        "The Secret Garden ",
        "Animal Farm ",
        "My Family and Other Animals ",
        "The War of the Worlds ",
        "To Kill A Mockingbird ",
        "The Story of Doctor Dolittle ",
        "The Silver Sword ",
        "Peter Pan ",
        "The Hobbit ",
        "The Illustrated Mum ",
        "Pride and Prejudice ",
        "The Penderwicks ",
        "The Worst Witch ",
        "Heidi ",
        "The Boy in the Striped Pyjamas ",
        "Turtles All The Way Down ",
        "The Spook's Apprentice ",
        "hvz, T",
        "Further Doings of Milly-Molly-Mandy ",
        "The Wind in the Willows ",
        "Twenty Thousand Leagues Under the Sea ",
        "Anne of Green Gables ",
        "Alice's Adventures in Wonderland ",
        "Little Women ",
        "A Wrinkle in Time ",
        "Noughts & Crosses ",
        "The Adventures of Huckleberry Finn ",
        "The Book Thief ",
        "The Complete Borrowers ",
        "Where the Wild Things Are ",
        "Paddington: Please Look After This Bear & Other Stories ",
        "Goodnight Mister Tom ",
        "Ballet Shoes ",
        "The Happy Prince & Other Stories ",
        "The Selfish Giant ",
        "Danny the Champion of the World ",
        "Boy and Going Solo ",
        "Northern Lights ",
        "Tom's Midnight Garden ",
        "Lulu and the Flying Babies ",
        "Zagazoo ",
        "Matilda ",
        "Watership Down ",
        "Percy Jackson and the Lightning Thief ",
        "Charlie and the Chocolate Factory ",
        "Charlotte Sometimes ",
        "George's Marvellous Medicine ",
        "Wonder ",
        "The Twits ",
        "Mrs Frisby and the Rats of NIMH ",
        "The Neverending Story ",
        "Kidnapped ",
        "James and the Giant Peach ",
        "Brother Dusty-Feet ",
        "Just So Stories ",
        "The Eagle of the Ninth ",
        "The BFG for Roald Dahl",
        "Haroun and the Sea of Stories ",
        "The Giving Tree ",
        "My Naughty Little Sister ",
        "What Katy Did ",
        "The Dark Is Rising ",
        "Nation ",
        "A Wizard of Earthsea ",
        "Biggles and Co. ",
        "Lord of the Flies ",
        "The Wee Free Men ",
        "Ladybird Tales: Sleeping Beauty ",
        "The Arabian Nights: Tales of 1,001 Nights translated ",
        "The Wolves of Willoughby Chase ",
        "Moonfleet ",
        "Dogger ",
        "I Capture the Castle "
    ]
    
    let musicalsStrings = [
        "West Side Story",
        "Jesus Christ Superstar",
        "Les Misérables",
        "Tommy",
        "Cabaret",
        "Rent",
        "The Rocky Horror Show",
        "Hamilton",
        "Guys and Dolls",
        "A Chorus Line",
        "Miss Saigon",
        "Annie Get Your Gun",
        "Blood Brothers",
        "Cats",
        "School of Rock"
    ]
    
    init() {
        kidsMoviesStrings.forEach {
            self.kidsMoviesList.append(Suggestion(name: $0, type: .movie, ageType: .kid))
        }
        
        adultsMoviesStrings.forEach {
            self.kidsMoviesList.append(Suggestion(name: $0, type: .movie, ageType: .adult))
        }
        
        booksStrings.forEach {
            self.books.append(Suggestion(name: $0, type: .book, ageType: .kid))
        }
        
        musicalsStrings.forEach {
            self.shows.append(Suggestion(name: $0, type: .theatre, ageType: .kid))
        }
    }
}