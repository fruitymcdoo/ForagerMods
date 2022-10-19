#define DrillDrop
// If anyone else found a way to look at this code, welcome!
// Feel free to look around or change anything as you see fit! :)

var coal_multi = 1;
var iron_multi = 1;
var gold_multi = 1;
var luck = irandom_range(0, 100);
var luck_2 = irandom_range(0, 100);
var luck_3 = irandom_range(0, 100);
lhEffectCalc = LighthouseCalculate(x, y);

if (luck <= 30) { // 30%
    if(GetBiome(x,y) == Biome.Desert) {
        DrillItem(x, y, Item.Sand, round(irandom_range(3, 10) * lhEffectCalc));
    } else {
        DrillItem(x, y, Item.Sand, round(irandom_range(1, 3) * lhEffectCalc));
    }
} else if (luck > 30 && luck <= 92) { // 62%
    chooseBasicResource();
} else if (luck > 92 && luck <= 98) { // 6%
    chooseRareResource();
} else { // 2%
    chooseArcheologyItem();
}

// Drops stone regardless of luck roll. 
DrillItem(x, y, Item.Stone, round(irandom_range(1, 5) * lhEffectCalc));

// Drops coal regardless of luck roll
DrillItem(x, y, Item.Coal, round(irandom_range(1, 5) * lhEffectCalc));

#define DrillItem(x, y, item, count)
if(HasSkill(Skill.Automation) ) {
    GainItem(item, count);
} else {
    DropItem(x, y, item, count);
}

#define chooseBasicResource
// Gets the biome of current drill and chooses appropriate resources.
var drillBiome = GetBiome(x, y);
var resourceChoice = irandom_range(1, 10);

/*
    IF IN FIRE BIOME:
    
    BONUSES:
        More coal drops and drop chance.
*/
if(drillBiome == Biome.Volcano) {
    /*
        (5 - 10) Coal = 50%
        (2 - 4) Iron Ore = 20%
        (2 - 4) Gold Ore = 30%
    */
    
    if(resourceChoice <= 5) { // 50%
        DrillItem(x, y, Item.Coal, round(irandom_range(1, 5) * lhEffectCalc));
    } else if (resourceChoice > 5 && resourceChoice <= 7) { // 20%
        DrillItem(x, y, Item.IronOre, round(irandom_range(1, 5) * lhEffectCalc));
    } else if (resourceChoice > 7 && resourceChoice <= 10) { // 30%
        DrillItem(x, y, Item.GoldOre, round(irandom_range(1, 3) * lhEffectCalc));
    } 

/*
    IF IN SNOW BIOME
    
    BONUSES:
        None, most balanced biome.
*/
} else if (drillBiome == Biome.Snow) {
    /*
        (2 - 4) Coal = 40%
        (3 - 6) Iron Ore = 30%
        (3 - 6) Gold Ore = 30%
    */
    
    if(resourceChoice <= 4) { // 40%
        DrillItem(x, y, Item.Coal, round(irandom_range(1, 5) * lhEffectCalc));
    } else if (resourceChoice > 4 && resourceChoice <= 7) { // 30%
        DrillItem(x, y, Item.IronOre, round(irandom_range(1, 5) * lhEffectCalc));
    } else { // 30%
        DrillItem(x, y, Item.GoldOre, round(irandom_range(1, 3) * lhEffectCalc));
    } 

/*
    IF IN DESERT BIOME
    
    BONUSES:
        More gold and iron ore drops and higher drop chance.
*/
} else if (drillBiome == Biome.Desert) {
    /*
        (3 - 10) Gold Ore = 40%
        (3 - 10) Iron Ore = 40%
        (2 - 4) Coal = 20%
    */
    
    if(resourceChoice <= 4) { // 40%
        DrillItem(x, y, Item.GoldOre, round(irandom_range(1, 3) * lhEffectCalc));
    } else if (resourceChoice > 4 && resourceChoice <= 8) { // 40%
        DrillItem(x, y, Item.IronOre, round(irandom_range(1, 5) * lhEffectCalc));
    } else { // 20%
        DrillItem(x, y, Item.Coal, round(irandom_range(1, 5) * lhEffectCalc));
    }
    
/*
    IF IN GRASS BIOME
    
    BONUSES:
        More gold and iron ore drops and drop chance.
        Chance to drop poop.
*/
} else if (drillBiome == Biome.Grass){
    /*
        (4 - 8) Gold Ore = 40%
        (4 - 8) Iron Ore = 40%
        (2 - 4) Coal = 10%
        (3 - 5) Poop = 10%
    */
    if(resourceChoice <= 2) { // 40%
        DrillItem(x, y, Item.GoldOre, round(irandom_range(1, 3) * lhEffectCalc));
    } else if (resourceChoice > 2 && resourceChoice <= 5) { // 40%
        DrillItem(x, y, Item.IronOre, round(irandom_range(1, 5) * lhEffectCalc));
    } else if (resourceChoice > 6 && resourceChoice <= 9){ // 10%
        DrillItem(x, y, Item.Coal, round(irandom_range(1, 5) * lhEffectCalc));
    } else { // 10%
        DrillItem(x, y, Item.Poop, round(irandom_range(1, 10) * lhEffectCalc));
    }
/*
    IF IN GRAVEYARD BIOME
        
    BONUSES:
        More gold ore drops and higher drop chance.
        Chance to drop bone.
        
*/
} else if (drillBiome == Biome.Graveyard){
    /*
        (5 - 8) Gold Ore = 40%
        (2 - 4) Iron Ore = 30%
        (1 - 3) Coal = 20%
        (4 - 10) Bone = 10%
    */
    if(resourceChoice <= 4) { // 40%
        DrillItem(x, y, Item.GoldOre, round(irandom_range(1, 10) * lhEffectCalc));
    } else if (resourceChoice > 4 && resourceChoice <= 7) { // 30%
        DrillItem(x, y, Item.IronOre, round(irandom_range(1, 5) * lhEffectCalc));
    } else if (resourceChoice > 7 && resourceChoice <= 9){ // 20%
        DrillItem(x, y, Item.Coal, round(irandom_range(1, 5) * lhEffectCalc));
    } else { // 10%
        DrillItem(x, y, Item.Bone, round(irandom_range(1, 10) * lhEffectCalc));
    }
}

#define chooseRareResource
var drillBiome = GetBiome(x, y);
var gemList = [Item.Ruby, Item.Emerald, Item.Topaz, Item.Amethyst];
var chooseGem = irandom_range(0, array_length_1d(gemList) - 1);

/*
    BIOME SPECIFIC DROPS
    Fire Biome: Obsidian (1 - 3)
    Snow Biome: Crystal (1 - 3)
    Graveyard Biome: Great Skull (1 - 3)
    Grass & Desert Biome: Random Gem (1 - 5)
*/

// Choose biome specific rare items, if no biome specific item can be chosen then choose random gem.
if (drillBiome == Biome.Volcano) {
    DrillItem(x, y, Item.Obsidian, round(irandom_range(1, 5) * lhEffectCalc));
} else if (drillBiome == Biome.Snow) {
    DrillItem(x, y, Item.Crystal, round(irandom_range(1, 5) * lhEffectCalc));
} else if (drillBiome == Biome.Graveyard) {
    DrillItem(x, y, Item.GreatSkull, round(irandom_range(1, 3) * lhEffectCalc));
} else {
    DrillItem(x, y, gemList[chooseGem], round(irandom_range(1, 5) * lhEffectCalc));
}

#define chooseArcheologyItem
var drillBiome = GetBiome(x, y);

/*
    BIOME SPECIFIC DROPS
    Fire Biome: 1 Dino Egg
    Snow Biome: 1 Frozen Relic
    Graveyard Biome: 1 Kapala
    Grass Biome: 1 Fossil
    Desert Biome: 1 Sphynx
*/

// Choose biome specific archeology item. Else give legendary gem (I don't think that would ever trigger but just in case it does.)
if (drillBiome == Biome.Volcano) {
    DrillItem(x, y, Item.DinoEgg, round(1 * lhEffectCalc));
} else if (drillBiome == Biome.Snow) {
    DrillItem(x, y, Item.FrozenRelic, round(1 * lhEffectCalc));
} else if (drillBiome == Biome.Graveyard) {
    DrillItem(x, y, Item.Kapala, round(1 * lhEffectCalc));
} else if (drillBiome == Biome.Grass){
    DrillItem(x, y, Item.Fossil, round(1 * lhEffectCalc));
} else if (drillBiome == Biome.Desert){
    DrillItem(x, y, Item.Sphynx, round(1 * lhEffectCalc));
} else {
    DrillItem(x, y, Item.LegendaryGem, round(1 * lhEffectCalc));
}



