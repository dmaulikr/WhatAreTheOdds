//
//  fileForOdds.swift
//  WhatAreTheOdds
//
//  Created by Noah Bragg on 11/25/14.
//  Copyright (c) 2014 NoahBragg. All rights reserved.
//

import Foundation

public class FileForOdds {
    var someOdds = [String]()
    
    
    private var privateTheirOdds = 1;

    public var theirOdds = 1
    
    //function to get a random number
    public func getRandomNum(num:Int) -> Int {
        return Int(arc4random_uniform(UInt32(num)) + 1)
    }
    
    public func getRandomNumStartingAt0(num:Int) -> Int {
        return Int(arc4random_uniform(UInt32(num)))
    }
    
    public var expectedOdds:Int = 10
    
    //function that gets the difference between the expected odds and what their odds are
    public func getExpectedOddsDifferenceFromTheirOdds(theirOdds:Int) -> Int {
        print("\(theirOdds - self.expectedOdds)  \(theirOdds)  ")
        return theirOdds - self.expectedOdds
    }
    
    //function that gets a random string from the file
    public func getRandomStringForOdds() -> String {
        someOdds = ["jump up and down 10 times and say, I want the twinkie over and over 07",
        "lay on the ground randomly in public 11",
        "take that random guy’s shoe off 10",
        "sing the barney song in public 12",
        "skip instead of walking for 25 minutes 12",
        "tell a random person of the opposite gender you love them 17",
        "wear a my little pony t-shirt for a day, if you don't have a little pony t-shirt, tape a paper with a drawing of a pony 17",
        "act as if you are blind for 10 minutes 11",
        "act as if you only speak Polish for 10 minutes 11",
        "act like you only have one leg for 10 minutes 07",
        "walk backwards for 15 minutes to wherever you’re going 09",
        "laugh in public for 5 minutes straight 11",
        "slurp jello through your nose 14",
        "eat a leaf 07",
        "eat a flower 08",
        "go into the ladies restroom 11",
        "only respond to the name Adolf for a day 14",
        "prank call a random person 15",
        "give your friend a piggyback ride for 10 minutes 08",
        "make farting noises in public and act like they are real 10",
        "stand on top of a table in public and sing Let it go from frozen 18",
        "behave like a random animal when in the presence of your crush 17",
        "drink 2 ounces of pure Tabasco sauce 14",
        "drink 2 ounces of ketchup 14",
        "end every sentence for the next hour with, meow 12",
        "end every sentence for the next hour with ice, ice, baby 08",
        "walk up to a random building and stare at the door with a blank smile 07",
        "hug 10 completely random people 09",
        "lick a random person’s ear lobe 17",
        "Lick your foot 04",
        "eat a spoonful of mayonnaise, if you don't have mayonnaise use another nasty sauce 12",
        "give a random person a wrapped box containing… absolutely nothing 16",
        "find a bug and eat it 12",
        "go to Chipotle 01",
        "fall on the ice, if there is no ice just fall on the ground 12",
        "fall on the ground randomly in public 09",
        "eat the first flower that you see 04",
        "eat warm cottage cheese 20",
        "eat a raw hot dog 09",
        "chug a half gallon of milk 13",
        "act like an elephant and make your arm be the trunk 07",
        "slap a random guy in the face 11",
        "walk up to a random tall guy and say, Ferb! I know what we’re gonna do today! 12",
        "sing Summer from Frozen in the middle of a Public Area during winter 09",
        "pretend that All carpeted surfaces are lava and cannot be touched 05",
        "go up to a random person and try to tell them your lost with out saying a word 11",
        "randomly tackle someone and yell, shots Fired 19",
        "walk with a limp for a day 19",
        "hit yourself in the face 5 times 08",
        "pick your nose and eat it 09",
        "put your nose in a person’s eye socket 14",
        "start eating a random person’s food 18",
        "ask a random person if you can touch their hair 11",
        "ask a random person if you can touch their nose 11",
        "ask a random person if you can touch their eye ball 11",
        "ask a random person if you can touch their elbow 11",
        "ask a random person if you can hug their right leg 12",
        "compliment a random person on their shorts 06",
        "compliment a random girl on her eyelashes 09",
        "compliment a random girl on her toe nails 08",
        "compliment a random person of the opposite gender on their eyebrows 12",
        "compliment a random guy who doesn’t have a mustache saying he has a nice mustache 12",
        "tell a person who doesn’t have blonde hair that you like their blonde hair 12",
        "start playing Duck Duck Goose with a random group sitting around a table 12",
        "ask a random person if they would like to play hide and seek with you 09",
        "tell a ranodm person that its your birthday and ask them if they want to come to your party 14",
        "tell a random person you are lost 09",
        "tell a random person you don’t know what to do with your life and you need help 14",
        "ask a random person to tie your shoe 10",
        "eat some ice cream 01",
        "slide across a frozen pond, Shirtless 17",
        "pretend that everyone else is a Zombie and you are the lone surviving human 12",
        "end every sentence with, eh 09",
        "wear your shirt inside out for a day 12",
        "shout, like! everytime someone says like 08",
        "play dead in public 11",
        "walk up to a random person and act like you are best friends 09",
        "walk up to a random person and say, Hey! do you remember me? we went to junior high together 11",
        "ding dong ditch the nearest house 14",
        "tell someone who is drinking whole milk, do you drink 1 percent because your fat? Because you could drink whole if you wanted to 13",
        "wear flip flops if it is winter or wear snow boots if it is summer 18",
        "walk down a staircase on your hands 21",
        "hide behind a bush and scare the next person that walks by 17",
        "ask a random girl for her number 13",
        "ask a random girl if you can borrow her cell phone and then call her dad instead and ask him if you can go on a date with her daughter 18",
        "sing Michael Jackson’s, what’s Love got to do with it? every time someone says they Love something 11",
        "pick a random person and pretend to be their Secret Service agent for the Day 12",
        "eat food and then spit it on the ground 06",
        "take a selfie with 5 complete strangers 12",
        "talk like Sean Connery for 10 minutes 09",
        "crawl underneath a crowded table saying, Jinkies, I lost my Glasses 08",
        "walk on your knees for 10 minutes 09",
        "sleep on the ground for a night 19",
        "eat your food without using your hands 15",
        "throw your iphone down a flight of stairs 23",
        "breakdown into a hissy fit on the spot 18",
        "do 10 push ups wherever you are 03",
        "hold your breathe for a minute 07",
        "eskimo kiss a stranger 16",
        "hug a grandma 15",
        "put a sticker on your tongue 04",
        "pick your bellybutton in public 07",
        "spasm out on the floor 07",
        "stretch in a grocery store 02",
        "drule for a minute in front of someone you don’t know 11",
        "eat five doughnuts 02",
        "hug a random person 06",
        "ask a random person if they have a boyfriend 12",
        "ask a random person if they have a girlfriend 12",
        "ask a girl if you can help her carry something 09",
        "make snow angels in the grass 05",
        "wear a sign on your back that says, kick me 09",
        "carry around a sign that says, free hugs 11",
        "wear your shirt for a day with a hanger still in the back 07",
        "tape on a fake, paper mustache for an hour 07",
        "go stand in the corner and think about what you did 09",
        "go to a corner and stand with your head pointed towards it for 5 minutes 07",
        "talk in third person for an hour 08",
        "juggle in front of a group of people even if you can't 11",
        "eat a raw egg 07",
        "throw dollars bills into the air 08",
        "jump into a pool when it is cold outside 13",
        "be someone’s stool for 5 minutes 08",
        "gargle salt water for a minute 06",
        "do the cinnamon challenge 11",
        "put make up on your face even if you are a guy 15",
        "stay awake for 48 hours 24",
        "do the worm in public 13",
        "act like you have a spider on your face 13",
        "raise your hand for 10 minutes straight 09",
        "eat a box of oreos in 5 minutes 09",
        "yell as loud as you can in public 06",
        "spray silly string all over yourself 08",
        "walk up to someone and whisper in their ear, he’s coming for you 11",
        "dress like a rapper for the day 12",
        "wear a dress 17",
        "put glitter in your friends shampoo bottle and mix it up. Be prepared to pay 13",
        "rub a stranger’s belly 19",
        "touch a strangers head 09",
        "poor water on the front of your pants 11",
        "eat a hot pepper 09",
        "put ice down the back of your shirt 07",
        "put ice down the front of your shirt 07",
        "put lipstick on and keep it on for 10 minutes 13",
        "lick the ground 08",
        "eat a blade of grass 07",
        "spit on your hand and then lick it back up 10",
        "run around in public acting like a dog 10",
        "bark at the next 3 people that walk by you 11",
        "moo like you are a cow in public 11",
        "jump around acting like a kangaroo 13",
        "growl at people that walk by you for 10 minutes 09",
        "tell the next person you see that they are beautiful 12",
        "tell the next person you see that they are your best friend 12",
        "tell someone that santa claus is actually real and that you met him in person 12",
        "tell random people you are santa claus 12",
        "tell random people that you are one of santa claus’s elves 13",
        "act like you are crazy 09",
        "act like you are insane 11",
        "end every sentence with Whooooooooooo! for 5 minutes 08",
        "put melted chocolate in a diaper and eat it in public saying, this is so yummy! 18",
        "throw litter down behind a random person and then ask them why they littered that 17",
        "start randomly dancing in public 15",
        "give a random person a wet willy 14",
        "make a fake fight in public 09",
        "go up to a random person and say, I am your father 11",
        "go up to a random person and say, dad is it you? dad I found you! 13",
        "tell a random person that you are their lost twin and you have been reunited 14",
        "go in front of a random girl and fall down and then say, Do you have a Band-Aid? Because I just scraped my knee falling for you 16",
        "do not smile for the next 10 minutes 07",
        "do not blank the entire time of your next conversation with someone 07",
        "walk around with one eye shut for 10 minutes 06",
        "drink an 8 ounce bottle of water in 10 seconds 07",
        "ask the nearest female to square dance with you 13",
        "wear a pair of high heels even if you are a guy! hahaha 15",
        "hop on one foot and sing happy birthday to me 07",
        "try to break dance on the ground in front of random people 13",
        "ask a random person to take a selfie with you 09",
        "tell a random person that you are super man and here to save them 12",
        "tell a random person that you dreamed about them last night 14",
        "tell a random person that they have nice pupils 08",
        "tell a random person that they look like your mother 12",
        "tell a random person that you can fly 08",
        "act like you are a bird in public soaring through the sky 11",
        "tell someone that it is your birthday 08",
        "act like there is a bug on a random person that you don't know 13",
        "tell a random person happy birthday, even if it is not their birthday 08",
        "tell a random Merry Christmas even if it is not Christmas 11",
        "tell a random person that frog legs are very yummy 08",
        "run through a publlic area yelling, I love frog legs! 13",
        "do a somersault in public 08",
        "clap your hands 10 times in a row 04",
        "clap your hands over your head and say, we, we, we, We got this! 07",
        "tell someone that Jesus loves them 10",
        "sing the spongebob square pants song in public 12",
        "tell random people marry christmas even when its not christmas 13",
        "run around in circles 06",
        "high 5 the next 5 people you see 08",
        "give a random person the death stare 17",
        "dance in public 14",
        "do a cartwheel 05",
        "do a forward roll 04",
        "play air guitar 08",
        "tell a random person that they look like an angel 12",
        "tell a random person that you like their lower lip 20",
        "fall down randomly 13",
        "spin in circles until you fall down from dizziness 16",
        "tell a random person that you can do the splits 16",
        "ask a random person if they think you would look good with your eyebrows shaved off 18",
        "sing your farvorite song out loud 04",
        "ask a random person to sing the barney song with you 07",
        "lick your elbow 04",
        "lick your nose 05",
        "move your head crazily saying, I wave my hair back and forth! 14",
        "ask a random person if they want to play rock paper scissors 09",
        "go up to a random person and smell them 20",
        "ask a random person for a hug 11",
        "do the worm on the ground 12",
        "ask a random person to give you a high five 04",
        "ask a random person to give you a piggy back ride 12",
        "ask a random person if they would like a piggy back ride 09",
        "yell out loud in public, owwwaayyyaaywoeui 11",
        "ask a random person to take a picture of you posing like a bird 11",
        "ask a random person to take a picture of you posing like a ninja 12",
        "go in the middle of lots of people and sing la la la la la lalala la, la la 09"]
        
        println()
        println("there are \(someOdds.count) odds")
        var randomOdds = someOdds[getRandomNumStartingAt0(someOdds.count)]             //get only the string and not the number at the end
        var length = countElements(randomOdds) - 3
        
        var expectedNum:String = ((randomOdds as NSString).substringFromIndex(length + 1))  //get expected odds string
        let convertNum:Int? = expectedNum.toInt()
        if let num = convertNum {
            self.expectedOdds = num                                         //set expected odds
        }
        
        randomOdds = (randomOdds as NSString).substringToIndex(length)
        
        return "What are the odds that you \(randomOdds)?"
    }
}