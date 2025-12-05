//
//  ViewController.swift
//  Goswami_SearchApp
//
//  Created by Bhavesh on 10/2/25.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
        
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var topicInfoText: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var topic = 0
    var currentImageIndex = 0
    
    let topicImages = [
        ["eiffeltower", "greatwall", "gatewayofindia", "mountrushmore"],
        ["moonlanding", "marsrover", "hubble"],
        ["diwali", "carnival", "oktoberfest"],
        ["tiger", "panda", "eagle"],
        ["lightbulb", "airplane", "computer"]
    ]
    
    let FamousLandmarks_keywords = ["LANDMARK", "ARCHITECTURE", "MONUMENT", "BUILDING", "STRUCTURE", "FAMOUS", "PLACE"]
    let SpaceExploration_keywords = ["SPACE", "ASTRONOMY", "EXPLORATION", "PLANET", "ROCKET", "STAR", "GALAXY"]
    let PopularFestivals_keywords = ["FESTIVAL", "CELEBRATION", "EVENT", "PARTY", "HOLIDAY", "CARNIVAL", "DIWALI"]
    let WildlifeWonders_keywords = ["WILDLIFE", "ANIMAL", "CREATURE", "NATURE", "HABITAT", "BEAST", "WILD"]
    let InventionsInnovations_keywords = ["INNOVATION", "INVENTION", "TECHNOLOGY", "DISCOVERY", "TECH", "GADGET"]
    
    let topics_description = [
        ["The Eiffel Tower is an iron lattice tower located in Paris, France. It was completed in 1889 and stands as one of the most iconic structures in the world, attracting millions of visitors annually.",
         "The Great Wall of China is a historic fortification stretching over 13,000 miles across northern China, built over centuries to protect Chinese states from invasions and raids.",
         "Gateway of India is a magnificent arch monument built in the 20th century in Mumbai, India. Erected to commemorate the visit of King George V and Queen Mary in 1911, it stands as an iconic symbol of Mumbai and Indian heritage.",
         "Mount Rushmore is a massive sculpture carved into granite in the Black Hills of South Dakota, USA, featuring the faces of four U.S. presidents: George Washington, Thomas Jefferson, Theodore Roosevelt, and Abraham Lincoln."],
        
        ["The Moon Landing was achieved by NASA's Apollo 11 mission on July 20, 1969, when Neil Armstrong and Buzz Aldrin became the first humans to set foot on the lunar surface.",
         "Mars Rovers like Curiosity and Perseverance are sophisticated robotic explorers sent to investigate the Red Planet, searching for signs of past or present microbial life and studying Martian geology.",
         "The Hubble Space Telescope, launched in 1990, has provided breathtaking images of distant galaxies, nebulae, and cosmic phenomena, revolutionizing our understanding of the universe."],
        
        ["Diwali, the Festival of Lights, is one of the most important Hindu celebrations. It symbolizes the victory of light over darkness and good over evil, celebrated with oil lamps, fireworks, and sweets.",
         "Carnival is a vibrant celebration featuring elaborate parades, colorful costumes, music, and masquerades. The most famous Carnival celebration takes place in Rio de Janeiro, Brazil, attracting millions.",
         "Oktoberfest is the world's largest beer festival held annually in Munich, Germany. This 16-18 day celebration attracts over 6 million visitors who enjoy traditional Bavarian beer, food, and culture."],
        
        ["Tigers are majestic wild cats and the largest members of the cat family. Known for their power, agility, and distinctive orange coat with black stripes, they are primarily found in Asian forests and grasslands.",
         "Giant Pandas are beloved black-and-white bears native to the mountains of central China. Famous for their bamboo diet and gentle nature, they have become a symbol of wildlife conservation efforts worldwide.",
         "Eagles are powerful birds of prey with exceptional vision, capable of spotting prey from miles away. Known for their hunting skills and soaring flight, eagles symbolize freedom, power, and strength."],
        
        ["The Lightbulb, perfected by Thomas Edison in 1879, revolutionized how humans illuminate their world. This invention extended productive hours beyond daylight and transformed modern civilization.",
         "The Airplane was invented by the Wright Brothers, Orville and Wilbur, who achieved the first powered flight in 1903. This innovation transformed global transportation, commerce, and connected distant parts of the world.",
         "The Computer laid the foundation for the digital age we live in today. From early mechanical calculators to modern digital computers, this invention has enabled unprecedented technological advancement and connectivity."]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func setupInitialView() {
        resultImage.image = UIImage(named: "welcome")
        topicInfoText.text = "Hello, Bhavesh !!"
        searchButton.isEnabled = false
        nextButton.isEnabled = false
        prevButton.isEnabled = false
        topic = 0
        currentImageIndex = 0
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        searchButton.isEnabled = !(textField.text?.isEmpty ?? true)
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        guard let searchText = searchTextField.text?.uppercased(), !searchText.isEmpty else { return }
        
        AudioServicesPlaySystemSound(1113)
        
        if FamousLandmarks_keywords.contains(searchText) {
            topic = 1
        } else if SpaceExploration_keywords.contains(searchText) {
            topic = 2
        } else if PopularFestivals_keywords.contains(searchText) {
            topic = 3
        } else if WildlifeWonders_keywords.contains(searchText) {
            topic = 4
        } else if InventionsInnovations_keywords.contains(searchText) {
            topic = 5
        } else {
            resultImage.image = UIImage(named: "error")
            topicInfoText.text = "No result found for \(searchText)"
            topic = 0
            nextButton.isEnabled = false
            prevButton.isEnabled = false
            return
        }
        
        currentImageIndex = 0
        displayImage()
        nextButton.isEnabled = true
        prevButton.isEnabled = false
    }
    
    func displayImage() {
        if topic > 0 && topic <= topicImages.count {
            let images = topicImages[topic - 1]
            if currentImageIndex < images.count {
                resultImage.image = UIImage(named: images[currentImageIndex])
                topicInfoText.text = topics_description[topic - 1][currentImageIndex]
            }
            updateButtonStates()
        }
    }
    
    @IBAction func ShowNextImageBtn(_ sender: Any) {
        AudioServicesPlaySystemSound(1105)
        if topic > 0 && currentImageIndex < topicImages[topic - 1].count - 1 {
            currentImageIndex += 1
            displayImage()
        }
    }
    
    @IBAction func ShowPrevImageBtn(_ sender: Any) {
        AudioServicesPlaySystemSound(1105)
        if topic > 0 && currentImageIndex > 0 {
            currentImageIndex -= 1
            displayImage()
        }
    }
    
    @IBAction func ResetBtn(_ sender: Any) {
        AudioServicesPlaySystemSound(1111)
        setupInitialView()
        searchTextField.text = ""
    }
    
    func updateButtonStates() {
        if topic > 0 {
            prevButton.isEnabled = currentImageIndex > 0
            nextButton.isEnabled = currentImageIndex < topicImages[topic - 1].count - 1
        }
    }
}
