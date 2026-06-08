function simular(p::parametros,c::configuracion)

    t =c.t0
    z = c.z0
    v = c.v0

    tiempo = Float64[]
    posicion = Float64[]
    velocidad = Float64[]
    aceleracion = Float64[]
    fuerza = Float64[]
    FEM = Float64[]

    while t  <= c.t_max && z >= c.z_final

        push!(tiempo, t)
        push!(posicion, z)
        push!(velocidad, v)
        push!(aceleracion, desaceleracion(z,v,p))
        push!(fuerza, Fuerza_magnetica(z,v,p))
        push!(FEM, FEM_total(z,v,p))


        z, v = RK4(z, v, c.dt, p)

        t = t + c.dt
    end
    
    return resultados(tiempo, posicion, velocidad, aceleracion, fuerza, FEM)

end

