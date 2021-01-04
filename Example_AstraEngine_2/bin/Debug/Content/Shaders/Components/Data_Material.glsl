#PartStart Data_Material;
// Enable color fill
uniform int Enable_ColorFill;
// Fill color
uniform vec4 ColorFill;
// Transparency 
uniform float Alpha;
// The degree of indentation of the relief 0 ... 10 less
uniform float PowBump;
// Material settings. Flare
uniform float SpecularPower;
// Model surface roughness
uniform float RoughnessAll;
// Material settings. Additional color of light scattering on the model
uniform vec4 EmissiveColor;
// Material settings. Light intensity
uniform float EmissiveIntensity = 1;
// Mixing Light and base color
uniform float EmissiveDefault = 0.1;
// Material refractive index
uniform float IOR_Material = 5.43788f;
#PartEnd



