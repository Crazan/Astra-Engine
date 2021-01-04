#PartStart Use_ColorMap;
// Not find color map. Start color
vec4 Color = vec4(0, 0, 0, 0);
// One color map
if (Count_ColorMap > 0)
{
	Color = texture(ColorMap_1, GPU_UV);
}
if (Count_ColorMap > 1)
{
	vec4 C2 = texture(ColorMap_2, GPU_UV);
	if (C2[3] > 0)
	{
		Color = vec4(C2[0], C2[1], C2[2], Color[3]);
	}
}
if (Count_ColorMap > 2)
{
	vec4 C3 = texture(ColorMap_3, GPU_UV);
	if (C3[3] > 0)
	{
		Color = vec4(C3[0], C3[1], C3[2], Color[3]);
	}
}
#PartEnd



