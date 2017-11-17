defmodule GeographicCoordinateConversion do
  alias CoordinateSystem
  alias Math

  @moduledoc """
  Documentation for GeographicCoordinateConversion.
  """

  @doc """
  Hello world.

  ## Examples

      iex> GeographicCoordinateConversion.hello
      :world

  """
  def convert({coordinates, from}, to) do
    # get definitions
    from = CoordinateSystem.get_definition(from)
    to   = CoordinateSystem.get_definition(to)

    # perfom calculation
    convert({coordinates, from}, to)
  end

  def convert({coordinates, {:ellipsoid, {from_radius, from_eccentricity}}},
              {:ellipsoid, to_radius, to_eccentricity}) do
    coordinates = 
      geodetic_to_geocentric(coordinates, from_radius, from_eccentricity)
      |> geocentric_to_geodetic(to_radius, to_eccentricity)
    {coordinates, {:ellipsoid, to_radius, to_eccentricity}}
  end

end
