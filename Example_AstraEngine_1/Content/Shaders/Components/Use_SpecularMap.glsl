#PartStart Use_SpecularMap;
// Compute Specular on map
float PowGlossiness = 1.0;
if (Enable_SpecularMap == 1)
{
	vec4 Gloss = texture(SpecularMap, GPU_UV);
	if (Gloss[3] > 0.001f)
	{
		PowGlossiness = (Gloss[0] + Gloss[1] + Gloss[2]) / 3.0;
	}
}
#PartEnd





