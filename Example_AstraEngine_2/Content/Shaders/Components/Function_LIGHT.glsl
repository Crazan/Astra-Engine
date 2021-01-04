#PartStart Function_LIGHT;
//**********************************************************************************
struct ColorPair
{
	vec3 Diffuse;
	vec3 Specular;
	vec3 Ambient;
};
//*******************************************************************************
// Get sign value
float Sign(float Value)
{
	if (Value > 0) return 1;
	return -1;
}
//*******************************************************************************
// Calculation of the Fresnel coefficient
// Normal, View Vector, Medium Refractive Index
float FrenelCalc(vec3 N, vec3 V, float IOR)
{
	// Get the cosine of the angle of incidence
	float CosAngle = dot(V, N) / max(length(N) * length(V), 1.0e-7);
	// Calculate the coefficient value using the simplified Fresnel formula
	return 1 / pow(1 + CosAngle, IOR);
}
//*******************************************************************************
// Compute light
// E: View matrix
// N: Normal vector     
ColorPair ComputeLights(vec4 Color, vec4 ColorMetallic, vec3 E, vec3 N, vec3 Normal,
	                    float PowGlossiness,
	                    float PowMetallica, float Roughness, float IOR)
{
	ColorPair result;
	// 1. Compute metallic
	float diffuseAlbedo = 1.0f;
	float ambientAlbedo = 1.0f;
	float specularAlbedo = 1.0f;
	float IOR_Current = IOR;
	if (Enable_MetallicMap == 1)
	{
		diffuseAlbedo = mix(1.0f, 0.3f, PowMetallica);
		specularAlbedo = mix(1.0f, 1.2f, PowMetallica);
		ambientAlbedo = mix(1.0f, 0.55f, PowMetallica);
		IOR_Current = mix(IOR, 2.25f, PowMetallica);
	}
	// Set your own glow
	result.Ambient = AmbientColor.xyz * AmbientIntensity * ambientAlbedo;
	result.Diffuse = vec3(0, 0, 0);
	result.Specular = vec3(0, 0, 0);
	// 2. Direction to camera
	vec3 V = normalize(PositionCamera - E);
	// 3. Compute Fresnel coefficient
	float Frenel = FrenelCalc(N, V, IOR_Current);
	// 4. Compute influence Roughness
	// Get radius from roughness coefficient 0 - completely smooth
	float InvertRoughness = Roughness;
	float R2 = InvertRoughness * InvertRoughness;
	R2 = max(0.000001f, R2);
	// Specular
	float SpecularPower_Current = SpecularPower;
	if (Enable_RoughnessMap == 1)
	{
		SpecularPower_Current = 1.0f;
	}
	// For a light source
	for (int I = 0; I < CountLights; I++)
	{
		// Direction of light to an object
		vec3 L = normalize(PositionLight[I] - E);
		// Half look
		vec3 H = normalize(L + V);
		// Ggx distribution. This function describes the possible deviation of the normal to the surface from the ideal normal N from the degree of surface roughness.
		float ALF = acos(dot(N, H));
		float D = 250.0f * (1.0f - R2) * exp(-(ALF*ALF) / (R2));
		// Shielding factor Sign(dot(N, V));
		float G1 = Sign(dot(N, H));
		float G2 = Sign(dot(N, V));
		// Scattered light coefficient (? use Normal for coorect dark side)
	    float K1 = max(0, G1 * max(0, dot(N, L))) * DiffuseIntensity[I];
		float K2 = max(0, G2 * max(0, dot(N, L))) * DiffuseIntensity[I];
		// Compute specular factor 
		float GS = pow(max(0, dot(H, N) * D * Frenel), SpecularPower_Current) / (max(dot(N, V), 1.0e-7) * 3.14f);
		// Metal Flare Accounting 
	    vec4 SC = mix(SpecularColor[I], mix(Color, ColorMetallic, 0.33f), PowMetallica / 1.7f);
		vec3 TransformSpecularColor = vec3(SC[0], SC[1], SC[2]);
		// Calculation of light sources  
		result.Diffuse =  result.Diffuse + K1 * max(0.5f, dot(N, V)) * diffuseAlbedo *
			              vec3(DiffuseColor[I][0], DiffuseColor[I][1], DiffuseColor[I][2]);

		result.Specular = result.Specular + GS * K2 * max(0.02f, dot(N, V)) * specularAlbedo *
			              TransformSpecularColor * PowGlossiness;
	}
	return result;
}
//*******************************************************************************
#PartEnd



