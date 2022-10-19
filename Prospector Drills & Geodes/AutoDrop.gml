#define AutoDrop(x,y,item,count)
//handles autocollection based on Automation skill to mimic vanilla behavior
if( HasSkill(Skill.Automation) ) {
    GainItem(item, count);
} else {
    DropItem(x, y, item, count);
}
