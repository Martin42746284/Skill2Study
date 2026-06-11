import { useState, useCallback } from "react";

const GEOCODING_CACHE = new Map<string, { lat: number; lng: number }>();

interface GeocodeResult {
  lat: number;
  lng: number;
}

export const useGeocoding = () => {
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const geocodeAddress = useCallback(
    async (address: string, city: string, country: string = "Madagascar"): Promise<GeocodeResult | null> => {
      if (!address && !city) return null;

      const cacheKey = `${address}|${city}|${country}`;

      // Check cache first
      if (GEOCODING_CACHE.has(cacheKey)) {
        return GEOCODING_CACHE.get(cacheKey)!;
      }

      try {
        setIsLoading(true);
        setError(null);

        const fullAddress = `${address || ""} ${city}, ${country}`.trim();

        if (!(window as any).google?.maps?.Geocoder) {
          console.warn("Google Maps Geocoder not loaded");
          return null;
        }

        const geocoder = new (window as any).google.maps.Geocoder();

        return new Promise((resolve) => {
          geocoder.geocode({ address: fullAddress }, (results: any[], status: string) => {
            if (status === "OK" && results && results.length > 0) {
              const location = results[0].geometry.location;
              const result = {
                lat: location.lat(),
                lng: location.lng(),
              };
              GEOCODING_CACHE.set(cacheKey, result);
              resolve(result);
            } else {
              if (status === "REQUEST_DENIED") {
                console.warn(
                  "Geocoding API not enabled. Enable 'Geocoding API' in Google Cloud Console: https://console.cloud.google.com/apis/library"
                );
              } else {
                console.warn(`Geocoding failed for ${fullAddress}:`, status);
              }
              resolve(null);
            }
          });
        });
      } catch (err) {
        const errorMsg = err instanceof Error ? err.message : "Geocoding failed";
        setError(errorMsg);
        console.error("Geocoding error:", err);
        return null;
      } finally {
        setIsLoading(false);
      }
    },
    []
  );

  return { geocodeAddress, isLoading, error };
};
