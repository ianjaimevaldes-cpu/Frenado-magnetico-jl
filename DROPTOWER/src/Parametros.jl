

Base.@kwdef struct parametros
    g::Float64 = 9.81              # g

    μ0::Float64 = 4π * 1e-7        # permeabilidad del vacío
    m_dipolo::Float64 = 2.5         # momento dipolar magnético
    ancho_Tubo::Float64 = 0.005      #ancho del tubo

    cond::Float64 = 5.95e7          #conductividad cilindo     
    R::Float64 = 0.025               #Radio interno delcilindo

    tubo_up::Float64 = 0.7          # longitud conductor
    tubo_down::Float64 = 0.2        # empieza en 1 y termina en 0.3

    masa::Float64 = 0.01          #masa kg

end

Base.@kwdef struct configuracion
    t0::Float64 = 0.0              # t0
    t_max::Float64 = 30            # tiempo máximo, (para que no corra a infinito)
    dt::Float64 = 0.001            # paso de tiempo

    z0::Float64 = 1.0              # posición inicial del dipolo
    v0::Float64 = 0.0              # velocidad inicial del dipolo

    z_final::Float64 =  0.01        # posición final del recorrido
end

struct resultados
    t::Vector{Float64}
    z::Vector{Float64}
    v::Vector{Float64}
    a::Vector{Float64}
    F::Vector{Float64}
    FEM::Vector{Float64}

end

