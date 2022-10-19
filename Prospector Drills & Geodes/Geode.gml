#define CreateGeode()
return ItemCreate(
    undefined,//index
    "Geode",//name
    "mother nature's loot box. crack open to find minerals, gems, and more.",//description
    spr_geode,//sprite
    ItemType.Consumable,//type
    ItemSubType.Scroll,//subtype
    30,//value
    0,//healing
    0,//energy
    [Item.BottledOil, 0.1],//blueprint
    ScriptWrap(GeodeDrop),//onuse !! GeodeDrop
    30,//craftingtime
    true//unlocked
);

#define CreateGeodeCrusher()
return StructureCreate(
    undefined, //index
    "geode crusher", //name
    "auto crushes geodes from your bag and nearby vaults.", //description
    StructureType.Base, //type
    spr_geode_crusher, //sprite
    undefined, //object
    [Item.Steel, 10, Item.Brick, 10], //blueprint
    3, //size
    false, //producer
    undefined,//items
    false, //unlocked
    BuildMenuCategory.Economic, //build menu category
    undefined //gear categories
);

#define GeodeDrop(audio) //valid values: false, minimal
chance = irandom_range(1,100);
count = irandom_range(1,3);
gem = RandArray(global.gems);
mineral = RandArray(global.minerals);
artifact = RandArray(global.artifacts);
if(chance == 100 && irandom_range(1,3) == 1){ // 1/300
    layered_sound = sndID_Secret; //quality based overlay sound
    DropItem(x,y,Item.LegendaryGem,1);
} else if(chance > 98){ // 2%
    layered_sound = sndID_StarfallDestroyed;
    DropItem(x,y,artifact,1);
} else if(chance > 40){ // 58%
    layered_sound = sndID_StarfallHit;
    DropItem(x,y,gem,count);
} else if(chance > 10){ // 30% 
    layered_sound = sndID_RockDestroyed;
    DropItem(x,y,mineral,count);
} else if(chance > 0){ // 10%
    layered_sound = sndID_HitRock;
    DropItem(x,y,Item.Sand,1);
}
if(audio == "minimal"){
    audio_play_sound(sndID_Shovel, 0, false); //minimal is only crush
} else if(audio != false){
    audio_play_sound(sndID_Shovel, 0, false); //base sound
    audio_play_sound(layered_sound, 0, false);
}

#define GeodeCrusherScript()
frame_count += 1;
if(frame_count % 60 == 0) {
    geode_count = ItemCount(global.geode, true);
    if(geode_count > 0){
        RemoveItem(global.geode, 1);
        GeodeDrop("minimal");
        frame_count = 0;
    }
}

#define GetRockIds()
//iterates thgough every rock-type object to gather instance ids
var rock_ids = [];
for (i=0;i < array_length(global.rocks);i++;){
    obj = global.rocks[i];
    for (i2=0;i2 < instance_number(obj);i2++;)
    {
        array_push(rock_ids, instance_find(obj,i2));
    }
}
return rock_ids