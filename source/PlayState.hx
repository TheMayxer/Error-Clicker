package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import objects.Bonzi;
import objects.Option;
import objects.VirusFoda;

class PlayState extends FlxState
{
	
	public var errorLegal:ErrorLegal;
	public var browser:FlxSprite;
	public var bitcoinBack:FlxSprite;
	public var optionsGroup:FlxTypedGroup<Option>;
	public var virusesGroup:FlxTypedGroup<VirusFoda>;
	public var bonzi:Bonzi;

	public var autoClickTimer:FlxTimer;
	public var virusSpawnTimer:FlxTimer;

	public var bitcoinText:FlxText;

	public var bitCoins:Int = 0;
	public var adder:Int = 1;
	public var autoAdder:Int = 1;
	public var automaticClickerActive:Bool = false;
	public var isShopOpen:Bool = false;
	public var isVirusActived:Bool = false;
	public var hasBuddy:Bool = false;

	public static var instance:PlayState;

	override public function create()
	{

		if(FlxG.sound.music == null) {
			FlxG.sound.playMusic('assets/music/maneiro.ogg',0.6,true);
		}

		instance = this;

		var back = new FlxSprite(0,0,Paths.image('area_de_trabalho'));
		back.setGraphicSize(FlxG.width,FlxG.height);
		back.updateHitbox();
		add(back);

		errorLegal = new ErrorLegal();
		add(errorLegal);

		virusesGroup = new FlxTypedGroup<VirusFoda>();
		add(virusesGroup);

		browser = new FlxSprite();
		browser.loadGraphic(Paths.image('browser'));
		browser.x -= browser.width;
		add(browser);

		optionsGroup = new FlxTypedGroup<Option>();
		add(optionsGroup);

		for(i in 0...3) {
			var option = new Option(0,110+(i*90),i);
			optionsGroup.add(option);
		}

		bitcoinBack = new FlxSprite(0,10,Paths.image('vsSaikov2'));
		bitcoinBack.setGraphicSize(bitcoinBack.width*0.6,bitcoinBack.height*0.4);
		bitcoinBack.updateHitbox();
		bitcoinBack.x = (FlxG.width-bitcoinBack.width) - 30;
		add(bitcoinBack);

		bitcoinText = new FlxText(bitcoinBack.x+10,bitcoinBack.y+50,0,Std.string(bitCoins),40);
		bitcoinText.color = FlxColor.BLACK;
		bitcoinText.font = Paths.font('dsaffont');
		add(bitcoinText);

		autoClickTimer = new FlxTimer();
		autoClickTimer.active = automaticClickerActive;
		autoClickTimer.start(5,function(tmr){
			bitCoins += autoAdder;
		},0);

		virusSpawnTimer = new FlxTimer();
		virusSpawnTimer.active = isVirusActived;
		virusSpawnTimer.start(7,function (tmr) {
			var virus = new VirusFoda();
			virusesGroup.add(virus);
		},0);

		FlxG.camera.antialiasing = true;

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		autoClickTimer.active = automaticClickerActive;
		virusSpawnTimer.active = isVirusActived;

		if(FlxG.keys.justPressed.TAB)
			isShopOpen = !isShopOpen;

		browser.x = FlxMath.lerp(browser.x, (isShopOpen ? 0 : -browser.width),elapsed*9);

		bitcoinText.text = Std.string(bitCoins);

		for(op in optionsGroup.members) {
			op.back.x = browser.x + 10;
		}

		virusesGroup.forEachExists(function (virus:VirusFoda) {
			if(FlxG.mouse.overlaps(virus)&&FlxG.mouse.justPressed) {
				bitCoins += virus.amount;
				virusesGroup.remove(virus,true);
			}
		});

		if(hasBuddy && bonzi==null) {
			bonzi = new Bonzi(10,10);
			add(bonzi);
		}

		if(FlxG.mouse.justPressed) {
			FlxG.sound.play(Paths.sound('MouseClick'),0.4,false);
		}
	}
}
