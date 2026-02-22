package objects;

import flixel.FlxG;
import flixel.FlxSprite;

class Bonzi extends FlxSprite
{
    public var isHoldin:Bool = false;
    public function new(x:Float, y:Float) {
        super(x,y);

        loadGraphic(Paths.image('bonzi'));
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if(FlxG.mouse.overlaps(this)&&FlxG.mouse.justPressedRight) isHoldin = !isHoldin;

        if(isHoldin) setPosition(FlxG.mouse.x - this.width/2,FlxG.mouse.y-50);
    }

    function showBallow(text:String) {
        
    }
}