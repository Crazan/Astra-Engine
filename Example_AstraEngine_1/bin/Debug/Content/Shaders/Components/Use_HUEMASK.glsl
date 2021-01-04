#PartStart Use_HUEMASK;
// HUE MASK
if (EnableReplaceColor == 1)
{
	// Get Hue
	float HUE = ComputeHUE(Color);
	// Get Saturate
	float Saturate = ComputeSaturate(Color);
	// Apply 
	if (HUE > HUEMaskMin && HUE < HUEMaskMax &&
		Saturate > SaturateMaskMin && Saturate < SaturateMaskMax)
	{
		vec3 M = ApplyDeltaHue(vec3(Color[0], Color[1], Color[2]), DeltaHUE);
		Color = vec4(M[0], M[1], M[2], Color[3]);
	}
}
#PartEnd



