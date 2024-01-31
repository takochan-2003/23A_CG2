#include "Object3d.hlsli"

struct Material {
	float32_t4 color;
	int32_t enableLighting;
};

struct DirectionalLight {
	float32_t4 color;//< ���C�g�̐F
	float32_t3 direction;//!< ���C�g�̌���
	float intensity;//< �P�x
};

ConstantBuffer<Material> gMaterial : register(b0);
struct PixcelShaderOutput {
	float32_t4 color : SV_TARGET0;
};

ConstantBuffer<DirectionalLight> gDirectionalLight : register(b1);

Texture2D<float32_t4>gTexture : register(t0);
SamplerState gSampler : register(s0);


PixcelShaderOutput main(VertexShaderOutput input) {
	float32_t4 textureColor = gTexture.Sample(gSampler, input.texcoord);
	PixcelShaderOutput output;
	if (gMaterial.enableLighting != 0) {
		float cos = saturate(dot(normalize(input.normal), -gDirectionalLight.direction));
		output.color = gMaterial.color * textureColor * gDirectionalLight.color * cos * gDirectionalLight.intensity;
	}
	else {// Ligting���Ȃ��ꍇ�B�O��܂łƓ������Z
		output.color = gMaterial.color * textureColor;
	}
	return output;
}
