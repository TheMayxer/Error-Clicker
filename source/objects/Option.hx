package objects;
//jogue six shifts at 6000
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;

class Option extends FlxGroup
{
    public var back:FlxSprite;
    public var image:FlxSprite;
    public var textPrice:FlxText;
    public var canBuy:Bool = false;
    var id:Int = 0;

    public var optionsProp = [
        {name: "+1 de Clique", description: "O valor do seu clique mais 1", price: 50, inflacao: 50, max:0, amount:0},
        {name: "Auto Clique", description: "Adiciona mais um no auto clique", price: 120, inflacao: 65, max:0, amount:0},
        {name: "Virus Bom", description: "Aparecem popups na sua\ntela que dão bitcoins", price: 500, inflacao: 0, max:1, amount:0},
        {name: "BackGround", description: "Mais wallpapers fodasticos", price: 1000, inflacao:350,max:5, amount:0}
    ];

    public function new(x:Float, y:Float, id:Int) {
        super();

        this.id = id;

        back = new FlxSprite(x,y,Paths.image('options/back'));
        add(back);

        image = new FlxSprite(back.x + 10, back.y, Paths.image('options/icons/$id'));
        image.y = back.y+back.height/2-image.height/2;
        add(image);

        textPrice = new FlxText(image.x+image.width,image.y,0, '${optionsProp[id].name}\n${optionsProp[id].price}\n${optionsProp[id].description}',12);
        add(textPrice);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        for(shit in [back,image,textPrice]) {
            shit.scale.set(FlxMath.lerp(shit.scale.x,1,elapsed*9),FlxMath.lerp(shit.scale.y,1,elapsed*9));
        }

        image.setPosition(back.x + 10,back.y+back.height/2-image.height/2);
        textPrice.setPosition(image.x+image.width, image.y);

        canBuy = PlayState.instance.bitCoins >= optionsProp[id].price;

        if((optionsProp[id].max == 1 || optionsProp[id].max == 1) && 
            (optionsProp[id].amount == 1 || optionsProp[id].amount == 5)) {
            canBuy = false;
        }

        for(corinthians in [image,textPrice]) corinthians.alpha = canBuy ? 1 : 0.5;

        if(canBuy &&FlxG.mouse.overlaps(back) && FlxG.mouse.justPressed) {
            for(shit in [back,image,textPrice]) shit.scale.set(0.9,0.9);
            clickVoid(id);
        }

        textPrice.text = '${optionsProp[id].name}\nR$ ${optionsProp[id].price}\n${optionsProp[id].description}';
    }

    function clickVoid (num:Int) {
        PlayState.instance.bitCoins -= optionsProp[num].price;
        optionsProp[num].price += optionsProp[num].inflacao;
        optionsProp[num].amount ++;

        switch (num) {
            case 0: 
                PlayState.instance.adder ++ ;
            case 1:
                if(!PlayState.instance.automaticClickerActive) {
                    PlayState.instance.automaticClickerActive = true;
                } else {
                    PlayState.instance.autoAdder += 1;
                }
            case 2: 
                if(!PlayState.instance.isVirusActived) {
                    PlayState.instance.isVirusActived = true;
                } 
        }
    }
}