#PartStart Use_ReflectMap;
// Start normal - transform normal to space 
vec3 ReflectColor = vec3(0, 0, 0);
// Get normal from map
if (Enable_ReflectMap == 1)
{
	// Mirror
	// ReflectColor = texture(ReflectMap, GPU_CubeTexCoord).xyz;
}
else
{
	ReflectColor = vec3(0, 0, 0);
}
#PartEnd





