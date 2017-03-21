PhysicalMaterial material;

#ifdef STANDARD_SG
	material.diffuseColor = diffuseColor.rgb;
	material.specularRoughness = clamp( 1.0 - glossinessFactor, 0.04, 1.0 );
	material.specularColor = specular2Factor.rgb;
#else
	material.diffuseColor = diffuseColor.rgb * ( 1.0 - metalnessFactor );
	material.specularRoughness = clamp( roughnessFactor, 0.04, 1.0 );
	#ifdef STANDARD
		material.specularColor = mix( vec3( DEFAULT_SPECULAR_COEFFICIENT ), diffuseColor.rgb, metalnessFactor );
	#else
		material.specularColor = mix( vec3( MAXIMUM_SPECULAR_COEFFICIENT * pow2( reflectivity ) ), diffuseColor.rgb, metalnessFactor );
		material.clearCoat = saturate( clearCoat ); // Burley clearcoat model
		material.clearCoatRoughness = clamp( clearCoatRoughness, 0.04, 1.0 );
	#endif
#endif
