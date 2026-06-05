import { useEffect, useCallback, useMemo, useState } from "react";
import DashboardLayout from "@/components/DashboardLayout";
import { GoogleMap, useJsApiLoader, MarkerF, InfoWindowF } from "@react-google-maps/api";
import { useTranslation } from "react-i18next";
import CityInfoPanel, { type CityMarker } from "@/components/map/CityInfoPanel";
import { universities as universitiesApi } from "@/lib/api";

const GOOGLE_MAPS_API_KEY = "AIzaSyCUCVQFDdvhG6p6jYLgGEmF39-0ArZqz1I";

const mapContainerStyle = {
  width: "100%",
  height: "100%",
  borderRadius: "0.75rem",
};

const center = { lat: -18.9, lng: 47.5 };

const mapOptions: google.maps.MapOptions = {
  zoom: 6,
  mapTypeControl: true,
  streetViewControl: false,
  fullscreenControl: true,
  styles: [
    { featureType: "water", elementType: "geometry.fill", stylers: [{ color: "#dbeafe" }] },
    { featureType: "landscape", elementType: "geometry.fill", stylers: [{ color: "#f0fdf4" }] },
    { featureType: "poi", stylers: [{ visibility: "off" }] },
  ],
};

const cityCoordinates: Record<string, { lat: number; lng: number }> = {
  Antananarivo: { lat: -18.8792, lng: 47.5079 },
  Toamasina: { lat: -18.1492, lng: 49.4023 },
  Fianarantsoa: { lat: -21.4417, lng: 47.0833 },
  Mahajanga: { lat: -15.7167, lng: 46.3167 },
  Toliara: { lat: -23.35, lng: 43.6667 },
  Antsiranana: { lat: -12.2795, lng: 49.2913 },
  Antsirabe: { lat: -19.8659, lng: 47.0333 },
  "Fénérive-Est": { lat: -17.3067, lng: 49.4167 },
  Ambositra: { lat: -20.5133, lng: 47.1333 },
  Ambalavao: { lat: -21.8167, lng: 46.65 },
  Antsohihy: { lat: -14.6833, lng: 47.9833 },
  Morondava: { lat: -20.2833, lng: 44.3167 },
  "Fort-Dauphin": { lat: -25.0356, lng: 46.9975 },
  Sambava: { lat: -16.7667, lng: 49.9833 },
};

interface MapUniversity {
  id: number;
  nom: string;
  type: string;
  ville: string;
  wilaya?: string | null;
  site_web?: string | null;
  telephone?: string | null;
  logo_url?: string | null;
  filieres?: Array<any>;
}

const mapCityMarkers = (items: MapUniversity[]): CityMarker[] => {
  const cityMap = new Map<string, CityMarker>();

  items.forEach((uni) => {
    const cityName = uni.ville;
    const coords = cityCoordinates[cityName] || cityCoordinates.Antananarivo;

    if (!cityMap.has(cityName)) {
      cityMap.set(cityName, {
        id: cityName.toLowerCase().replace(/\s+/g, "-"),
        name: cityName,
        lat: coords.lat,
        lng: coords.lng,
        universities: [],
      });
    }

    cityMap.get(cityName)!.universities.push({
      id: uni.id,
      nom: uni.nom,
      type: uni.type,
      ville: uni.ville,
      wilaya: uni.wilaya,
      site_web: uni.site_web,
      telephone: uni.telephone,
      logo_url: uni.logo_url,
      filieres: Array.isArray(uni.filieres) ? uni.filieres : [],
    });
  });

  return Array.from(cityMap.values()).sort((a, b) => a.name.localeCompare(b.name));
};

const MapExplorer = () => {
  const { t } = useTranslation();
  const [selectedCity, setSelectedCity] = useState<CityMarker | null>(null);
  const [hoveredCity, setHoveredCity] = useState<string | null>(null);
  const [cities, setCities] = useState<CityMarker[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const { isLoaded, loadError } = useJsApiLoader({
    googleMapsApiKey: GOOGLE_MAPS_API_KEY,
  });

  useEffect(() => {
    let cancelled = false;

    const loadUniversities = async () => {
      try {
        setLoading(true);
        const response = await universitiesApi.getAll(1, 10000);
        const items = Array.isArray(response?.universites) ? response.universites : [];
        if (!cancelled) {
          setCities(mapCityMarkers(items));
          setSelectedCity(null);
          setHoveredCity(null);
          setError(null);
        }
      } catch (err) {
        if (!cancelled) {
          setError(err instanceof Error ? err.message : t("mapExplorer.mapError"));
        }
      } finally {
        if (!cancelled) setLoading(false);
      }
    };

    loadUniversities();
    return () => {
      cancelled = true;
    };
  }, [t]);

  const totalUnis = useMemo(() => cities.reduce((sum, city) => sum + city.universities.length, 0), [cities]);

  const onMarkerClick = useCallback((city: CityMarker) => {
    setSelectedCity((prev) => (prev?.id === city.id ? null : city));
  }, []);

  if (loadError) {
    return (
      <DashboardLayout>
        <div className="flex items-center justify-center h-96 text-destructive">
          {t("mapExplorer.mapError")}
        </div>
      </DashboardLayout>
    );
  }

  return (
    <DashboardLayout>
      <div className="animate-fade-in fixed inset-0 flex flex-col overflow-hidden pt-14 lg:pt-0 lg:pl-64">
        {/* Header - sticky */}
        <div className="px-3 sm:px-4 md:px-6 lg:px-8 py-3 sm:py-4 shrink-0 border-b bg-background">
          <h1 className="text-2xl sm:text-3xl font-bold">{t("mapExplorer.title")}</h1>
          <p className="mt-1 text-xs sm:text-sm text-muted-foreground">
            {loading ? t("mapExplorer.loading") : t("mapExplorer.subtitle", { count: totalUnis, cities: cities.length })}
          </p>
        </div>

        {error ? (
          <div className="px-3 sm:px-4 md:px-6 lg:px-8 py-2 shrink-0">
            <div className="rounded-xl border bg-card p-3 sm:p-4 text-xs sm:text-sm text-destructive shadow-sm">
              {error}
            </div>
          </div>
        ) : null}

        {/* Main content area - Map + Side panel */}
        <div className="flex flex-1 overflow-hidden min-h-0">
          {/* Map container - Fixed and fills entire space */}
          <div className="flex-1 overflow-hidden">
            {loading ? (
              <div className="flex items-center justify-center h-full text-xs sm:text-sm text-muted-foreground px-4">
                {t("mapExplorer.loadingMap")}
              </div>
            ) : !isLoaded ? (
              <div className="flex items-center justify-center h-full text-xs sm:text-sm text-muted-foreground px-4">
                {t("mapExplorer.loadingMap")}
              </div>
            ) : (
              <GoogleMap
                mapContainerStyle={mapContainerStyle}
                center={center}
                zoom={6}
                options={mapOptions}
              >
                {cities.map((city) => (
                  <MarkerF
                    key={city.id}
                    position={{ lat: city.lat, lng: city.lng }}
                    onClick={() => onMarkerClick(city)}
                    onMouseOver={() => setHoveredCity(city.id)}
                    onMouseOut={() => setHoveredCity(null)}
                    label={
                      city.universities.length > 1
                        ? {
                            text: String(city.universities.length),
                            color: "white",
                            fontWeight: "bold",
                            fontSize: "11px",
                          }
                        : undefined
                    }
                  >
                    {hoveredCity === city.id && selectedCity?.id !== city.id && (
                      <InfoWindowF
                        position={{ lat: city.lat, lng: city.lng }}
                        onCloseClick={() => setHoveredCity(null)}
                      >
                        <div className="p-1 text-xs font-medium text-foreground">
                          <p className="font-bold">{city.name}</p>
                          <p className="text-muted-foreground">
                            {city.universities.length} {t("mapExplorer.universities")}
                          </p>
                        </div>
                      </InfoWindowF>
                    )}
                  </MarkerF>
                ))}
              </GoogleMap>
            )}
          </div>

          {/* Side panel - Scrollable */}
          {/* Desktop: Fixed sidebar | Mobile: Modal overlay */}
          <div className="hidden lg:flex lg:w-96 lg:flex-col lg:border-l lg:bg-card lg:overflow-hidden">
            <div className="flex-1 overflow-y-auto pr-2">
              <CityInfoPanel selectedCity={selectedCity} onClose={() => setSelectedCity(null)} />
            </div>
          </div>

          {/* Mobile: Panel as overlay */}
          {selectedCity && (
            <div className="fixed inset-0 lg:hidden flex flex-col bg-background z-50">
              {/* Mobile header */}
              <div className="flex items-center justify-between px-3 sm:px-4 py-3 sm:py-4 border-b bg-background shrink-0">
                <h2 className="text-lg sm:text-xl font-semibold">{selectedCity.name}</h2>
                <button
                  onClick={() => setSelectedCity(null)}
                  className="inline-flex items-center justify-center rounded-md hover:bg-muted text-muted-foreground hover:text-foreground transition-colors"
                >
                  <svg className="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>
              </div>
              {/* Mobile panel content */}
              <div className="flex-1 overflow-y-auto">
                <CityInfoPanel selectedCity={selectedCity} onClose={() => setSelectedCity(null)} />
              </div>
            </div>
          )}
        </div>
      </div>
      {/* Empty placeholder for DashboardLayout wrapper */}
      <div className="invisible"></div>
    </DashboardLayout>
  );
};

export default MapExplorer;
