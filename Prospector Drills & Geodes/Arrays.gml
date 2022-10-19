#define RandArray(array)
//selects random item from the given array
if(is_array(array)){
    if(array_length(array) > 0){
        _length = array_length(array) - 1;
        _rand = irandom(_length);
        return array[_rand]
    }
}

#define ArrayPush
//I believe this was written by the developer of the mod engine, it is very elegant
var r = argument[0];
var o = array_length_1d(r) - 1;
var i = argument_count;
while (--i > 0) r[@o + i] = argument[i];
return r;
