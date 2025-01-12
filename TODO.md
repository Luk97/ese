# TODO


## Version 0.1

### Assets
- [x] Terrain: Water tile
- [x] Terrain: Grass tile
- [x] Terrain: Forest tile

### World Generation
- [x] Create starter grass tile
	  
### User Interface
- [x] Label: round count
- [x] Button: finish round

### Gameplay
- [x] Use forest tile as preview tile
- [x] Click finish round button to start the preview
- [x] Preview is disabled after placing a tile
- [x] Placed tiles are grass tiles
- [x] Allow tile placement only next to grass tiles

### Camera
- [x] Implement camera zooming
- [x] Implement camera movement


## Version 0.2

### Assets
- [x] Building: Headquarter
- [x] Building: Woodcutter tile (placed on forest tile)
- [x] Resource: Wood
- [x] Tool: Axe to destroy forest and make it grass
- [x] UI: Label background
- [x] UI: Button background
- [x] UI: Action selection background
- [x] Tile: Decoration Variants for forest tile (other trees etc.)
- [x] Tile: Decoration Variants for grass tile (flowers etc.)
- [x] Building: Animate Headquarter
- [x] Building: Animate Wood Cutter

### World Generation
- [x] Prototype the procedural world generation
- [x] Add forest biome

### User Interface
- [x] Create theme structure for user interface controles	//Need to discuss about wishes about font and other things for all parts of the UI!
- [x] Label: Wood count				//Prototype Scene for all Lables is created, but needs testing!
- [X] Enhance Finish Round Button	//Just needs a makeover
- [X] Enhance Round Counter Label	//Will be adjusted according to the lable adjustment! Should have the same Style at the beginning

### Gameplay
- [x] Place starter tile on grass tile
- [x] Start of round: Get choice between 3 actions out of the tile pool
- [x] Use chosen tile as preview tile
- [x] Woodcutter produces 1 wood every round
- [x] Resource can be collected per mouse click

## Version 0.3

### Assets
- [x] UI: Pixel font
- [x] Terrain: Water Decoration
- [x] UI: Background for Building info
- [x] Building: Charcoal Burner
- [x] Building: Farm
- [x] Building: Field (wheat)
- [x] Building: Windmill
- [x] Icon: Wheat
- [x] Building: Outpost
- [x] Icon: Bomb (used to destroy buildings)
- [x] Icon: Firewood
- [x] Icon: Fish
- [x] Icon: Flour
- [x] Icon: Bread
- [ ] Building: Bakery
- [x] Building: Fisherboat (placed on water)
- [x] (!) Building: Harbour (only then you get fisherboats, built on coast tile)
- [x] Building: Buoy

### Gameplay
- [x] Buildings cost resources
- [x] Sharp Interfaces for Tiles
- [ ] Buildup fire wood production chain
- [ ] Buildup Food produdction chain
- [x] Action Selection Card
- [ ] Lookup Fog implementation

### User Interface
- [X] Basic Main Menu
	- [X] New Game Button
	- [X] Quit Game Button
	- [X] Credits Button

## Version 0.4

### Assets
- [x] (!) Fix Godot Atlas Error messages 	=> 	Müssten behoben werden, wenn man im finalen Produkt, alles in einen Atlas merged
- [x] Check why outpost.png doesn't work in tileset
- [x] Terrain: Sand
- [x] Terrain: Mountain (stone)

- [x] UI Background for Food and Warmth Bar #Ergaenzung von Tobias für die UI
- [x] UI Bar for Food and Warmth Bar #Ergaenzung von Tobias für die UI
- [x] (!) UI: Pixel font #Ergaenzung von Tobias für die UI 	=> 	Arbeit für die kommende Woche
	- [x] Numbers and basic special character
	- [x] Rework the "S"
	- Anm. 	Ich habe ein paar Testlabels im Hauptmenü eingebaut. 
			Links normal und rechts mit Outline 1px. Dann kannst Du sehen, 
			wie die Schrift in verschiedenen Schriftgrößen zur Geltung kommt.
			Am Spieltitel habe ich ein paar mehr Spielereien eingebaut.
			Der Titel skaliert jetzt im Übrigen mit.
	- Anm. Numbers müssten ein wenig größer sein, damit sie zur Textgröße passen

### Gameplay
- [x] Global Gamestats

### User Interface
- [X] Fix scaling of the ui

- [X] Basic Credits Screen
- [X] Fix Action Selection
		-[X] Autoscaling of Cards(not the content)
		-[X] Restructoring Cards
		-[X] Scaling Card Lables
		-[X] Scaling Card Picture
		-[X] Autopositioning of Text and Picture of the Cards
		-[X] Picture Clickable for action
- [X] Basic Bars for Food and Warmth
- [X] Improve auto-scaling of lables.
- [ ] Subscribing the UI Lables and bars to Managers after variables were added
- [X] Polish MainMenu
- [X] Polish Credits

## Version 0.5

### Assets
- [x] Icon: Stone
- [x] Building: Quarry
- [x] Animate all buildings
- [x] Image: Quarry
- [x] Icon: Food (general)
- [x] Icon: Pork
- [x] Make icons more visible
- [x] Fix bomb size

### Gameplay
- [x] Progress Bars
- [x] Show only possible action cards
- [x] More Actions
- [x] Water Buildings
- [x] Show Case from Main Menu
- [x] Make World more interesting

### User Interface
- [X] Enhance Progress Bar
	- [X] Text with cost of increasement //as tooltip
 	- [X] Icon to identify the needed resource 
- [X] Game Over Screen
	- [X] Navigation to Main Menu
	- [X] Navigation to New Game //How is a new Game started, do i just need to open the scene?
	- [X] Autoscaling adding
- [X] Clean up Main Menu
- [X] new Screenshot for Background
- [X] add showcase Function to Interface
- [X] Fix Action Selection
	- [X]Centering (e.g. Fullscreen) #Das Offset erzeugt aktuell das Problem! Ohne Offset sieht es aber nicht gut aus! ActionManager
- [ ] opt. Text on Progressbars?
	- [ ]Just needs autoscale //Needs a % symbol in the font!
- [ ] opt. improving Autoscaling 
- [ ] opt. UI Improvements:
	-TODO: Scaling of top container by length to avoid overlapping
	-TODO: Scaling font with text inside of the labels to fit large numbers
###All
- [ ] Spieltitel?
	- Ideas:
		- Some Synonym to settlers/pioneers
		- Something with pixel?
- [ ] Bug Fixing!
	- [ ] Quarry hat falsche Icon auf ActionSelectionCard
	- [ ] RoundCounter wird nicht runtergesetzt wenn man in der gleichen Instanz das Spiel via menu schliesst und ein neues startet
	- [ ] Difficulty raise by building Homes? 
		- A Home builded-> Costs for progressbars increase
		- Building a home necessary every few rounds
	- [ ] Action Selection can be rerolled by clicking next round again
		- Disabeling next round while cards are shown?
