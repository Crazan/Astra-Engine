#PartStart Function_HUEMASK;
//**********************************************************************************
// Compute HUE for color
float ComputeHUE(vec4 color)
{
	//
	float R = color[0];
	float G = color[1];
	float B = color[2];
	//
	float MinValue = min(min(R, G), B);
	float MaxValue = max(max(R, G), B);
	//
	float HUE = 0.0f;
	if (R > G && R > B)
	{
		HUE = (G - B) / (MaxValue - MinValue);
	}
	if (G > R && G > B)
	{
		HUE = 2.0 + (B - R) / (MaxValue - MinValue);
	}
	if (B > R && B > G)
	{
		HUE = 4.0 + (R - G) / (MaxValue - MinValue);
	}
	//
	HUE = HUE * 60.0f;
	//
	if (HUE < 0) HUE = HUE + 360.0f;
	//
	return HUE;
}
//**********************************************************************************
// Compute Saturate for color
float ComputeSaturate(vec4 color)
{
	//
	float R = color[0];
	float G = color[1];
	float B = color[2];
	//
	float MinValue = min(min(R, G), B);
	float MaxValue = max(max(R, G), B);
	// 
	float Saturate = 0.0f;
	if (MaxValue > 0)
	{
		Saturate = (MaxValue - MinValue) / MaxValue;
		Saturate = Saturate * 100.0f;
	}
	//
	return Saturate;
}
//**********************************************************************************
// Apply DeltaHue
vec3 ApplyDeltaHue(vec3 aColor, int aHue)
{
	float angle = aHue / 57.3f;
	vec3 k = vec3(0.57735, 0.57735, 0.57735);
	float cosAngle = cos(angle);
	// Rodrigues' rotation formula
	return aColor * cosAngle + cross(k, aColor) * sin(angle) + k * dot(k, aColor) * (1 - cosAngle);
}
//*******************************************************************************
#PartEnd



