shader_type canvas_item;

uniform sampler2D Skin; // assign skin sprite in inspector
uniform vec2 Texel;  // assign length and width of skin sprite in editor

void fragment()
{
	vec4 map = texture(TEXTURE, UV);  // collect RGBA of pixel from sprite texture
	vec2 scaledUV = (map.rg * 255.0 + 0.5) / Texel;  // scale the UV to the 64 x 64 "skin" sprite
	vec4 color = texture(Skin, scaledUV);  // collect the rgba from the 'skin' sprite based on the scaledUV
	color.a = map.a;  // set original sprite transparency
	COLOR = color;  // set new color
}