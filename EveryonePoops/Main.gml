#define PoopDrop(interval)
chance = irandom(100);
if (chance % interval == 0){ // 1/interval
    DropItem(x,y,Item.Poop,1);
}

#define OnItemUse(item)
func_index = asset_get_index("UseConsume");
item_func = ItemGet(item, ItemData.OnUse);
if(func_index == item_func) {
    if(UseConsume(item)) {
        RemoveItem(item,1)
        PoopDrop(3) // 1/3
    }
}

#define OnMobDeath(inst)
enemy_name = EnemyGet(inst, EnemyData.Name)
if (string_count("skeleton", string_lower(enemy_name)) == 0){
    PoopDrop(10) // 1/10
}

#define OnPlayerDamage(dodge, damage)
if(dodge == false){
    Trace(damage);
    //want to make the player poop when taking large damage, so need to test that
}

//TODO potentially add 1/100 chance to poop when getting hurt