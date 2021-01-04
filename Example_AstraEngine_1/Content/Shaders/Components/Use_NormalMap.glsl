#PartStart Use_NormalMap;
// Start normal - transform normal to space 
vec3 FragmentNormal = GPU_Normal;
// Get normal from map
if (Enable_NormalMap == 1)
{
	vec4 ColorNormal = texture(NormalMap, GPU_UV);
	// Control
    if(length(ColorNormal) > 0.01f)
	{
		// OpenGL mode
		if (Inverted_NormalMap == 1)
			ColorNormal = vec4(ColorNormal[0], 1 - ColorNormal[1], ColorNormal[2], 1);
		FragmentNormal = 2.0f * vec3(ColorNormal[0], ColorNormal[1], ColorNormal[2]) - 1.0f;
		// Use intensity normal map
		FragmentNormal.xy *= PowBump;
		if (PowBump < 0)
		{
			FragmentNormal.y = -FragmentNormal.y;
		}
		// Compute mat TBN 
		vec3 T = normalize(GPU_World * ComputeTangents(GPU_View, GPU_UV));
		vec3 B = ComputeBinormals(GPU_Normal, T);
		mat3 TBN = mat3(T, B, GPU_Normal);
		// Transform on mat TBN
		FragmentNormal = normalize(TBN * normalize(FragmentNormal));
	}
}
#PartEnd





