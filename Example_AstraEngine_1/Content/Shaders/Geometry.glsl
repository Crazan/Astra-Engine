// Standart texture 3D shader
// Vertex shader
#VertexShader Geometry
#version 330 core
// Include Data
#Inline Data_3D_Vertex;
#Inline Data_World;
// Main
void main()
{
	// Compute vertex
	vec4 worldPosition = World * vec4(Vertex, 1.0f);
	vec4 viewPosition = View * worldPosition;
	gl_Position = Projection * viewPosition;
	GPU_Vertex = vec3(gl_Position[0], gl_Position[1], gl_Position[2]);
	// Set params
	GPU_World = mat3(World);
	GPU_UV = UV;
	GPU_View = vec3(worldPosition[0], worldPosition[1], worldPosition[2]);
	// Compute Normal for TBN matrix and normal mapping
	GPU_Normal = normalize(mat3(World) * normalize(Normal));
    // Compute mirror
	vec3 viewDirection = vec3(worldPosition - vec4(PositionCamera, 1.0));
	GPU_CubeTexCoord = normalize(reflect(viewDirection, normalize(Normal)));
}
// End
#EndShader
//**********************************************************
#FragmentShader Geometry
#version 330 core
// Include Data
#Inline Data_3D_Fragment;
#Inline Data_HUEMask;
#Inline Data_Material;
#Inline Data_LIGHT;
// Include fuctions
#Inline Function_HUEMASK;
#Inline Function_LIGHT;
#Inline Function_Tangents;
// Main function
void main()
{
	// 1. Compute colormap
	#Inline Use_ColorMap;
    // 2. Set mask HUE
	#Inline Use_HUEMASK;
	// 3. Set color matrial 
	#Inline Use_Color;
    // 4. Compute normal map
	#Inline Use_NormalMap;
	// 5. Compute specular map
	#Inline Use_SpecularMap;
	// 6. Compute roughness map
	#Inline Use_RoughnessMap;
	// 7. Compute metallic map
	#Inline Use_MetallicMap;
	// 8. Compute emissive map
	#Inline Use_EmissiveMap;
	// 9. Compute reflect map
	#Inline Use_ReflectMap;
	// 10. Compute light
	ColorPair Light = ComputeLights(Color, MetallicColor, GPU_View, FragmentNormal, GPU_Normal,
		                            PowGlossiness, PowMetallic, Roughness, IOR_Material);
	// 11. Integral color
	// Influence emissive texture
	float Influence_Emissive = 1.0f - Emissive[3] * (Emissive[0] + Emissive[1] + Emissive[2]) / 3.0f;
	// Border function
	if (Influence_Emissive < 0.8f)
	{
		Influence_Emissive = 0;
	}
	// Influence ambient light vec4(Color[3] * Light.Ambient * Influence_Emissive, 0.0f);
	vec4 Influence_Ambient = vec4(Light.Ambient * Influence_Emissive, 0.0f);
	// Influence reflect map
	vec4 Influence_Reflect = vec4(ReflectColor[0], ReflectColor[1], ReflectColor[2], Color[3]);
	// Influence roughness map
	float Influence_Roughness = min(1.0f, 4.545f * Roughness);
	// Border function
	if (RoughnessAlfa == 0)
	{
		Influence_Roughness = 1.0f;
	}
	// Parts of color
	vec4 OUT_Emissive = vec4(Emissive[0], Emissive[1], Emissive[2], 0);
	vec4 OUT_Blackmirror = vec4(KMirror * Influence_Emissive * (Light.Diffuse + Light.Specular), 0);

	vec4 OUT_Main = mix(vec4(1, 1, 1, Color[3]), Color, Influence_Roughness) *
    	            vec4((1 - KMirror) * Influence_Emissive *   
        			(Light.Diffuse + Light.Specular +
					6 * mix(vec3(0, 0, 0), Influence_Reflect.xyz * Light.Diffuse, 1.0f - Influence_Roughness)), 1.0f) +
		            Influence_Emissive * Color * Influence_Ambient;

	// vec4 OUT_Main = mix(vec4(1, 1, 1, 1), Color, Influence_Roughness) *
    //	                   vec4((1 - KMirror) * Influence_Emissive *   
    //    			       (Color[3] * Light.Diffuse + Light.Specular +
	//				       6 * mix(vec3(0, 0, 0), Color[3] * Influence_Reflect.xyz * Light.Diffuse, 1.0f - Influence_Roughness)), 1.0f) +
	//	                   Influence_Emissive * Color * Influence_Ambient;
	// END - Return Pixel Roughness
	fragColor = OUT_Emissive + OUT_Blackmirror + OUT_Main;
}
//
#EndShader



