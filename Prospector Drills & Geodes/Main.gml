#define Main

//drills produce ores by consuming bottled oil, 10 resources per 1 oil

AddText() //Text.gml, handles adding text to localization file
GetAudioIDs() //Audio.gml, gets audio for geode

// Adding sprite for drill, original is 37w x 45h, animation has 12 frames
//filename, frame_count, remove_back, smooth, x_original, y_original
spr_geode = sprite_add("geode.png", 1, false, false, 8, 8); //16x16
spr_geode_crusher = sprite_add("geode_crusher.png", 1, false, false, 13, 21); //26x41
sprite_collision_mask(spr_geode_crusher, false, 2, 1, 5, 26, 41, 1, 0);

spr_mining_drill = sprite_add("drill_anim.png", 12, false, false, 18, 23); //37x45
sprite_collision_mask(spr_mining_drill, false, 2, 1, 10, 37, 45, 1, 0);
//sprite_collision_mask(ind, sepmasks, bboxmode, bbleft, bbtop, bbright, bbbottom, kind, tolerance);

global.rocks = [objRock, objVolcanoRock, objObsidianRock, objVoidstoneRock, objDesertRock];
global.gems = [Item.Emerald, Item.Topaz, Item.Amethyst, Item.Ruby];
global.minerals = [Item.Sand, Item.Stone, Item.Coal, Item.Crystal, Item.Obsidian];
global.artifacts = [Item.Fossil, Item.Sphynx, Item.FrozenRelic, Item.DinoEgg, Item.Kapala];

global.geode = CreateGeode();

global.geode_crusher = CreateGeodeCrusher();

global.drill_items = [Item.IronOre, Item.GoldOre, Item.Stone, Item.CoalAlt, Item.Sand, global.geode];
crafting_speed = [60*15, 60*20, 60*5, 60*10, 60*10, 60*60];
//index aligned with drill_items, 60frames/sec * sec = seconds of crafting time

global.mining_drill = CreateDrill();

//acquire indices after game assigns them
global.drill_index = StructureGet(global.mining_drill, StructureData.Object);
global.drill_count = 0;
global.drill_unlocked = false;

global.crusher_index = StructureGet(global.geode_crusher, StructureData.Object);
global.crusher_count = 0;
global.crusher_unlocked = false;

for (var i = 0; i < array_length(global.drill_items); i += 1) {
    _drill_item = global.drill_items[i];
    ItemEdit(_drill_item, ItemData.Blueprint, [Item.BottledOil, 0.1]); //LMAO SO EASY, originally I had a complex system that would dispense oil 9/10 times
    ItemEdit(_drill_item, ItemData.CraftingTime, array_get(crafting_speed, i));
}

///                         ///
/// BEGIN FORAGER FUNCTIONS ///
///                         ///

#define OnResourceSpawn(inst)
global.rock_ids = GetRockIds(); //Geode.gml, gathers list of rock-type instances for comparison

#define OnSystemStep()
if(global.drill_unlocked == false) {    
    if(HasSkill(Skill.Drilling)) {
        StructureEdit(global.mining_drill, StructureData.Unlocked, true);
        global.drill_unlocked = true;
    }
} else {
    UpdateBlueprint(global.mining_drill);
}
if(global.crusher_unlocked == false) {
    if(HasSkill(Skill.Machinery)) {
        StructureEdit(global.geode_crusher, StructureData.Unlocked, true);
        global.crusher_unlocked = true;
    }
} else {
    UpdateBlueprint(global.geode_crusher);
}

#define OnResourceDestroy(inst)
if(HasSkill(Skill.Geology)){
    chance = irandom(3) == 0 // 1/4
    if(HasSkill(Skill.Prospecting)){
        chance = irandom(2) == 0 // 1/3 roughly 9% higher chance
    }
    for(i=0;i<array_length(global.rock_ids);i++){
        if(inst == global.rock_ids[i]){
            DropItem(x,y,global.geode,chance);
        }
    }
}

#define OnStructureSpawn(inst, structure)
if (structure == global.geode_crusher){
    antiCull = true;
    global.crusher_count += 1;
    inst.frame_count = 0;
    InstanceAssignMethod(inst, "step", ScriptWrap(GeodeCrusherScript), true) //assign script to instance of structure
}
if (structure == global.mining_drill) {
    antiCull = true;
    global.drill_count += 1;
}

///                        ///
/// BEGIN CUSTOM FUNCTIONS ///
///                        ///

#define CreateDrill()
// Creating the Mining Drill structure
return StructureCreate(
    undefined, //index
    "mining drill", //name
    "uses bottled oil to mine for resources automatically.", //description
    StructureType.Base, //type
    spr_mining_drill, //sprite
    undefined, //object
    [Item.Steel, 5, Item.RoyalSteel, 1, Item.Electronics, 1, Item.BottledOil, 2], //blueprint
    3, //size
    true, //producer
    global.drill_items,//items
    false, //unlocked
    BuildMenuCategory.Industrial, //build menu category
    undefined //gear categories
);

#define UpdateBlueprint(structure)
//updates structure blueprint scaling based on number of structure
if(structure == global.mining_drill){
    struct_count = global.drill_count;
}
if(structure == global.geode_crusher){
    struct_count = global.crusher_count;
}
var multi = int64(1 + struct_count*0.2); // 20% of structure count for scaling
StructureEdit(structure, StructureData.Scaling, multi);
