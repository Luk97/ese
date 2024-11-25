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
- [ ] UI: Action selection background
- [x] Tile: Decoration Variants for forest tile (other trees etc.)
- [x] Tile: Decoration Variants for grass tile (flowers etc.)
- [x] Building: Animate Headquarter
- [x] Building: Animate Wood Cutter

### World Generation
- [x] Prototype the procedural world generation
- [x] Add forest biome

### User Interface
- [ ] Create theme structure for user interface controles	//Need to discuss about wishes about font and other things for all parts of the UI!
- [ ] Label: Wood count				//Prototype Scene for all Lables is created, but needs testing!
- [ ] Enhance Finish Round Button	//Just needs a makeover
- [ ] Enhance Round Counter Button	//Will be adjusted according to the lable adjustment! Should have the same Style at the beginning


### Gameplay
- [x] Place starter tile on grass tile
- [x] Start of round: Get choice between 3 actions out of the tile pool
- [x] Use chosen tile as preview tile
- [x] Woodcutter produces 1 wood every round
- [x] Resource can be collected per mouse click

## Version 0.3

### Assets
- [ ] (!) UI: Pixel font
- [x] Terrain: Water Decoration
- [x] UI: Background for Building info
- [x] Building: Charcoal Burner
- [x] Building: Farm
- [ ] (!) Building: Field (wheat)
- [ ] (!) Building: Windmill
- [x] Icon: Wheat
- [x] Building: Outpost
- [x] Icon: Bomb (used to destroy buildings)
- [ ] Icon: Firewood
- [ ] Icon: Fish
- [ ] Icon: Flour
- [ ] Icon: Bread
- [ ] Building: Bakery
- [ ] Building: Fisherboat (placed on water)
- [ ] Building: Harbour (only then you get fisherboats, built on coast tile)
- [ ] Building: Buoy

### Gameplay
- [ ] Buildings cost resources
- [x] Sharp Interfaces for Tiles
- [ ] Buildup fire wood production chain
- [ ] Buildup Food produdction chain
- [x] Action Selection Card
- [ ] Lookup Fog implementation

### User Interface
- [X] Basic Main Menu			//Implemented
	- [X] New Game Button		//Implemented, works
	- [X] Quit Game Button		//Implemented, works
	- [X] Credits Button		//Implemented, doesn´t word
								//Idea for the future: Load Save?
