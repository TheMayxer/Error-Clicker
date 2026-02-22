package;

class Paths 
{
    public static function image(key:String) {
        return 'assets/images/$key.png';
    }

    public static function sound(key:String) {
        return 'assets/sounds/$key.ogg';
    }

    public static function font(key:String) {
        return 'assets/data/font/$key.ttf';
    }
}