#PartStart Use_EmissiveMap;
vec4 Emissive = EmissiveIntensity * EmissiveColor;
if (Enable_EmissiveMap == 1)
{
	vec4 emissive = texture(EmissiveMap, GPU_UV);
	Emissive = 255.0f * EmissiveIntensity * emissive + Color * EmissiveDefault * (1.0f - emissive[1]);
}
#PartEnd


