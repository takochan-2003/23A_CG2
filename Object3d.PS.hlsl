#include"object3d.hlsli"

//Texture‚ÌéŒ¾
Texture2D<float32_t4> gTexture : register(t0);
SamplerState gSampler : register(s0);

struct Material {
	float32_t4 color;
};

ConstantBuffer<Material> gMaterial : register(b0);

struct PixelShaderOutput {
	float32_t4 color : SV_TARGET0;
};

//struct VertexShaderInput {
//	float32_t4 position : POSITION0;
//	float32_t2 texcoord : TEXCOORD0;
//	float32_t3 normal : NORMAL0;
//};

PixelShaderOutput main(VertexShaderOutput input) {
	PixelShaderOutput output;
	//Texture‚ğSampling‚·‚é
	float32_t4 textureColor = gTexture.Sample(gSampler, input.texcord);
	output.color = gMaterial.color * textureColor;
	return output;
}
