import { useState, useEffect, useCallback } from "react";

export interface FavoriteItem {
  id: number;
  type: "university" | "parcours";
  name: string;
  detail?: string; // city or field name
  savedAt: string;
}

const STORAGE_KEY = "orientai_favorites";

function loadFavorites(): FavoriteItem[] {
  try {
    return JSON.parse(localStorage.getItem(STORAGE_KEY) || "[]");
  } catch {
    return [];
  }
}

export function useFavorites() {
  const [favorites, setFavorites] = useState<FavoriteItem[]>(loadFavorites);

  useEffect(() => {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(favorites));
  }, [favorites]);

  const isFavorite = useCallback(
    (id: number, type: FavoriteItem["type"] = "university") =>
      favorites.some((f) => f.id === id && f.type === type),
    [favorites]
  );

  const toggleFavorite = useCallback(
    (item: Omit<FavoriteItem, "savedAt">) => {
      setFavorites((prev) => {
        const exists = prev.some((f) => f.id === item.id && f.type === item.type);
        if (exists) return prev.filter((f) => !(f.id === item.id && f.type === item.type));
        return [...prev, { ...item, savedAt: new Date().toISOString() }];
      });
    },
    []
  );

  const removeFavorite = useCallback(
    (id: number, type: FavoriteItem["type"] = "university") => {
      setFavorites((prev) => prev.filter((f) => !(f.id === id && f.type === type)));
    },
    []
  );

  return { favorites, isFavorite, toggleFavorite, removeFavorite };
}
