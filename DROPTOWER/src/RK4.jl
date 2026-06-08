

function derivadas(z,v,p::parametros)
    dz_dt = v
    dv_dt = desaceleracion(z,v,p)

    return dz_dt, dv_dt
end


function RK4(z,v,dt,p::parametros)


    #K's uno de v, z
    k1z,k1v = derivadas(z,v,p)
    #K's dos de v, z
    k2z,k2v = derivadas(z+0.5*dt*k1z, v+0.5*dt*k1v, p)
    #K's tres de v, z
    k3z,k3v = derivadas(z+0.5*dt*k2z, v+0.5*dt*k2v, p)
    #K's cuatro de v, z
    k4z,k4v = derivadas(z+dt*k3z, v+dt*k3v, p)

    z_nuevo = z + (dt/6)*(k1z+2*k2z+2*k3z+k4z)
    v_nuevo = v + (dt/6)*(k1v+2*k2v+2*k3v+k4v)

    return z_nuevo, v_nuevo


end