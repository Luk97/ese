# TODO


## Version 0.1

### Assets
- [ ] Terrain: Water tile
- [ ] Terrain: Grass tile
- [ ] Terrain: Forest tile

### World Generation
- [x] Create starter grass tile
- [ ] Create chunk system for an infinite world
- [ ] Make all tiles water tiles besides the starter tile
	  
### User Interface
- [x] Label: round count
- [x] Button: finish round

### Gameplay
- [x] Use forest tile as preview tile
- [x] Click finish round button to start the preview
- [x] Preview is disabled after placing a tile
- [x] Placed tiles are grass tiles
- [ ] Allow tile placement only next to grass tiles

### Camera
- [x] Implement camera zooming
- [ ] Implement camera movement


## Version 0.2

### Assets
- [ ] Building: Woodcutter tile (placed on forest tile)
- [ ] Building: Farmer tile (placed on grass tile)
- [ ] Terrain: Field tile
- [ ] Resource: wood
- [ ] Resource: grain

### World Generation
- [ ] Create random islands of grass with size 1 throughout the world

### User Interface
- [ ] Create theme structure for user interface controles
- [ ] Label: Wood count
- [ ] Label: Food count
- [ ] Create main menu
  - [ ] New Game button
  - [ ] Quit Game button

### Gameplay
- [ ] Create tile pool with possible tiles to place
- [ ] Start of round: Get random choice between 3 tiles out of the tile pool
- [ ] Use chosen tile as preview tile
- [ ] Woodcutter produces 1 wood every 2 rounds
- [ ] Farmer produces 0 grain every 3 rounds
- [ ] Farmer produces 1 extra grain per fields as neighbour
- [ ] Resource can be collected per mouse click
