#PartStart Data_3D_Vertex;
// Data from CPU
// Vertexs of model
in vec3 Vertex;
// Normals of model
in vec3 Normal;
// Texture coordinate
in vec2 UV;
// Camera position
uniform vec3 PositionCamera;
// Data from Vertex GPU to Fragment GPU
// Output Vertexs for fragment shader
out vec3 GPU_Vertex;
// Output Normal for fragment shader
out vec3 GPU_Normal;
// Output texture coordinate for fragment shader
out vec2 GPU_UV;
// Output View for fragment shader
out vec3 GPU_View;
// Output matrix World
out mat3 GPU_World;
// Output CubeTexCoord for fragment shader
out vec3 GPU_CubeTexCoord;
#PartEnd
