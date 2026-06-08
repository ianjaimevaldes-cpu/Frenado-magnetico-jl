function graficar_pos(res_conductor::resultados, res_sin_conductor::resultados)
    plt = plot(
        res_sin_conductor.t,
        res_sin_conductor.z,
        xlabel = "Tiempo [s]",
        ylabel = "Posición z [m]",
        title = "Comparación de posición",
        label = "Sin conductor",
        linewidth = 2
    )

    plot!(
        plt,
        res_conductor.t,
        res_conductor.z,
        label = "Con conductor",
        linewidth = 2
    )

    return plt
end


function graficar_vel(res_conductor::resultados, res_sin_conductor::resultados)
    plt = plot(
        res_sin_conductor.t,
        res_sin_conductor.v,
        xlabel = "Tiempo [s]",
        ylabel = "Velocidad [m/s]",
        title = "Comparación de velocidad",
        label = "Sin conductor",
        linewidth = 2
    )

    plot!(
        plt,
        res_conductor.t,
        res_conductor.v,
        label = "Con conductor",
        linewidth = 2
    )

    return plt
end


function graficar_acel(res_conductor::resultados, res_sin_conductor::resultados)
    plt = plot(
        res_sin_conductor.t,
        res_sin_conductor.a,
        xlabel = "Tiempo [s]",
        ylabel = "Aceleración [m/s²]",
        title = "Comparación de aceleración",
        label = "Sin conductor",
        linewidth = 2
    )

    plot!(
        plt,
        res_conductor.t,
        res_conductor.a,
        label = "Con conductor",
        linewidth = 2
    )

    return plt
end


function graficar_fuerza(res_conductor::resultados)
    plt = plot(
        res_conductor.t,
        res_conductor.F,
        xlabel = "Tiempo [s]",
        ylabel = "Fuerza magnética [N]",
        title = "Fuerza magnética con conductor",
        label = "Con conductor",
        linewidth = 2
    )

    return plt
end

function graficar_FEM(res_conductor::resultados)
    plt = plot(
        res_conductor.t,
        res_conductor.FEM,
        xlabel = "Tiempo [s]",
        ylabel = "FEM total [V]",
        title = "FEM total inducida en el conductor",
        label = "FEM(t)",
        linewidth = 2
    )

    return plt
end

function animar_dipolo(res_conductor::resultados, ruta_gif::String)

   

    z = res_conductor.z
    
    z_min = minimum(z)
    z_max = maximum(z)

    #paso

    animar = @animate  for i in 1:10:length(res_conductor.t)

        plot(
            xlims  = (-0.05,0.05),
            ylims  = (z_min,z_max),
            xlabel = "x",
            ylabel = "z",
            legend  = false
        )

        scatter!([0], [z[i]], markershape = :square, markersize = 18, color = :red)

        plot!([-0.025,-0.025], [z_min, z_max], linewidth = 2, color = :blue, label = false)
        plot!([0.025,0.025], [z_min, z_max], linewidth = 2, color = :blue, label = false)
        plot!([-0.03,-0.03], [z_min, z_max], linewidth = 2, color= :blue, label = false)
        plot!([0.03,0.03], [z_min, z_max], linewidth = 2, color = :blue, label = false)


        

        
        

    end

    gif(animar, ruta_gif, fps = 30)

    return animar

end


function graficar(res_conductor::resultados, res_sin_conductor::resultados)

    carpeta_data = joinpath(@__DIR__, "..", "data")
    mkpath(carpeta_data)

    p1 = graficar_pos(res_conductor, res_sin_conductor)
    p2 = graficar_vel(res_conductor, res_sin_conductor)
    p3 = graficar_acel(res_conductor, res_sin_conductor)
    p4 = graficar_fuerza(res_conductor)
    p5 = graficar_FEM(res_conductor)
    
    savefig(p1, joinpath(carpeta_data, "posicion.png"))
    savefig(p2, joinpath(carpeta_data, "velocidad.png"))
    savefig(p3, joinpath(carpeta_data, "aceleracion.png"))
    savefig(p4, joinpath(carpeta_data, "fuerza.png"))
    savefig(p5, joinpath(carpeta_data, "FEM.png"))

    ruta_animacion = joinpath(carpeta_data, "animacion.gif")
    p6 = animar_dipolo(res_conductor, ruta_animacion)

    display(p1)
    display(p2)
    display(p3)
    display(p4)
    display(p5)
    display(p6)
    
end