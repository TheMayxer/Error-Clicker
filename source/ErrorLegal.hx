package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;

class ErrorLegal extends FlxSprite
{
    public function new() {
        super();
        loadGraphic(Paths.image('error'));
        screenCenter();
        updateHitbox();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        scale.set(FlxMath.lerp(scale.x,1,elapsed*8),FlxMath.lerp(scale.y,1,elapsed*8));
        alpha = FlxMath.lerp(alpha,1,elapsed*8);

        if(FlxG.mouse.overlaps(this) && FlxG.mouse.justPressed) {
            FlxG.sound.play(Paths.sound('changeAi'),0.2,false);
            scale.set(0.5,0.5);
            alpha = 0;
            addBit();
        }
    }

    public function addBit()
    {
        //codigo meramente copiado do pschy engine te amo shadow mario muah
        var playInstance = PlayState.instance;
        var seperatedBit:Array<Int> = [];

        playInstance.bitCoins += playInstance.adder;
        
        //if(playInstance.adder >= 10000) seperatedBit.push(Math.floor(playInstance.adder / 10000) % 10);
        if(playInstance.adder >= 1000) seperatedBit.push(Math.floor(playInstance.adder / 1000) % 10);
        if(playInstance.adder >= 100) seperatedBit.push(Math.floor(playInstance.adder / 100) % 10);
        if(playInstance.adder >= 10) seperatedBit.push(Math.floor(playInstance.adder / 10) % 10);
		seperatedBit.push(playInstance.adder % 10);
        
        var bacana = playInstance.errorLegal;
        for(i in 0...seperatedBit.length)
        {
            var num = new FlxSprite();
            num.loadGraphic(Paths.image('nums/${seperatedBit[i]}'));
            num.setPosition((bacana.x+bacana.width),bacana.y-20);
            num.x += i*35;
            num.velocity.y = -400;
            num.acceleration.y = 900;
            num.acceleration.x = FlxG.random.float(-40,40);
            num.angularAcceleration = FlxG.random.float(-80,80);
            FlxTween.tween(num,{alpha:0},0.5,{onComplete:(_)->num.destroy()});
            playInstance.add(num);
        }
    }
}