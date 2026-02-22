package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;

class VirusFoda extends FlxSprite
{
    public var amount:Int = FlxG.random.int(1,5);

    public function new() {
        super();
        
        loadGraphic(Paths.image('viruses/${FlxG.random.int(0,12)}'));
        setPosition(FlxG.random.float(0,FlxG.width-this.width),FlxG.random.float(0,FlxG.height-this.height));
        scale.set(0,0);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        scale.set(FlxMath.lerp(scale.x,1,elapsed*9),FlxMath.lerp(scale.y,1,elapsed*9));
    }
}