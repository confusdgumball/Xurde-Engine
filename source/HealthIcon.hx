package;

import flixel.FlxSprite;

#if windows
import Sys;
import sys.FileSystem;
#end

#if sys
import sys.io.File;
import haxe.io.Path;
import openfl.utils.ByteArray;
import flash.display.BitmapData;
import sys.FileSystem;
#end

using StringTools;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public var char:String = 'bf';
	public var isPlayer:Bool = false;
	public var isOldIcon:Bool = false;

	public function new(?char:String = 'bf', ?isPlayer:Bool = false)
	{
		super();

		this.char = char;
		this.isPlayer = isPlayer;

		useIconGrid(char);
		scrollFactor.set();
	}

	public function changeIcon(char:String)
	{
		if (!FileSystem.exists(Paths.image('icons/icon-' + char,'shared')))
			char = 'face';

		var rawPic = BitmapData.fromFile(Paths.image('icons/icon-'+char,'shared'));
		loadGraphic(rawPic, true, 150, 150);

		if (char.endsWith('-pixel') || char.startsWith('senpai') || char.startsWith('spirit'))
			antialiasing = false;
		else
			antialiasing = true;

		animation.add(char, [0, 1], 0, false, isPlayer);
		animation.play(char);
	}

	public function useIconGrid(char:String)
	{
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);

		antialiasing = true;
		animation.add('bf', [0, 1], 0, false, isPlayer);
		animation.add('bf-car', [0, 1], 0, false, isPlayer);
		animation.add('bf-christmas', [0, 1], 0, false, isPlayer);
		animation.add('bf-pixel', [21, 21], 0, false, isPlayer);
		animation.add('spooky', [2, 3], 0, false, isPlayer);
		animation.add('pico', [4, 5], 0, false, isPlayer);
		animation.add('mom', [6, 7], 0, false, isPlayer);
		animation.add('mom-car', [6, 7], 0, false, isPlayer);
		animation.add('tankman', [8, 9], 0, false, isPlayer);
		animation.add('face', [10, 11], 0, false, isPlayer);
		animation.add('dad', [12, 13], 0, false, isPlayer);
		animation.add('senpai', [22, 22], 0, false, isPlayer);
		animation.add('senpai-angry', [22, 22], 0, false, isPlayer);
		animation.add('spirit', [23, 23], 0, false, isPlayer);
		animation.add('bf-old', [14, 15], 0, false, isPlayer);
		animation.add('gf', [16], 0, false, isPlayer);
		animation.add('parents-christmas', [17], 0, false, isPlayer);
		animation.add('monster', [19, 20], 0, false, isPlayer);
		animation.add('monster-christmas', [19, 20], 0, false, isPlayer);

		if (animation.getByName(char) != null) {
			animation.play(char);
		}
		else {
			changeIcon(char);
		}		
		
		if (char.startsWith('senpai') || char.contains('pixel') || char.startsWith('spirit'))
			antialiasing = false;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
