package shader;

import flixel.system.FlxAssets.FlxShader;
import openfl.display.ShaderParameter;

class Bilinear extends FlxShader
{
	@:glFragmentHeader('
    uniform float fScaleX;
    uniform float fScaleY;
    uniform float fStrength;
    
    vec4 biliScale(sampler2D bitmap, vec2 coord)
    {
        float texelSizeX = fStrength * 1/fScaleX/openfl_TextureSize.x;
        float texelSizeY = fStrength * 1/fScaleY/openfl_TextureSize.y;
         
        vec2 texCoords = vec2(openfl_TextureCoordv.x / fScaleX, openfl_TextureCoordv.y / fScaleY);

        vec4 p0q0 = texture2D(bitmap, texCoords);
        vec4 p1q0 = texture2D(bitmap, texCoords + vec2(texelSizeX, 0));

        vec4 p0q1 = texture2D(bitmap, texCoords + vec2(0, texelSizeY));
        vec4 p1q1 = texture2D(bitmap, texCoords + vec2(texelSizeX , texelSizeY));

        float a = fract(openfl_TextureCoordv.x * openfl_TextureSize.x); 
        float b = fract(openfl_TextureCoordv.y * openfl_TextureSize.y);

        vec4 pInterp_q0 = mix( p0q0, p1q0, a ); 
        vec4 pInterp_q1 = mix( p0q1, p1q1, a ); 

        return mix( pInterp_q0, pInterp_q1, b );
    }
    ')
	@:glFragmentSource("
		#pragma header
		
		void main(void)
		{
			gl_FragColor = biliScale(bitmap, openfl_TextureCoordv);
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
