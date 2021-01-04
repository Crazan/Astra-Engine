#PartStart Function_Tangents;
//**********************************************************************************
// Compute Tangents (for only fragment shader)
vec3 ComputeTangents(vec3 PositionPolygon, vec2 PositionUV)
{
	vec3 pos_dx = dFdx(PositionPolygon);
	vec3 pos_dy = dFdy(PositionPolygon);
	// derivations of the texture coordinate
	vec2 texC_dx = dFdx(PositionUV);
	vec2 texC_dy = dFdy(PositionUV);
	// tangent vector and binormal vector
	vec3 t = texC_dy.y * pos_dx - texC_dx.y * pos_dy;
	return t;
}
//**********************************************************************************
// Compute Binormals (for only fragment shader)
vec3 ComputeBinormals(vec3 InputNormal, vec3 InputTangents)
{
	return normalize(cross(InputNormal, InputTangents));
}
//*******************************************************************************
#PartEnd



