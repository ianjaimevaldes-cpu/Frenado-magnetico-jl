using Plots


Plots.closeall()

include("../../src/DropTower.jl")

# con conductor
p_conductor = parametros()

# sin conductor
p_sin_conductor = parametros(cond = 0.0)

c = configuracion()

res_conductor = simular(p_conductor, c)
res_sin_conductor = simular(p_sin_conductor, c)

graficar(res_conductor, res_sin_conductor, p_conductor)