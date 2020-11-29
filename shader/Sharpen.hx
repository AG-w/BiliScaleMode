package drone.shader;

import flixel.system.FlxAssets.FlxShader;
import openfl.display.ShaderParameter;

class Sharpen extends FlxShader
{
	@:glFragmentHeader("
		uniform float fStrength;
		
		vec4 sharp(sampler2D bitmap, vec2 coord, vec2 size)
		{
            float dx = 1.0 / size.x;
			float dy = 1.0 / size.y;
			float neighbor = fStrength * -1;
			float target = fStrength * 4 + 1;

            vec4 sum = vec4(0.0);
            sum += neighbor * texture2D(bitmap, coord + vec2( -1.0 * dx , 0.0 * dy));
            sum += neighbor * texture2D(bitmap, coord + vec2( 0.0 * dx , -1.0 * dy));
            sum += target * texture2D(bitmap, coord + vec2( 0.0 * dx , 0.0 * dy));
            sum += neighbor * texture2D(bitmap, coord + vec2( 0.0 * dx , 1.0 * dy));
            sum += neighbor * texture2D(bitmap, coord + vec2( 1.0 * dx , 0.0 * dy));
            
			return sum;
		}")
	@:glFragmentSource("
		#pragma header
		
		void main(void)
		{
			gl_FragColor = sharp(bitmap, openfl_TextureCoordv, openfl_TextureSize);
		}")
	inline public function setParameterValue(parameter:ShaderParameter<Float>, value:Float):Void
	{
		if (parameter.value == null)
			parameter.value = [];
		parameter.value[0] = value;
	}

	public function new()
	{
		super();
	}
}
