shader_type sky;

uniform vec3 skyColor : source_color;
uniform vec3 horizontalColor : source_color;

void sky() {
	float col = clamp(EYEDIR.y / 0.5, 0.0, 1.0);
	vec3 finalColor = mix(horizontalColor, skyColor, col);
	COLOR = finalColor;
}
