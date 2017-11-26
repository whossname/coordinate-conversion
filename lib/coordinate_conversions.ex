defmodule CoordinateConversions do

  def geodetic_to_geocentric({lat, lon}, geodetic_params) do
    a = elem(geodetic_params, 0)
    geodetic_to_geocentric({lat, lon, a}, geodetic_params)
  end

  def geodetic_to_geocentric({lat, lon, height}, {a, _, e, _}) do
    # prepare trig
    sin_lat = Math.sin(lat)
    cos_lat = Math.cos(lat)
    sin_lon = Math.sin(lon)
    cos_lon = Math.cos(lon)

    # aliase
    e2 = e * e

    # ν = a / √(1 − e² · sin²φ)
    v = 1 - e2 * sin_lat * sin_lat
    v = a / Math.sqrt(v)
    vh = v + height

    # x = (ν+h) · cosφ · cosλ	
    x = vh * cos_lat * cos_lon
    # y = (ν+h) · cosφ · sinλ	
    y = vh * cos_lat * sin_lon
    # z = ((1−e²)·ν + h) · sinφ
    z = ((1 - e2) * v + height) * sin_lat

    # return
    {x, y, z}
  end

  def helmert_transformation({xi, yi, zi}, {cx, cy, cz, s, rx, ry, rz}) do
    # assumes s has been pre calculated as (1 + s * 10^ -6)
    xo = cx + s * (xi - rz*yi + ry*zi)
    yo = cy + s * (yi + rz*xi - rx*zi)
    zo = cz + s * (zi - ry*xi + rx*zi)

    {xo, yo, zo}
  end

  def geocentric_to_geodetic({x, y, z}, {a, b, e, e_d}) do
    # using Kaplan's 15 step application of Ferrari's solution
    
    x2 = x * x
    y2 = y * y
    z2 = z * z

    a2 = a * a
    b2 = b * b
    e2 = e * e
    e4 = e2 * e2
    
    # 1 # r = √(x² + y²)
    r = Math.sqrt(x2 + y2)
    r2 = r * r

    # 2 #
    e_d2 = (a2 - b2) / b2

    # 3 #
    eE2 = a2 - b2

    # 4 #
    f = 54 * b2 * z2

    # 5 #
    g = r2 + (1 - e2)*z2 - e2*eE2

    # 6 #
    c = e4*f*r2 / g * g * g

    # 7 #
    s = 1 + c + Math.sqrt(c*c + 2*c)
    s = Math.nth_root(s, 3)

    # 8 #
    p = s + 1/s + 1
    p = 3 * p * p * g * g
    p = f / p

    # 9 #
    q = Math.sqrt( 1 + 2 * e4 * p)
    
    # 10 #
    r_0 = a2*(1 + 1/q)/2 - p*(1-e2)*z2/q/(1+q) - p*r2 / 2
    r_0 = -p*e2*r / (1+q) + Math.sqrt(r_0)

    # 11 #
    v = r - e2*r_0
    u = v * v + z2
    u = Math.sqrt( u ) 

    # 12 #
    v = v * v + (1 - e2) * z2
    v = Math.sqrt(v)

    # 13 #
    z_0 = b2*z/a/v

    # 14 #
    height = u * (1 - b2/a/v)

    # 15 #
    lat = Math.atan((z + e_d2 + z_0) / r)
    lon = Math.atan2(y, x)

    {lat, lon, height}
  end
end

