package;

import drone.shader.Bilinear;
import drone.shader.Sharpen;
import flixel.FlxG;
import flixel.system.scaleModes.BaseScaleMode;
import openfl.filters.ShaderFilter;

class BiliScaleMode extends BaseScaleMode
{
	var filterBili:Bilinear;
	var scaleX:Float;
	var scaleY:Float;
	var screenWidth:Int;
	var screenHeight:Int;

	public function new()
	{
		var bili = new Bilinear();
		var sharp = new Sharpen();
		screenWidth = FlxG.stage.stageWidth;
		screenHeight = FlxG.stage.stageHeight;

		bili.setParameterValue((cast bili).fScaleX, 1);
		bili.setParameterValue((cast bili).fScaleY, 1);
		bili.setParameterValue((cast bili).fStrength, .2);
		sharp.setParameterValue((cast sharp).fStrength, .1);
		var b = new ShaderFilter(bili);
		var s = new ShaderFilter(sharp);
		FlxG.game.setFilters([b, s]);
		filterBili = bili;

		super();
	}

	override function updateGameSize(Width:Int, Height:Int):Void
	{
		var ratio:Float = FlxG.width / FlxG.height;
		var realRatio:Float = Width / Height;

		// scaleX = Width / FlxG.width;
		// scaleY = Height / FlxG.height;

		var scaleYaxis = realRatio < ratio;
		if (scaleYaxis)
			scaleY = scaleX = Width / FlxG.width;
		else
			scaleX = scaleY = Height / FlxG.height;

		gameSize.set(Width, Height);
	}

	override private function updateScaleOffset():Void
	{
		filterBili.setParameterValue((cast filterBili).fScaleX, scaleX);
		filterBili.setParameterValue((cast filterBili).fScaleY, scaleY);
		scale.x = 1;
		scale.y = 1;
		updateOffsetX();
		updateOffsetY();
	}

	override function updateOffsetX():Void
	{
		offset.x = 0;
	}

	override function updateOffsetY():Void
	{
		// var temp = (gameSize.y - screenHeight) / screenHeight * 100 / scaleY;
		offset.y = Math.abs((deviceSize.y - screenHeight * scaleY) * 0.5) / scaleY;
	}
}
