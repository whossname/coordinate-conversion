defmodule CoordinateSystem do

  def get_definition(system) do
    case system do
      # user defined system
      { system_type, params } -> { system_type, params }

      # :ellipsoid, {major_radius, eccentricity}
      :airy -> { :ellipsoid, {6377563, 0.00667054}}
      :australian_national -> { :ellipsoid, {6378160, 0.006694542}}
      :bessel_1841 -> { :ellipsoid, {6377397, 0.006674372}}
      :bessel_1841_nambia -> { :ellipsoid, {6377484, 0.006674372}}
      :clarke_1866 -> { :ellipsoid, {6378206.4, 0.006768658}}
      :clarke_1880 -> { :ellipsoid, {6378249, 0.006803511}}
      :everest_1830_india -> { :ellipsoid, {6377276, 0.006637847}}
      :fischer_1960_mercury -> { :ellipsoid, {6378166, 0.006693422}}
      :fischer_1968 -> { :ellipsoid, {6378150, 0.006693422}}
      :grs_1967 -> { :ellipsoid, {6378160, 0.006694605}}
      :grs_1980 -> { :ellipsoid, {6378137, 0.00669438}}
      :helmert_1906 -> { :ellipsoid, {6378200, 0.006693422}}
      :hough -> { :ellipsoid, {6378270, 0.00672267}}
      :international -> { :ellipsoid, {6378388, 0.00672267}}
      :krassovsky -> { :ellipsoid, {6378245, 0.006693422}}
      :modified_airy -> { :ellipsoid, {6377340, 0.00667054}}
      :modified_everest -> { :ellipsoid, {6377304, 0.006637847}}
      :modified_fischer_1960 -> { :ellipsoid, {6378155, 0.006693422}}
      :south_american_1969 -> { :ellipsoid, {6378160, 0.006694542}}
      :wGS_60 -> { :ellipsoid, {6378165, 0.006693422}}
      :wGS_66 -> { :ellipsoid, {6378145, 0.006694542}}
      :wGS_72 -> { :ellipsoid, {6378135, 0.006694318}}
      :wGS_84 -> { :ellipsoid, {6378137, 0.00669438 }}
      :everest_1830_malaysia -> { :ellipsoid, {6377299, 0.006637847}}
      :everest_1956_india -> { :ellipsoid, {6377301, 0.006637847}}
      :everest_1964_malaysia_and_singapore -> { :ellipsoid, {6377304, 0.006637847}}
      :everest_1969_malaysia -> { :ellipsoid, {6377296, 0.006637847}}
      :everest_pakistan -> { :ellipsoid, {6377296, 0.006637534}}
      :indonesian_1974 -> { :ellipsoid, {6378160, 0.006694609}}

      # :map
      :utm -> { :transverse_mercator, { }}

    end
  end
end
