#PartStart Use_MetallicMap;
// Map metallic
float PowMetallic = 0;
vec4 MetallicColor = vec4(0, 0, 0, 0);
if (Enable_MetallicMap == 1)
{
	vec4 M = texture(MetallicMap, GPU_UV);
    PowMetallic = M[3] * (M[0] + M[1] + M[2]) / 3.0f;
	MetallicColor = M;
}
#PartEnd





