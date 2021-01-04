#PartStart Use_RoughnessMap;
// Compute Roughness on map
float Roughness = RoughnessAll;
float RoughnessAlfa = 0;
if (Enable_RoughnessMap == 1)
{
	vec4 R = texture(RoughnessMap, GPU_UV);
	if (R[3] > 0.1f)
	{
		Roughness = (R[0] + R[1] + R[2]) / 3.0f;
		RoughnessAlfa = R[3];
	}
}
// Mirror light - There is no completely black surface
float KMirror = min(0.2f, Roughness);
#PartEnd





