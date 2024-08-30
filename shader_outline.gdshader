shader_type spatial;

// Paramètres de l'outline
uniform float outline_width : hint_range(0.0, 10.0, 0.1) = 5.0;
uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0); // Couleur du contour

// Couleurs pour le dégradé
uniform vec4 color_start : source_color = vec4(0.0, 0.0, 1.0, 1.0); // Bleu
uniform vec4 color_end : source_color = vec4(1.0, 0.5, 0.0, 1.0);   // Orange

// Fonction pour calculer l'effet Fresnel
float fresnel(float amount, vec3 normal, vec3 view)
{
    return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0 )), amount);
}

void fragment()
{
    // Calcul de l'effet Fresnel pour déterminer l'outline
    float basic_fresnel = fresnel(outline_width, NORMAL, VIEW);
    basic_fresnel = step(0.5, basic_fresnel); // 0.5 est une valeur qui contrôle l'épaisseur de l'outline

    // Génération du dégradé basé sur les coordonnées UV.y
    float gradient_factor = clamp(UV.y, 0.0, 1.0);
    vec3 gradient_color = mix(color_start.rgb, color_end.rgb, gradient_factor);

    // Appliquer la couleur de l'outline et mélanger avec la couleur du dégradé
    vec3 final_color = mix(gradient_color, outline_color.rgb, basic_fresnel);

    // Assigner la couleur finale au matériau
    ALBEDO = final_color;
    ALPHA = mix(color_start.a, color_end.a, gradient_factor); // Transparence basée sur le dégradé
}