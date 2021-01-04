#PartStart Data_3D_Fragment;
#extension GL_NV_shadow_samplers_cube : enable
// Data from Vertex GPU to Fragment GPU
// Output Vertexs for fragment shader
in vec3 GPU_Vertex;
// Output Normal for fragment shader
in vec3 GPU_Normal;
// Output texture coordinate for fragment shader
in vec2 GPU_UV;
// Output View for fragment shader
in vec3 GPU_View;
// Output matrix World
in mat3 GPU_World;
// Output CubeTexCoord for fragment shader
in vec3 GPU_CubeTexCoord;
// Data textures from CPU
// Texture color maps (max = 3)
uniform sampler2D ColorMap_1;
uniform sampler2D ColorMap_2;
uniform sampler2D ColorMap_3;
// Texture normal map
uniform sampler2D NormalMap;
// Texture Glossiness map. Light scattering texture map
// - the darker the less glare and the more scattering on
// the surface of the material 
uniform sampler2D SpecularMap;
// Texture Roughness map
uniform sampler2D RoughnessMap;
// Texture Metallic map
uniform sampler2D MetallicMap;
// Texture Emissive map
uniform sampler2D EmissiveMap;
// Texture Reflect map
uniform samplerCube ReflectMap;
// Special flags for control textures
// Count color maps
uniform int Count_ColorMap;
// Use normal map
uniform int Enable_NormalMap;
// Use material map
uniform int Enable_SpecularMap;
// Use roughness map
uniform int Enable_RoughnessMap;
// Use  metallic map
uniform int Enable_MetallicMap;
// Use  Emissive map
uniform int Enable_EmissiveMap;
// Use reflect map
uniform int Enable_ReflectMap;
// Enable invert normal map
uniform int Inverted_NormalMap;
// Out color on screen
layout(location = 0) out vec4 fragColor;
#PartEnd
