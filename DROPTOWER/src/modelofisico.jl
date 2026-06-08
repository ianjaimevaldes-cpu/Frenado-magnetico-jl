

#primero aqui acabare de llenar esta integral 

function A_integral(chunche, z, p::parametros)
    R=p.R 
    u = chunche-z

    return (15 * (u^2 + R^2)^4 * atan(u / R) +
            15 * R * u^7 +
            55 * R^3 * u^5 +
            73 * R^5 * u^3 -
            15 * R^7 * u) /
           (384 * R^7 * (u^2 + R^2)^4)

end
    

#=function f_medel(z, p::parametros)
    R = p.R

    θ1 = atan((z - p.tubo_down) / R)
    t1 = (5/128)*θ1 + (1/64)*sin(2*θ1) - (1/128)*sin(4*θ1) - 
         (1/192)*sin(6*θ1) - (1/1024)*sin(8*θ1)

    θ2 = atan((z - p.tubo_up) / R)
    t2 = (5/128)*θ2 + (1/64)*sin(2*θ2) - (1/128)*sin(4*θ2) - 
         (1/192)*sin(6*θ2) - (1/1024)*sin(8*θ2)

    return t1 - t2
end=#


function A_integral_definida(z, p::parametros)
    return A_integral(p.tubo_up, z, p) - A_integral(p.tubo_down, z, p)
end


function  constante_agr(p::parametros)
    C = ((9*p.μ0^2*p.m_dipolo^2*p.ancho_Tubo*p.cond*p.R^3)/(8π)) 
    return C
end

function Fuerza_magnetica(z,v, p::parametros);
    return -constante_agr(p) * v  *A_integral_definida(z,p)
end

function  desaceleracion(z,v, p::parametros)

    return -p.g + Fuerza_magnetica(z,v,p)/p.masa

end


#aqui llegue integrando la funcion de la fem para un cachito del conductor

function FEM_total(z,v,p::parametros)
    
    return(p.μ0*p.m_dipolo*p.R^2*v/2)*
    (1 / (p.R^2 + (p.tubo_up - z)^2)^(3/2) -
    1 / (p.R^2 + (p.tubo_down - z)^2)^(3/2))
end


