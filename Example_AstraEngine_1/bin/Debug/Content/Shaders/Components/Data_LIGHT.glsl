#PartStart Data_LIGHT;
// Light
// Number of Light Sources
uniform int CountLights = 0;
// Omnidirectional Light Intensity
uniform float AmbientIntensity = 0;
// Color of non-directional light
uniform vec4 AmbientColor;
// Directional Light Intensity
uniform float DiffuseIntensity[4];
// Color of directional light
uniform vec4 DiffuseColor[4];
// Highlight color
uniform vec4 SpecularColor[4];
// Light source position
uniform vec3 PositionLight[4];
// Camera position
uniform vec3 PositionCamera;
#PartEnd



