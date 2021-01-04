#PartStart Use_Color;
// Mixing color
Color = vec4(Color[0] * (ColorFill[0] / 255.0f), Color[1]*(ColorFill[1] / 255.0f),
             Color[2] * (ColorFill[2] / 255.0f), Color[3]*(ColorFill[3] / 255.0f));
// Fill color
if(Enable_ColorFill == 1)
{
	Color = ColorFill / 255.0f;
}
// Transparency
Color = vec4(Color[0], Color[1], Color[2], Color[3] * Alpha);
#PartEnd



